class Party
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :start_at, type: Time

  belongs_to :owner, :class_name => "User", inverse_of: :parties_owned
  belongs_to :restaurant

  has_and_belongs_to_many :participants, :class_name => "User", inverse_of: :parties_joined
  embeds_many :dishes

  attr_accessible :restaurant, :dishes, :owner, :participants, :participant_ids, :created_at, :updated_at, :start_at, :name
end
