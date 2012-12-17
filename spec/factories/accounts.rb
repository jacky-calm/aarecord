# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    restaurant "MyString"
    total_fee 1.5
    avg_fee 1.5
    created "2012-12-17 11:26:35"
    modified "2012-12-17 11:26:35"
    cleared "2012-12-17 11:26:35"
    status "MyString"
  end
end
