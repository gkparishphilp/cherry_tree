# == Schema Information
# Schema version: 20101209043322
#
# Table name: attachments
#
#  id              :integer(4)      not null, primary key
#  owner_id        :integer(4)      not null
#  owner_type      :string(255)     not null
#  attachment_type :string(255)
#  name            :string(255)
#  format          :string(255)
#  path            :string(255)
#  filesize        :string(255)
#  origin          :string(255)
#  ip              :string(255)
#  remote          :boolean(1)
#  status          :string(255)     default("active")
#  created_at      :datetime
#  updated_at      :datetime
#

class Attachment < ActiveRecord::Base
	include HasAttachments::AttachmentLib
	
	validates	:name, :uniqueness => { :scope => [:owner_id, :owner_type, :attachment_type] }
	
	belongs_to :owner, :polymorphic => true
	
	scope :for_owner, lambda { |owner| where( ["owner_id = ? AND owner_type = ?", 
									owner.id, owner.class.name ] ) }
	scope :by_type, lambda { |type| where( "attachment_type = ?", type ) }						
	
	scope :active, where( "status = 'active'" )
	
	
	# Class methods
	def self.recent( since = 1.week.ago )
		where( "created_at > ?", since )
	end
	
	def self.create_from_resource( resource, type, opts={} )
		if resource =~ /\Ahttp:\/\//
			name, ext = Attachment.new.parse_name( resource )
		else
			name, ext = Attachment.new.parse_name( resource.original_filename )
		end

		attachment = Attachment.new :name => name, :format => ext, :attachment_type => type
		attachment.owner = opts[:owner] if opts[:owner]
		
		if opts[:remote] == 'true'
			attachment.remote = true
			attachment.path = resource
			attachment.save if attachment.valid?
			return attachment
		end
		
		if attachment.valid?
			path = attachment.create_path( opts )
		
			name = "#{attachment.name}.#{attachment.format}"
			write_path = File.join( path, name )
			if resource =~ /\Ahttp:\/\//
				image = MiniMagick::Image.open( resource )
				image.write( write_path )
			else
				post = File.open( write_path,"wb" ) { |f| f.write( resource.read ) }
			end
			
			filesize = File.size( write_path )
		
			attachment.filesize = filesize
			attachment.path = path
		end
		
		attachment.save
		
		return attachment
	end
	
	
	# instance methods
	def location( style=nil, opts={} )
		if self.remote
			return self.path
		end
		rel_path = self.path
		rel_path = self.path.gsub( /\A.+public/, "" ) unless opts[:full] == true
		style ? "#{rel_path}#{self.name}_#{style}.#{self.format}" : "#{rel_path}#{self.name}.#{self.format}"
	end
	
	
	def update_from_resource( resource, opts={} )
		
		self.remote = false
		
		if opts[:remote] == 'true'
			self.remote = true
			self.path = resource
			self.save if self.valid?
			return self
		end
		
		if resource =~ /\Ahttp:\/\//
			name, ext = self.parse_name( resource )
		else
			name, ext = self.parse_name( resource.original_filename )
		end
		
		if self.valid?
			path = self.create_path( opts )
		
			ext_name = "#{name}.#{ext}"
			write_path = File.join( path, ext_name )
			
			self.trash( path )
			
			if resource =~ /\Ahttp:\/\//
				image = MiniMagick::Image.open( resource )
				image.write( write_path )
			else
				post = File.open( write_path,"wb" ) { |f| f.write( resource.read ) }
			end
			
			if filesize = File.size( write_path ) # the write was successful
				self.empty_trash( path )
				self.update_attributes :filesize => filesize, :path => path, :name => name, :format => ext
			else
				self.retore_trash( path )
			end
		end
		
		return self
		
	end
	
	def trash( path )
		# takes contents of passed dir and moves them to a temp location in preparation
		# for deletion
		tmp_path = "#{path}tmp"
		create_directory( tmp_path )
		FileUtils.mv Dir.glob( "#{path}*.*" ), tmp_path
	end
	
	def empty_trash( path )
		# actually nukes trashed files
		tmp_path = "#{path}tmp"
		FileUtils.rm_r ( tmp_path )
	end
	
	def restore_trash( path )
		# restores trashed files to their original location
		tmp_path = "#{path}tmp"
		FileUtils.mv Dir.glob( "#{tmp_path}*.*" ), path
		FileUtils.rm_r ( tmp_path )
	end
	
	def create_path( opts={} )
		# use public save path by default
		directory = "#{PUBLIC_ATTACHMENT_PATH}"
		# unless the parent object has declared a default path for this attachment_type
		directory = eval "self.owner.#{self.attachment_type}_path" if self.owner.respond_to? "#{self.attachment_type}_path"
		# but a specific private request to this method trumps either
		directory = "#{PRIVATE_ATTACHMENT_PATH}" if opts[:private] == 'true'
	
		directory += "/#{self.owner_type.pluralize}/#{self.owner_id}/#{self.attachment_type.pluralize}/"
	
		directory = create_directory( directory )
	end
	
	def active?
		self.status == 'active'
	end
	
	def nuke
		self.update_attributes( :status => 'deleted' )
	end
	
	def nuke!
		self.update_attributes( :status => 'deleted' )
		self.trash( self.path )
		self.empty_trash( self.path )
	end
	
	def process_resize( styles )
		for style_name, style_detail in styles
			
			directory = self.path
			orig_filename = "#{self.name}.#{self.format}"
			output_filename = "#{self.name}_#{style_name}.#{self.format}"
			
			input_path = File.join( directory, orig_filename )
			output_path = File.join( directory, output_filename )
			
			image = MiniMagick::Image.open( input_path )
			image.resize style_detail
			image.write  output_path
			
		end
	end
	
	def parse_name( name )
		# gets the file-name and file-extension from a url or filepath
		if name =~ /\Ahttp:\/\//
			full_name = name.match( /[\w?.-]+\z/ ).to_s
			full_name.gsub!( /\?.+\z/, "" ) #try to strip args if any
		else
			# one or more digit, word char, parens, or dash, then a dot, then one or more any char then end of string
			full_name = name.match( /[\d\w\(\)-]+\..+\z/ ).to_s 
		end
		ext = full_name.match( /\w+\z/ ).to_s.downcase # any number of word chars following non-word (ie period), then eol
		name = full_name.match( /[_ ',;:+=|()!\?\d\w-]+\./ ).to_s.chop.downcase

		return name, ext
	
	end
	
	
end
