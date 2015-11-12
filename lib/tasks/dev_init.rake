namespace :db do
  desc "Access admin panel in dev"
  task dev_init: :environment do
    u = User.first || User.new(email: 'admin@admin', password: 'password')
    u.role = :admin
    u.save!
  end
end
