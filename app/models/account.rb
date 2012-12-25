class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUS_NEW, STATUS_CLEARED = 'New', 'Cleared'

  field :restaurant, type: String
  field :total_fee, type: Float
  field :status, type: String, :default=>STATUS_NEW

  belongs_to :owner, :class_name => "User", inverse_of: :accounts_owned
  has_many :bills, dependent: :delete
  has_and_belongs_to_many :participants, :class_name => "User", inverse_of: :accounts_joined

  attr_accessible :restaurant, :total_fee, :status, :owner, :participants, :participant_ids, :created_at, :updated_at

  validates_presence_of :restaurant, :participant_ids
  validates :total_fee, :presence => true

  after_create :createBills

  def createBills
    participants.each do |p|
      status = p==owner ? Bill::STATUS_PAID : Bill::STATUS_NEW
      Bill.create :debtee=>owner, :debtor=>p, :account=>self, :type=>'Int', :fee => avg_fee, :status=>status
      if gap_fee > 0 && avg_gap_fee > 0
        Bill.create :debtee=>owner, :debtor=>p, :account=>self, :type=>'Gap', :fee => avg_gap_fee, :status=>status
      end
    end
  end

  def avg_fee
    return 0 if participants.empty?
    total_fee.to_i / participants.size
  end
  def gap_fee
    return 0 if participants.empty?
    total_fee - participants.size * avg_fee
  end
  def avg_gap_fee
    gap_fee / participants.size

  end
  def clear?
    status==STATUS_CLEARED
  end

  def locked?
    bills.any? {|b| b.debtor!=owner && b.paid?}
  end

  def try_to_clear
    #debugger
    return false if bills.any? { |b| !b.gap? and !b.paid? }
    logger.info "clear the account #{self.restaurant}"
    self.update_attributes :status=>STATUS_CLEARED
  end
  def cleared_at
    return "Not yet" unless clear?
    l updated_at :format => "%m%d%Y"
  end
end
