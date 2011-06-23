# == Schema Information
# Schema version: 20110420185439
#
# Table name: objective_assignments
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  objective_id       :integer(4)
#  creator_id         :integer(4)
#  award_asignment_id :integer(4)
#  description        :text
#  priority           :integer(4)
#  times              :integer(4)
#  period             :string(255)
#  due_at             :datetime
#  req_checkin        :boolean(1)      default(TRUE)
#  req_confirm        :boolean(1)      default(TRUE)
#  point_value        :integer(4)      default(100)
#  status             :string(255)     default("active")
#  created_at         :datetime
#  updated_at         :datetime
#

class ObjectiveAssignment < ActiveRecord::Base
	
	validates	:point_value, :numericality => { :greater_than => 0 }
	
	belongs_to	:user
	belongs_to	:objective
	belongs_to	:creator, :foreign_key => :creator_id, :class_name => 'User'
	
	has_many	:point_earnings, :as => :earned_for
	has_many	:checkins
	has_many	:approvals
	
	has_many	:comments, :as => :commentable
	
	attr_accessor	:objective_name, :objective_description # so we can create objectives from the objective_assignment screen
	
	scope :available, where( "status <> 'deleted'" ) 
	scope :active, where( "status = 'active'" )
	
	def active?
		self.status == 'active'
	end

	def checkin_in_last?( period = 1.day.ago ) 
		return  self.checkins.dated_between( period, Time.now ).present?
	end
	
	def earned_for_period
		start_time = self.get_period_start_time
		if self.point_earnings.dated_between( start_time, Time.now ).count > 0
			return true
		else
			return false
		end
	end
	
	def get_period_start_time
		case self.period
		when 'day'
			start_time = Time.now.beginning_of_day
		when 'week'
			start_time = Time.now.beginning_of_week
		when 'month'
			start_time = Time.now.beginning_of_month
		when nil
			start_time = nil
		end
	end
	
	def approve_checkins_dated_between( start_time, end_time, approver )
		for checkin in self.checkins.dated_between(start_time, end_time)
			checkin.approval.present? ? checkin.approval.status = 'approved' : Approval.create( :checkin_id => checkin.id, :creator_id => approver.id, :status => 'approved' )
		end
	end
	
	def approved_for_week( week )
		self.approvals.for_week( week ).count > 0 ? true : false
	end
	
	def third_person_gerund
		msg = self.objective.name.gsub( /your/, self.user.pronoun_gender_possessive )
		first_word = msg.match( /\A\w+/ ).to_s
		
		first_word.chop! if first_word.last == 'e'
		first_word += 'ing'
		
		return msg.gsub( /\A\w+/, first_word )
		
	end
	
end
