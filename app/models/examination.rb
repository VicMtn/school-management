class Examination < ApplicationRecord
  include SoftDeletable
  
  belongs_to :course
  has_many :grades
  has_many :students, through: :grades

  validates :title, presence: true
  validates :effective_date, presence: true
  validates :course_id, presence: true
end
