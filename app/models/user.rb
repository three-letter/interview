#coding: utf-8

require 'digest/sha2'

class User < ActiveRecord::Base
	attr_accessible :login_count, :login_time, :name, :password, :pwd, :pwd_confirmation, :last_login_time
	attr_accessor :pwd

	validates :name, :presence => { :message => "用户名不能为空!" },
		:uniqueness => { :message => "用户名已经存在!" }
	validates :pwd, :presence => { :on => :create, :message => "密码不能为空" },
		:confirmation => { :message => "两次密码不一致" }


	before_save :encrypt_password

	def self.authenticate(username,psd)
		user = User.find_by_name(username)
		if user
			user = nil unless user.has_password?(psd)
		end
		user
	end

	def self.authenticate_by_token(id, salt)
		user = User.find_by_id(id)
		(user && user.salt == salt) ? user : nil
	end



	def has_password?(psd)
		password == encrypt(psd)
	end

	private
	def encrypt_password
		unless pwd.blank?
			self.salt = "#{Time.now.to_i + rand(10000)}" if new_record?
			self.password = encrypt(pwd)
		end
	end

	def encrypt(str)
		Digest::SHA2.hexdigest("#{salt}_#{str}")
	end
end
