class UsersController < ApplicationController
	before_action :login_required, except:[:new,:create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Bienvenue dans la famille !"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
		if logged_in? && current_user == @user
			user_path
		else
			redirect_to login_path
		end
	end

	def update
		@user = User.find(params[:id])
		if logged_in? && @current_user == @user
			if @user.update_attributes(user_params)
				flash[:success] = "Profil modifié !"
				redirect_to user_path
			else
				render 'edit'
			end
		else
			redirect_to login_path
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		log_out
		flash[:success] = "Ton compte a bien été supprimé."
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:id, :name, :email, :password_digest, :password, :password_confirmation)
	end
end
