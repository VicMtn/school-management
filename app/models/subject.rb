class Subject < ApplicationRecord
  include SoftDeletable
  
  belongs_to :teacher
end
