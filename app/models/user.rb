class User < ActiveRecord::Base
	belongs_to :organization
	has_many :tasks
	accepts_nested_attributes_for :organization
	validates :email, uniqueness: true
	has_secure_password
end
