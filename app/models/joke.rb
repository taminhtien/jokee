class Joke < ActiveRecord::Base
	validates :content, presence: true

	def self.next_unvote_joke(voted_jokes)
		Joke.where.not(id: voted_jokes).first
	end

	def increase_like
		update_attributes(like: like + 1)
	end

	def increase_dislike
		update_attributes(dislike: dislike + 1)
	end
end