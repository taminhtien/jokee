require 'rails_helper'

RSpec.describe "InputVoteWorkflow", type: :feature do
	let!(:jokes) do
		[
			create(:joke, content: "First joke"),
			create(:joke, content: "Second joke"),
			create(:joke, content: "Third joke"),
		]
	end

	def like
		choose 'Yes'
		click_on 'Create Vote'
	end

	def dislike
		choose 'No'
		click_on 'Create Vote'
	end

	it "allows user to input his opinion" do
		visit '/'
		expect(page).to have_content jokes.first.content

		dislike
		expect(jokes.first.reload.dislike).to eq(1)
		expect(page).to have_content jokes.second.content
		
		dislike
		expect(jokes.second.reload.dislike).to eq(1)
		expect(page).to have_content jokes.third.content
		
		like
		expect(jokes.second.reload.dislike).to eq(1)
		expect(page).to have_content "That's all the jokes for today! Come back another day!"
	end
end