class ApisController < ApplicationController
	def index
		@users = User.all
		@visitors = Visitor.all
		respond_to do |format| 
			format.json {render :json => {:users => @users, :visitors => @visitors} }
		end
	end
end
