class Subject < ApplicationRecord
  include SoftDeletable
  
  belongs_to :teacher
  belongs_to :sector, optional: true
  has_many :courses
end
