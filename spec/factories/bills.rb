# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    type ""
    fee 1.5
    cleared "2012-12-17 11:31:30"
    status "MyString"
  end
end
