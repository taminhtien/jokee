require 'rails_helper'

RSpec.describe Joke, type: :model do
	context 'Validation' do
		it { is_expected.to validate_presence_of :content }
	end
end