require 'rails_helper'

RSpec.describe Joke, type: :model do
	context 'Validation' do
		it { is_expected.to validate_presence_of :content }
	end

	describe '#next_unvoted_joke' do
		let!(:jokes) { create_list(:joke, 3) }
		let(:voted_jokes) { [jokes.first, jokes.second] }
		
		it 'returns next unvoted joke' do
			next_joke = Joke.next_unvoted_joke(voted_jokes)
			expect(next_joke).to eq jokes.last
		end
	end

	describe '#increase_like' do
		let(:joke) { create(:joke) }

		it "increases the number of joke's like" do
			expect {
				joke.increase_like
				joke.reload }.to change(joke, :like).by(1)
		end
	end

	describe '#increase_dislike' do
		let(:joke) { create(:joke) }

		it "increases the number of joke's dislike" do
			expect {
				joke.increase_dislike
				joke.reload }.to change(joke, :dislike).by(1)
		end
	end
end