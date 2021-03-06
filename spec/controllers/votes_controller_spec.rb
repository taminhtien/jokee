require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe "#new" do
    def do_request
      get :new, joke_id: joke.id
    end

    let!(:joke) { create(:joke) }

    it "displays a form" do
      do_request
      expect(response).to render_template :new
    end
  end

  describe "#create" do
    def do_request(params)
      post :create, joke_id: joke.id, vote: params
    end

    context "Success" do
      let!(:joke) { create(:joke) }

      it "saves a vote" do
        params = attributes_for(:vote)      
        expect { do_request(params) }.to change(Vote, :count).by(1)
      end

      context "User likes joke" do
        it "increases the number of joke's like" do
          params = attributes_for(:vote)
          expect {
            do_request(params)
            joke.reload
          }.to change(joke, :like).by(1)
        end
      end

      context "User dislikes joke" do
        it "increases the number of joke's dislike" do
          params = attributes_for(:vote, like: false)
          expect {
            do_request(params)
            joke.reload
          }.to change(joke, :dislike).by(1)
        end
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

    context 'Failure' do
      let!(:joke) { create(:joke) }

      it 'does not save a vote' do
        params = attributes_for(:vote, like: nil)
        expect { do_request(params) }.not_to change(Vote, :count)
      end

      it 'renders a form if can not save a vote' do
        params = attributes_for(:vote, like: nil)
        do_request(params)
        expect(response).to render_template :new
      end
    end
  end

  describe "#goodbye" do
    it "renders goodbye page" do
      get :goodbye
      expect(response).to render_template :goodbye
    end
  end
end