# encoding: utf-8
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

def restaurants
  Dish.create :name=>"外婆豆腐", :price=>3.0, :feature=>'招牌菜'
  Dish.create :name=>"干锅鸡", :price=>25.0, :feature=>'招牌菜'
  Dish.create :name=>"酸菜鱼", :price=>32.0, :feature=>'不辣'
  Dish.create :name=>"茶香鸭", :price=>30.0, :feature=>'特色'
  p Restaurant.create :name=>'外婆家', :address=>'八百伴', :dishes=>Dish.all
end


def create_user(name, email, passw='password')
  user = User.create :name => name, :email => email, :password => passw, :password_confirmation => passw
  user.add_role :user
  user
end

def users
  create_user('Liang Lei', 'lliang@scilearn.com.cn')
  create_user('Jacky', 'xcheng@scilearn.com.cn')
  create_user('Hong Hong', 'hjiang@scilearn.com.cn')
  create_user('Liu Qin', 'qliu@scilearn.com.cn')
  create_user('Li Hua', 'lhzhang@scilearn.com.cn')
  User.all
end

def parties
  p Party.create :name=>'工作餐', :start_at=>Time.now, :restaurant=>Restaurant.first, :dishes => Restaurant.first.dishes, :owner=>users[1], :participants=>users
end

def accounts
  p 'Accounts'
  Account.create :restaurant => 'Wai Po Jia', :total_fee => 120, :owner => users[1], :participants => users
  Account.create :restaurant => 'Xin Xiang Hui', :total_fee => 119, :owner => users[2], :participants => users
  Account.create :restaurant => 'San Jin Chun Qiu', :total_fee => 116, :owner => users[3], :participants => users
  Account.create :restaurant => 'San Jin Chun Qiu', :total_fee => 129, :owner => users[3], :participants => users
end

restaurants
users
parties
accounts
