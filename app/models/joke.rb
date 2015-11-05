class Joke < ActiveRecord::Base
	validates :content, presence: true

	def self.next_unvote_joke(voted_jokes)
		Joke.where.not(id: voted_jokes).first
	end
end