class Restaurant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :address, type: String

  has_many :parties
  has_many :dishes
  attr_accessible :name, :dishes, :parties, :created_at, :updated_at, :dish_ids, :party_ids
end
