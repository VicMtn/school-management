class Examination < ApplicationRecord
  include SoftDeletable
  
  belongs_to :course
end
