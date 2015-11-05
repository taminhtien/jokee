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
    end
  end
end