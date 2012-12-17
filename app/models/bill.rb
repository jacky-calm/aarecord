class Bill
  include Mongoid::Document
  field :type, type: String
  field :fee, type: Float
  field :cleared, type: Time
  field :status, type: String

  belongs_to :debtee, :class_name => "User"
  belongs_to :debtor, :class_name=>  "User"
  belongs_to :account
  attr_accessible :type, :fee, :account, :status, :debtee, :debtor
end
