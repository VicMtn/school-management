class Dean < Person
  has_many :school_classes, foreign_key: 'master_id'

  def current_classes
    # Version originale avec contrainte de date
    # school_classes
    #   .joins(:moment)
    #   .where('moments.start_on <= ? AND moments.end_on >= ?', Date.current, Date.current)
    #   .order('moments.start_on DESC')
    
    # Version sans contrainte de date pour le débogage
    school_classes
      .joins(:moment)
      .order('moments.start_on DESC')
  end

  def students_count
    current_classes.joins(:students_classes).distinct.count('students_classes.student_id')
  end

  def dean?
    true
  end
end 