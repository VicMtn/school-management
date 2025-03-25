class Teacher < Person
  has_many :subjects
  has_many :courses
  has_many :school_classes, through: :courses
  has_many :mastered_classes, class_name: 'SchoolClass', foreign_key: 'master_id'

  def current_classes
    # Version originale avec contrainte de date
    # school_classes
    #   .joins(:moment)
    #   .where('moments.start_on <= ? AND moments.end_on >= ?', Date.current, Date.current)
    #   .order('moments.start_on DESC')
    #   .distinct
    
    # Version sans contrainte de date pour le débogage
    school_classes
      .joins(:moment)
      .order('moments.start_on DESC')
      .distinct
  end

  def current_subjects
    # Version originale avec contrainte de date
    # subjects
    #   .joins(:courses => :moment)
    #   .where('moments.start_on <= ? AND moments.end_on >= ?', Date.current, Date.current)
    #   .order('moments.start_on DESC')
    #   .distinct
    
    # Version sans contrainte de date pour le débogage
    subjects
      .joins(:courses => :moment)
      .order('moments.start_on DESC')
      .distinct
  end
end 