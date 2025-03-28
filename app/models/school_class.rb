class SchoolClass < ApplicationRecord
  include SoftDeletable
  
  belongs_to :moment
  belongs_to :room
  belongs_to :master, class_name: 'Person'
  belongs_to :sector
  has_many :students_classes
  has_many :students, through: :students_classes
  has_many :courses

  validates :master, presence: true
  validate :master_must_be_teacher_or_dean

  private

  def master_must_be_teacher_or_dean
    return if master.nil?
    unless master.is_a?(Teacher) || master.is_a?(Dean)
      errors.add(:master, "must be either a teacher or a dean")
    end
  end
end
