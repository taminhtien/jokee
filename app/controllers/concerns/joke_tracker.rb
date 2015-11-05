module JokeTracker
	extend ActiveSupport::Concern

	def mark_voted_joke(joke_id)
		voted_jokes << joke_id
	end

	def voted_jokes
		session[:voted_jokes] ||= []
	end
end