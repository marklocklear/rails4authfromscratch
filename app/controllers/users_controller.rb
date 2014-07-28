class UsersController < ApplicationController
	def new
		@user = User.new
		@user.build_organization
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_url, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, organization_attributes: [:name])
	end
end
