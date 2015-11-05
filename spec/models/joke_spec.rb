require 'rails_helper'

RSpec.describe Joke, type: :model do
	context 'Validation' do
		it { is_expected.to validate_presence_of :content }
	end

	describe '#next_unvote_joke' do
		let!(:jokes) { FactoryGirl::create_list(:joke, 3) }
		let(:voted_jokes) { [jokes.first, jokes.second] }
		
		it 'returns next unvote joke' do
			next_joke = Joke.next_unvote_joke(voted_jokes)
			expect(next_joke).to eq jokes.last
		end
	end
end