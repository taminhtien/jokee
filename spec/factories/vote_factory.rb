FactoryGirl.define do
	factory :vote do
		like true
		association :joke
	end
end