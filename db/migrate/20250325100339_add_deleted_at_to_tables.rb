class AddDeletedAtToTables < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :deleted_at, :datetime
    add_column :school_classes, :deleted_at, :datetime
    add_column :courses, :deleted_at, :datetime
    add_column :subjects, :deleted_at, :datetime
    add_column :examinations, :deleted_at, :datetime
    add_column :grades, :deleted_at, :datetime
    add_column :students_classes, :deleted_at, :datetime
  end
end
