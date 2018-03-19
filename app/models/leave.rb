class Leave < ApplicationRecord
  enum state: [:pending, :approved, :rejected]
  validates :start_date, presence: true
  validates :end_date, presence: true
  belongs_to :user
  before_save :leave_days
  scope :active, -> {where("start_date > ?", Time.zone.now)}




  def correct_dates?
    (self.end_date - self.start_date) >= 0 && self.start_date > Time.zone.now
  end

  def correct_size?
    self.user.leave_record.leaves_remaining >= self.leave_days 
  end

  def leave_days
    #wday 0 is sunday and 6 is saturday
    # self.duration = ((self.start_date.to_date..self.end_date.end_of_day.to_date).collect(&:wday)-[6,0]).count
    self.duration = ((self.start_date.to_date..self.end_date.to_date).collect(&:wday)-[6,0]).count
  end

end
  

