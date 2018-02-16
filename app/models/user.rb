class User < ApplicationRecord
	has_many :created_events, class_name: 'Event'
	has_and_belongs_to_many :attended_events, class_name: 'Event'

	attr_accessor :sign_up_code
	validates :sign_up_code,
		on: :create,
		presence: true,
		inclusion: {in: ["FIOLAXIE2"]}

	before_save { self.email = email.downcase }
	validates :name,  
		presence: true, 
		length: { maximum: 50 }, 
		uniqueness: { case_sensitive: false }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, on: :create
	has_secure_password

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
