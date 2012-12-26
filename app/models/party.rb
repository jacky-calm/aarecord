class Party
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :start_at, type: Date

  belongs_to :owner, :class_name => "User", inverse_of: :parties_owned
  belongs_to :restaurant

  has_and_belongs_to_many :participants, :class_name => "User", inverse_of: :parties_joined
  has_many :dishes
  accepts_nested_attributes_for :dishes

  attr_accessible :restaurant, :dishes, :owner, :participants, :created_at, :updated_at, :start_at, :name, :restaurant_id, :participant_ids, :dish_ids
end
