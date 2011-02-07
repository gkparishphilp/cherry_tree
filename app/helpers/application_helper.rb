module ApplicationHelper
	
	def avatar_tag( obj, style=nil, opts={} )
		tag = image_tag( "/images/default_avatar.png", :width => opts[:width] )
		if style
			style = style.to_s
			tag = image_tag( obj.avatar.location( style ), :width => opts[:width] ) if obj.attachments.by_type( 'avatar' ).count > 0 
		else
			tag = image_tag( obj.avatar.location, :width => opts[:width] ) if obj.attachments.by_type( 'avatar' ).count > 0 
		end
		
		return tag
	end
	
	def format_date( date )
		date.strftime("%b %d, %Y @ %l:%M%p")
	end
	  
	def format_date_only( date )
		date.strftime("%b %d, %Y")
	end
	
	def get_description
		description = @description.blank? ? APP_DESCRIPTION : @description[0..200]
		"<meta name='description' content='#{description}' />".html_safe
	end
	
	def get_title
		if @title
			title = "Cherry Tree | " + @title
		else
			title = "Cherry Tree | " + controller.controller_name.capitalize
		end
		return title
	end
	
	
	def link_to_add_fields( name, f, association )
		new_object = f.object.class.reflect_on_association( association ).klass.new
		fields = f.fields_for( association, new_object, :child_index => "new_#{association}" ) do |builder|
			render( association.to_s + "/form", :f => builder )
		end
		link_to_function( name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")" )
	end
	
	
	def link_to_remove_fields( name, f )
		f.hidden_field( :_destroy ) + link_to_function( name, "remove_fields(this)" )
	end
	
	
	def possessize( text )
		text ||= ''

		text + case text[-1,1]#1.8.7 style
		when 's' then "'"
		else "'s"
		end
	end
	
	def separated_list( array, element, separator )
		element += "#{separator} " unless element.to_s == array.last.to_s
		return element
	end
	
	def snip( text, snip_at=200 )
		
		snip_at = 200 if snip_at.blank?
		
		return "&nbsp;" if text.nil?
		
		text.gsub!(%r{</?[^>]+?>}, '') #remove html tags?
		text.size <= snip_at ? text : text[0..snip_at] + ". . ."

	end 
	
	# For admin
	def sortable_header( column, title=nil )
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_dir}" : nil
		dir = column == sort_column && sort_dir == 'asc' ? 'desc' : 'asc'
		link_to title, params.merge( :sort => column, :dir => dir, :page => nil ), :class => css_class
	end
	
	
end

