class CreateSubjects < ActiveRecord::Migration[8.0]
  def change
    create_table :subjects do |t|
      t.string :slug
      t.string :name
      t.references :teacher, null: false, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end
