class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUS_NEW, STATUS_PAID = 'New', 'Paid'
  TYPE_INT, TYPE_GAP = 'Int', 'Gap'

  field :type, type: String
  field :fee, type: Float
  field :status, type: String, :default => STATUS_NEW

  belongs_to :debtee, :class_name => "User"
  belongs_to :debtor, :class_name=>  "User"
  belongs_to :account
  attr_accessible :type, :fee, :account, :status, :debtee, :debtor, :created_at, :updated_at

  def pay
    return true if paid?
    self.update_attributes :status=>STATUS_PAID
    logger.info "try to clear the account #{account.restaurant}"
    account.try_to_clear
  end

  def gap?
    type == TYPE_GAP
  end

  def paid?
    status == STATUS_PAID
  end

  def cleared_at
    return "Not yet" unless paid?
    l updated_at :format => "%m%d%Y"
  end
end
