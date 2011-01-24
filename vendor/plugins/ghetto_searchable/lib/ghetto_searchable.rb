# GhettoSearchable
require File.dirname(__FILE__) + '/ghetto_searchable/searchable'

ActiveRecord::Base.send( :include, GhettoSearchable::Searchable )
