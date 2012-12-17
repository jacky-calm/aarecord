class Account
  include Mongoid::Document
  field :restaurant, type: String
  field :total_fee, type: Float
  field :avg_fee, type: Float
  field :created, type: Time
  field :modified, type: Time
  field :cleared, type: Time
  field :status, type: String

  belongs_to :owner, :class_name => "User", inverse_of: :accounts_owned
  has_many :bills
  has_and_belongs_to_many :participants, :class_name => "User", inverse_of: :accounts_joined
  attr_accessible :restaurant, :total_fee, :avg_fee, :status, :owner, :participants
end
