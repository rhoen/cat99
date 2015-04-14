class CatRentalRequest < ActiveRecord::Base
  validate :valid_status
  validate :over_lapping_approved_requests
  belongs_to :cat
  STATI = ['PENDING','APPROVED','DENIED']


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
      .where('start_date < ? OR end_date > ?', end_date, start_date)
      .where('id <> ?', id)
  end

end
