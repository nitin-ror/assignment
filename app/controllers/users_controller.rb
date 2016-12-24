class UsersController < ApplicationController
	
	before_filter :authenticate_user!
	
	def index
		if current_user.admin?
			@users = User.all
		else
			redirect_to root_path
		end
	end
	
	def show
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update_attributes(user_params)
			redirect_to user_path(@user.id)
		else
			render :action => 'edit'
		end
	end

	protected

	def user_params
		params.require(:user).permit!
	end
end
