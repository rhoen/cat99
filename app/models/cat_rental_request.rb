class CatRentalRequest < ActiveRecord::Base
  validate :valid_status
  validate :over_lapping_approved_requests
  validates :start_date, :end_date, :cat_id, presence: true
  belongs_to :cat
  STATI = ['PENDING','APPROVED','DENIED']

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!
      over_lapping_requests.where("status = 'PENDING'")
      .update_all("status = 'DENIED'")
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  private
  def valid_status
    unless STATI.include?(self.status)
      errors[:status] << "not a valid status"
    end
  end



  def over_lapping_approved_requests
    over_laps = over_lapping_requests.where('status = ?', 'APPROVED')
    unless over_laps.empty?
      errors[:status] << "Overlapping requests"
    end
  end



  def over_lapping_requests
    CatRentalRequest
      .where('cat_id = ?', cat_id)
      .where(' NOT (start_date < ? OR end_date > ?)', end_date, start_date)
      .where('id <> ?', id)
  end

end
