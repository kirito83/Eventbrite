class EventsController < ApplicationController
	before_destroy :destroy_created_events

	def new
		if logged_in?
			@event = Event.new
		else
			redirect_to login_path
		end
	end

	def create
		if logged_in?
			@user = current_user
			@event = @user.created_events.new(event_params)
			if @event.save
				flash[:success] = "L'événement a bien été créé !"
				redirect_to current_user
				@event.attendees << current_user
				@event.save
			else
				render 'new'
				flash.now[:error] = "Un problème est survenu. L'événement n'a pas été créé"
			end
		end
	end

	def show
		@event = Event.find(params[:id])
		@users = User.all
	end

	def index
		@events = Event.all
	end

	def edit
		@user =  current_user
		@event = Event.find(params[:id])
		if logged_in? && current_user == @user
			edit_event_path
		else
			redirect_to login_path
		end
	end

	def update
		@user = current_user
		@event = Event.find(params[:id])
		if logged_in? && @current_user == @user
			if @event.update_attributes(event_params)
				flash[:success] = "Soirée editée !"
				redirect_to event_path
			else
				flash[:error] = "Vous n'etes pas le créateur de la soirée."
				render 'edit'
			end
		else
			redirect_to login_path
		end
	end

	def suscribe
		if logged_in?
			@event = Event.find(params[:id])
			@event.attendees << current_user
			@event.save
			flash[:success] = "Vous êtes inscrit à la soirée !"
			redirect_to events_path
		else
			falsh[:error] = "Vous devez vous connecter pour vous inscrire à la soirée."
			redirect_to login_path
		end
	end

	def unsuscribe
		@event = Event.find(params[:id])
		@event.attendees.delete(current_user)
		@event.save
		flash[:success] = "Vous êtes désinscrit."
		redirect_to current_user
	end

	def invite
		@event = Event.find(params[:id])
		@user = User.find(params[:user])
		@event.attendees << @user
		@event.save
		flash[:success] = "Vous avez ajouté votre ami à la soirée !"
		redirect_to @event
	end

	def destroy
		@user = current_user
		@event = Event.find(params[:id])
		@event.destroy
		flash[:success] = "La soirée a été supprimée."
		redirect_to @current_user
	end

	private
	def event_params
		params.require(:event).permit(:name, :description, :date, :place)
	end
	def destory_created_events
		self.created_events.destroy_all
	end
end
