class Event < ApplicationRecord
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	has_and_belongs_to_many :attendees, class_name: 'User'

	validates :name,  presence: true
	validates :description,  presence: true
	validates :date,  presence: true
	validates :place, presence: true
end
