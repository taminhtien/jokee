class Vote < ActiveRecord::Base
	belongs_to :joke
	validates :joke, presence: true
	validates :like, inclusion: [true, false]
end