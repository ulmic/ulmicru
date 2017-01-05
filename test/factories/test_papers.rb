FactoryGirl.define do
  factory :test_paper do
    title { generate :string }
    begin_date { DateTime.now }
    end_date { begin_date + 1.day }
    record_type { 'confession' }
    record_id { 2016 }
    state { TestPaper.state_machines[:state].states.map(&:name).first.to_s }
  end
end
