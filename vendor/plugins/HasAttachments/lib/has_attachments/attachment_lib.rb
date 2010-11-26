module HasAttachments
	module AttachmentLib
	
	# put needed library code here
	def create_directory( directory )
		node_array = directory.split('/')
		directory = ""
		for node in node_array do
			directory += "#{node}/"
			next if File.exists? directory
			Dir.mkdir( directory )
		end
		return directory
	end
	
	end
end