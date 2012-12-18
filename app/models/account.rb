class Account
  include Mongoid::Document
  field :restaurant, type: String
  field :total_fee, type: Float
  field :created, type: Time
  field :modified, type: Time
  field :cleared, type: Time
  field :status, type: String

  belongs_to :owner, :class_name => "User", inverse_of: :accounts_owned
  has_many :bills
  has_and_belongs_to_many :participants, :class_name => "User", inverse_of: :accounts_joined
  attr_accessible :restaurant, :total_fee, :status, :owner, :participants, :created, :modified, :cleared, :participant_ids

  after_save :createBills

  def createBills
    participants.each do |p|
      Bill.create :debtee=>owner, :debtor=>p, :account=>self, :type=>'Int', :fee => avg_fee, :status=>'New'
      Bill.create :debtee=>owner, :debtor=>p, :account=>self, :type=>'Gap', :fee => gap_fee, :status=>'New'
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
  def cleared_at
    return "Not yet" unless cleared
    l cleared :format => "%m%d%Y"
  end
end
