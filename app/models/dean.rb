class Dean < Person
  has_many :school_classes, foreign_key: 'master_id'

  def current_classes
    school_classes.joins(:moment).where('moments.end_on >= ?', Date.current)
  end

  def students_count
    current_classes.joins(:students_classes).distinct.count('students_classes.student_id')
  end
end 