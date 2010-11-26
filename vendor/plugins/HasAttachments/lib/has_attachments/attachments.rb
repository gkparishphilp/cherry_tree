module HasAttachments #:nodoc:
	module Attachments

		def self.included( base )
			base.extend ClassMethods
		end

		module ClassMethods
			# Class methods go here
			def has_attached( attachment_type, opts = {} )

				include HasAttachments::Attachments::InstanceMethods
				include HasAttachments::AttachmentLib
				
				has_many :attachments, :as => :owner, :dependent => :destroy

				attachment_type = attachment_type.to_s
				unless self.respond_to? attachment_type
					# refactor out to a singular? method on String
					if attachment_type.singularize == attachment_type
						self.class_eval do
							has_one "#{attachment_type}".to_sym, :as => :owner, :dependent => :destroy, :class_name => "Attachment", :conditions => [ "attachment_type = ?", attachment_type ]
						end
					else
						self.class_eval do
							has_many "#{attachment_type}".to_sym, :as => :owner, :dependent => :destroy, :class_name => "Attachment", :conditions => [ "attachment_type = ?", attachment_type ]
						end
					end	
				end
				
				if opts[:private] == true
					self.class_eval <<-END
						def #{attachment_type}_path
							return PRIVATE_ATTACHMENT_PATH
						end
					END
				else
					self.class_eval <<-END
						def #{attachment_type}_path
							return PUBLIC_ATTACHMENT_PATH
						end
					END
				end
				
				# There has to be a better way to do this....
				# The problem is that validations apply on an instance-by-instance basis, but 
				# they are implemented at the class level.  So, I'm just hacking together a custom
				# before_save filter and calling it only if the object's type matches
				if opts[:formats]
					Attachment.class_eval <<-END
						# Just in case we need to access or print them...
						def valid_#{attachment_type}_formats
							return #{opts[:formats]}
						end
						def validate_#{attachment_type}_format
							unless #{opts[:formats]}.include? self.format
								self.errors.add( :format, "invalid format" ) 
								return false
							else
								return true
							end
						end
					END
					Attachment.instance_eval <<-END
						validate :validate_#{attachment_type}_format, :if => "self.attachment_type == '#{attachment_type}'"
					END
				end
				
				
				if opts[:process]
					for action, styles in opts[:process] do
						# define these in the Attachment Model as process_action methods e.g. process_resize, process_transcode, etc.
						Attachment.class_eval <<-END
							def call_process_#{action}
								process_#{action}( #{styles}) unless self.remote
							end
	
						END
						Attachment.instance_eval <<-END
							after_save :call_process_#{action}, :if => "self.attachment_type == '#{attachment_type}'"
						END
						# just for giggles, let's see if we can add the widths as instance methods
						for style_name, style_detail in styles
							Attachment.class_eval <<-END
								def #{style_name}_width
									return #{style_detail}
								end
							END
							# hah aaha ha that worked, and I'm totally hammered!
						end
						
					end
				end
				
			end
			
		end

		module InstanceMethods
			# Put instance methods here
			
			def has_attachments?
				return ( self.attachments.count > 0 ) ? true : false
			end
			
			def method_missing( m, *args )
				if m.to_s[/attach_(.+)/]
					type = $1
					obj = args.first
					self.attachments.create :attachment_type => $1
				elsif m.to_s[/has_attached_(.+)\?/]
					return ( self.attachments.by_type( $1 ).count > 0 ) ? true : false
				elsif  m.to_s[/attached_(.+)/]
					return self.attachments.by_type( $1 ) #eval "self.#{$1}"
				else
					super
				end
			end
			
		end
	
	
	end
end