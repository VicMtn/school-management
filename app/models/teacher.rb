class Teacher < Person
  has_many :subjects
  has_many :courses
  has_many :school_classes, through: :courses

  def current_classes
    school_classes.joins(:moment).where('moments.end_on >= ?', Date.current)
  end

  def current_subjects
    subjects.joins(:moment).where('moments.end_on >= ?', Date.current)
  end
end 