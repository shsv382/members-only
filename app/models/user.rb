class User < ApplicationRecord
	has_many :posts
	has_secure_password
	validates :name, presence: true, length: {maximum: 50}
	validates :password, length: {minimum: 6}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates 	:email, presence: true, 
				format: { with: VALID_EMAIL_REGEX }, 
				uniqueness: { case_sensitive: false } 

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token)
	end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	private
	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
