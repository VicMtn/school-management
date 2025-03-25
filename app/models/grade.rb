class Grade < ApplicationRecord
  include SoftDeletable
  
  belongs_to :examination
  belongs_to :student
end
