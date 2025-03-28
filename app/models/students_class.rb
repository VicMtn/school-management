class StudentsClass < ApplicationRecord
  include SoftDeletable
  
  belongs_to :student
  belongs_to :school_class
end
