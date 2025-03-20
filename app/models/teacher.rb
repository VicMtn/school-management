class Teacher < Person
  has_many :subjects
  has_many :courses
  has_many :school_classes, through: :courses

  validates :role, inclusion: { in: %w[teacher] }

  def current_classes
    school_classes.joins(:moment).where('moments.end_on >= ?', Date.current)
  end

  def current_subjects
    subjects.joins(:courses).where('courses.end_at >= ?', Time.current).distinct
  end
end 