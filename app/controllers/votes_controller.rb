class VotesController < ApplicationController
	def new
	end

	def create
		@vote = Vote.new(vote_params)
		if @vote.save
			update_current_joke
			mark_voted_joke
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
			params.require(:vote).permit(:like).merge!(joke_id: joke_id)
		end

		def current_joke
			Joke.find(params[:joke_id])
		end

		def update_current_joke
			if params[:vote][:like]
				current_joke.increase_like
			else
				ap params[:vote][:like], plain: true
				current_joke.increase_dislike
			end
		end

		def mark_voted_joke
			voted_jokes << current_joke.id
		end

		def voted_jokes
			session[:voted_jokes] ||= []
		end

		def redirect_to_next_unvoted_joke
			next_joke = Joke.next_unvoted_joke(voted_jokes)
			if next_joke.present?
				redirect_to new_joke_vote_path(next_joke.id)
			else
				redirect_to goodbye_votes_url
			end
		end
end