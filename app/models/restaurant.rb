class Restaurant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :address, type: String

  has_many :parties
  embeds_many :dishes
  attr_accessible :name, :dishes, :parties, :created_at, :updated_at
end
