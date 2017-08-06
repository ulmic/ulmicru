FactoryGirl.define do
  factory :project_record, :class => 'Project::Record' do
    title "MyText"
project_id 1
version 1
record_type "MyText"
properties ""
  end

end
