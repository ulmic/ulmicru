FactoryGirl.define do
  factory :banner do
    horizontal { generate :file }
    link { generate :url }
    begin_date { DateTime.now }
    end_date { DateTime.now + 1.day }
  end
end
