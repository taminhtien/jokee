require 'rails_helper'

RSpec.describe Vote, type: :model do
	context "Validation" do
		it { is_expected.to validate_presence_of :like }
		it { is_expected.to validate_presence_of :joke }
	end

	context "Association" do
		it { is_expected.to belong_to :joke }
	end
end