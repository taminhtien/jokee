class Vote < ActiveRecord::Base
	belongs_to :joke
	validates :like, :joke, presence: true
end