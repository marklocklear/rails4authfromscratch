class UsersController < ApplicationController
	def index
		organization = current_user.organization
		@users = organization.users
	end

	def new
		@user = User.new
		@user.build_organization
	end

	def create
		@user = User.new(user_params)
		#if user is already logged in set the organization
		if session[:user_id] != nil
			organization = current_user.organization
			@user.organization = organization
			if @user.save
				redirect_to users_path, notice: "User Created!"
			else
				render "add"
			end
		elsif @user.save and session[:user_id] == nil
			session[:user_id] = @user.id
			redirect_to root_url, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and
																										params[:user][:password_confirmation].blank?
    if @user.update(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
	def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to users_path
    end
	end

	def add
		@user = User.new
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, organization_attributes: [:name])
	end
end
