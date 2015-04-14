class Cat < ActiveRecord::Base
  validates :name, presence: true
  validate :check_color

  has_many :cat_rental_requests, dependent: :destroy

  COLORS = ["black", "calico", "incarnadine", "seafoam", "lazuli", "space grey", "violet", "jade green"]


  def cat_colors
    COLORS
  end


  def age
    ((Date.today - birth_date).to_i / 365)
  end

  def birthday
    birth_date.strftime("%B %d, %Y")
  end


  private
    def check_color
     unless COLORS.include?(self.color)
       errors[:color] << "That's not a color..."
     end
    end





end
