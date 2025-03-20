class Student < Person
  has_many :students_classes
  has_many :school_classes, through: :students_classes
  has_many :grades

  def current_class
    school_classes.joins(:moment).where('moments.end_on >= ?', Date.current).first
  end

  def current_courses
    courses.joins(:moment).where('moments.end_on >= ?', Date.current)
  end
end 