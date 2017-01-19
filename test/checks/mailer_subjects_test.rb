require 'test_helper'

class MailerSubjectsTest < ActionController::TestCase
  include Concerns::MessageConstructor

  setup do
    exceptions = [ :activity_lines, :concerns, 'concerns/message_constructor.rb', 
                   'activity_lines/corporative', 'activity_lines/corporative/online_conference', 'activity_lines/lider',
                   'activity_lines/lider/ya_lider' ].map(&:to_s)
    @mailers = Dir.glob('app/mailers/**/*').each { |m| m  }.map do |m| 
      m.gsub('app/mailers/', '').gsub('_mailer.rb', '')
    end.except(*exceptions)
  end

  test 'check all subject in yaml file' do
    subjects = YAML.load_file("#{Rails.root}/lib/yaml/mail_messages.yml").with_indifferent_access[:messages]
    @mailers.each do |mailer|
      themes = "#{mailer.camelize}Mailer".constantize.public_instance_methods(false)
      themes.except(:image_src, :image_src=).each do |theme|
        subj = subjects[mailer]
        assert_not_equal subj, nil, "Subject for #{mailer} #{theme} not exists"
        subj = subjects[mailer][theme]
        assert_not_equal subj, nil, "Subject for #{mailer} #{theme} not exists"
        subj = subjects[mailer][theme][:subject]
        assert_not_equal subj, nil, "Subject for #{mailer} #{theme} not exists"
      end
    end
  end
end
