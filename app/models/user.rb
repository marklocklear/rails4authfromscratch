class User < ActiveRecord::Base
	belongs_to :organization
	accepts_nested_attributes_for :organization
	has_secure_password
end
