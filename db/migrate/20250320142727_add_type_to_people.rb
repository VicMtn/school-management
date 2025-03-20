class AddTypeToPeople < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :type, :string
  end
end
