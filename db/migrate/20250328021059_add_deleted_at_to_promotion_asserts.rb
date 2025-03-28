class AddDeletedAtToPromotionAsserts < ActiveRecord::Migration[8.0]
  def change
    add_column :promotion_asserts, :deleted_at, :datetime
  end
end
