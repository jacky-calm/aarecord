# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
require 'date'

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.mongo_session['roles'].insert({ :name => role })
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.create :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

def create_user(name, email, passw='password')
  user = User.create :name => name, :email => email, :password => passw, :password_confirmation => passw
  user.add_role :user
  p user
  user
end
users = []
users << create_user('Liang Lei', 'lliang@scilearn.com.cn')
users << create_user('Jacky', 'xcheng@scilearn.com.cn')
users << create_user('Hong Hong', 'hjiang@scilearn.com.cn')
users << create_user('Liu Qin', 'qliu@scilearn.com.cn')

p 'Accounts'
a = Account.create :restaurant => 'Wai Po Jia', :total_fee => 120, :owner => users[0], :created => DateTime.now, :modified => DateTime.now, :status => 'New', :participants => users
p a
a = Account.create :restaurant => 'Xin Xiang Hui', :total_fee => 120, :owner => users[0], :created => DateTime.now, :modified => DateTime.now, :status => 'New', :participants => users
p a
