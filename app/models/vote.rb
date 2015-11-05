class Vote < ActiveRecord::Base
	belongs_to :joke
	validates :like, :dislike, :joke, presence: true
end