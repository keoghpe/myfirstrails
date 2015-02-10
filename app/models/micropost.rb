class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  validate :valid_band

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Should be less than 5MB")
      end
    end

    def valid_band
      unless band.nil? || band.is_owned_by?(user)
        errors.add(:band_id, "You cannot post as that band as you are not the owner.")
      end
    end
end
