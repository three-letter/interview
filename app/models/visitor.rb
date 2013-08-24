class Visitor < ActiveRecord::Base
  attr_accessible :last_visitor, :visitor_time

	def self.authenticate_by_token(id)
		Visitor.find_by_id(id)
	end

end
