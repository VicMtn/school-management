class AddExecutionDateToGrades < ActiveRecord::Migration[8.0]
  def change
    add_column :grades, :execution_date, :datetime
  end
end
