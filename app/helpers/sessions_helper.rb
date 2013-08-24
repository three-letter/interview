#coding: utf-8

module SessionsHelper
	
	def visitor_in?
		!current_visitor.nil?
	end

	def visitor_in visitor
		cookies.permanent.signed[:visitor] = visitor.id
	end

	def current_visitor
		@current_visitor ||= visitor_from_token 
	end
	
	def visitor_out visitor
		visitor_time = (Time.now - visitor.last_visitor).to_i
		visitor.visitor_time += visitor_time
		visitor.status = 0
		visitor.save
	end

	
	def signin user
		cookies.permanent.signed[:token] = [user.id, user.salt]
		user.login_count += 1
		user.last_login_time = Time.now
		user.status = 1
		user.save
	end

	def current_user
		@current_user ||= user_from_token
	end

	def sign_in?
		!current_user.nil?
	end

	def logout user
		@current_user = nil
		cookies.permanent.signed[:token] = [nil, nil]
		login_time = (Time.now - user.last_login_time).to_i
		user.login_time += login_time
		user.status = 0
		user.save
	end

	def authentication
		unless sign_in?
			session[:last_url] = request.url
			redirect_to login_path
		end
	end


	private
	def user_from_token
		User.authenticate_by_token(*token)
	end
	def token
		cookies.signed[:token] || [nil, nil]
	end


	def visitor_from_token
		Visitor.authenticate_by_token(visitor_token)
	end
	def visitor_token
		cookies.signed[:visitor] || nil
	end
end
