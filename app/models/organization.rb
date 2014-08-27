class Organization < ActiveRecord::Base
	has_many :users
	has_many :tasks, through: :users
	validates :name, uniqueness: true
end
