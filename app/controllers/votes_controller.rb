class VotesController < ApplicationController
	include JokeTracker
	before_action :check_voted_joke, only: [:new]

	def new
		@vote = current_joke.votes.new
	end

	def create
		@vote = current_joke.votes.build(vote_params)
		if @vote.save
			update_current_joke
			mark_voted_joke(current_joke.id)
			redirect_to_next_unvoted_joke
		else
			render :new
		end
	end

	def goodbye
	end

	private

		def joke_id
			params[:joke_id]
		end

		def vote_params
			params.require(:vote).permit(:like)
		end

		def current_joke
			if params[:joke_id].present?
				Joke.find(params[:joke_id])
			else
				Joke.first
			end
		end

		def update_current_joke
			if params[:vote][:like]
				current_joke.increase_like
			else
				ap params[:vote][:like], plain: true
				current_joke.increase_dislike
			end
		end

		def redirect_to_next_unvoted_joke
			next_joke = Joke.next_unvoted_joke(voted_jokes)
			if next_joke.present?
				redirect_to new_joke_vote_path(next_joke.id)
			else
				redirect_to goodbye_votes_url
			end
		end

		def check_voted_joke
			redirect_to_next_unvoted_joke if voted_jokes.include? current_joke.id
		end
end