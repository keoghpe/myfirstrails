class Band < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 250 }

  self.per_page = 12

  def is_owned_by?(user)
    user.id == self.user_id
  end

end
