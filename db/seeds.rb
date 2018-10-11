# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

email = 'admin@it52.info'
pass  = '12345678'

admin_attrs = FactoryBot.attributes_for :admin,
  email:    email,
  password: pass,
  password_confirmation: pass

admin = User.where(email: email).first_or_create
admin.update(admin_attrs)

users = FactoryBot.create_list :user, 40

(1..4).each do |i|
  event = FactoryBot.create :published_event, :with_markdown, started_at: i.months.from_now
  event.participants << users.sample((10..40).to_a.sample)
end
