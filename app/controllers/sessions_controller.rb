class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user
			log_in user
			redirect_to user
		else
			flash.now[:danger] = 'Email ou mot de passe incorrect.'
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end

end
