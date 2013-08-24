class Visitor < ActiveRecord::Base
  attr_accessible :last_visitor, :visitor_time, :status
		
	scope :active, lambda {where("status=1")}

	def self.authenticate_by_token(id)
		Visitor.find_by_id(id)
	end

end
