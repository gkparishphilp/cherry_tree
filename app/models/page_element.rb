class PageElement < ActiveRecord::Base
	belongs_to	:page, :polymorphic => true
end