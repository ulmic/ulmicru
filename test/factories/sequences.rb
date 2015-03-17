include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :string do |n|
    "string#{n}"
  end
  sequence :integer do |n|
    n
  end
  sequence :email do |n|
    "email_#{n}@mail.com"
  end
  sequence :phone do |n|
    "+7123456789"
  end
  sequence :url do |n|
    "http://site#{n}.ru"
  end
  sequence :postcode do |n|
    "434343"
  end
  sequence :date, aliases: [:start_date, :end_date] do |n|
    Date.today + n.day
  end
  sequence :file do |n|
    fixture_file_upload('app/assets/images/apps/logo-mic-square.png', 'image/png')
  end
  sequence :human_name, aliases: [:name] do
    "Leopold"
  end
end
