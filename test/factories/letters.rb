FactoryGirl.define do
  factory :letter do
    subdivision_code { generate :string }
    number { generate :integer }
    send_date { generate :date }
    receiver { generate :string }
    title { generate :string }
    list_number { generate :integer }
    annex { generate :integer }
    executor_id { create(:user).id }
    stamp_of_receipt { generate :string }
    note { generate :string }
    state Letter.state_machines[:state].states.map(&:name).first.to_s
    executor_name { generate :string }
    file { generate :file }
  end
end
