class Subject < ApplicationRecord
  include SoftDeletable
  
  belongs_to :teacher
  has_many :courses
end
