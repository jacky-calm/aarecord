class Dish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Float
  field :feature, type: String

  belongs_to :restaurant
  belongs_to :party
  attr_accessible :name, :price, :feature, :created_at, :updated_at, :restaurant, :party
end
