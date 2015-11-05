require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  context "#create" do
    def do_request(params)
      post :create, joke_id: joke.id, vote: params
    end

    context "Success" do
      let!(:joke) { create(:joke) }
      
      it "increases the number of joke's like" do
        params = attributes_for(:vote)
        expect {
          do_request(params)
          joke.reload }.to change(joke, :like).by(1)
      end

      it "increases the number of joke's dislike" do
        params = attributes_for(:vote, like: false)
        expect {
          do_request(params)
          joke.reload }.to change(joke, :dislike).by(1)
      end

      describe '#redirect_to_next_unvoted_joke' do
        let!(:params) { attributes_for(:vote) }

        context 'There are unvoted jokes' do
          let!(:next_joke) { create(:joke) }

          it "redirects to next unvoted joke" do
            do_request(params)
            expect(response).to redirect_to new_joke_vote_url(joke_id: next_joke.id)
          end
        end

        context 'There are no more unvoted jokes' do
          it "redirects to goodbye page" do
            do_request(params)
            expect(response).to redirect_to goodbye_votes_url
          end
        end
      end
    end
  end
end