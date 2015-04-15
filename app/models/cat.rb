class Cat < ActiveRecord::Base
  validates :name, :birth_date, presence: true
  validate :check_color

  has_many :cat_rental_requests, dependent: :destroy

  belongs_to :user


  COLORS = ["black", "calico", "incarnadine", "seafoam", "lazuli", "space grey", "violet", "jade green"]


  def cat_colors
    COLORS
  end


  def age
    ((Date.today - birth_date).to_i / 365)
  end

  def birthday
    return nil if birth_date.nil?
    birth_date.strftime("%B %d, %Y")
  end


  private
    def check_color
     unless COLORS.include?(self.color)
       errors[:color] << "That's not a color..."
     end
    end





end
