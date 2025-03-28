class AddRoomToCourses < ActiveRecord::Migration[8.0]
  def change
    add_reference :courses, :room, null: true, foreign_key: true
  end
end
