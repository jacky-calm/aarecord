class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUS_NEW, STATUS_PAID = 'New', 'Paid'

  field :type, type: String
  field :fee, type: Float
  field :status, type: String, :default => STATUS_NEW

  belongs_to :debtee, :class_name => "User"
  belongs_to :debtor, :class_name=>  "User"
  belongs_to :account
  attr_accessible :type, :fee, :account, :status, :debtee, :debtor, :created_at, :updated_at

  def pay
    self.update_attributes :status=>STATUS_PAID
    account.try_to_clear
  end

  def paid?
    status == STATUS_PAID
  end

  def cleared_at
    return "Not yet" unless status==STATUS_PAID
    l updated_at :format => "%m%d%Y"
  end
end
