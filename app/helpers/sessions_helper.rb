module SessionsHelper

	def sign_in user
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def sign_out user
		remember_token = User.new_remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = 0
		if cookies[:remember_token]
			remember_token = User.encrypt(cookies[:remember_token])
		end
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user? user
		user == current_user
	end

end
