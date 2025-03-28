class PromotionAssert < ApplicationRecord
  belongs_to :moment
  belongs_to :sector
  
  # Soft delete
  default_scope { where(deleted_at: nil) }
  
  def soft_delete
    update(deleted_at: Time.current)
  end
  
  def restore
    update(deleted_at: nil)
  end
end
