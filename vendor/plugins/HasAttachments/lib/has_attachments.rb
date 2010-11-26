# HasAttachments

require File.dirname(__FILE__) + '/has_attachments/attachments'
require File.dirname(__FILE__) + '/has_attachments/attachment_lib'

ActiveRecord::Base.send( :include, HasAttachments::Attachments )
