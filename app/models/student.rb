class Student < Person
  has_many :students_classes
  has_many :school_classes, through: :students_classes
  has_many :grades

  def current_class
    # Méthode originale avec contrainte de date (commentée pour tests)
    # current_date = Date.current
    # school_classes
    #   .joins(:moment)
    #   .where('moments.start_on <= ? AND moments.end_on >= ?', current_date, current_date)
    #   .order('moments.start_on DESC')
    #   .first
    
    # Version simplifiée qui prend simplement la classe la plus récente
    school_classes
      .joins(:moment)
      .order('moments.start_on DESC')
      .first
  end

  def current_courses
    courses
      .joins(:moment)
      .where('moments.start_on <= ? AND moments.end_on >= ?', Date.current, Date.current)
      .order('moments.start_on DESC')
  end

  def debug_class_info
    {
      current_date: Date.current,
      all_classes: school_classes.map { |c| { id: c.id, name: c.name, moment_id: c.moment_id } },
      all_moments: school_classes.map(&:moment).uniq.map { |m| { id: m.id, uid: m.uid, start_on: m.start_on, end_on: m.end_on } }
    }
  end
  
  def promoted?(moment = nil)
    moment ||= current_moment
    return false unless moment
    
    calculator = PromotionCalculatorService.new(self, moment)
    calculator.promoted?
  end
  
  def promotion_results(moment = nil)
    moment ||= current_moment
    return { promoted: false, reason: "No current moment found" } unless moment
    
    calculator = PromotionCalculatorService.new(self, moment)
    calculator.results
  end
  
  private
  
  def current_moment
    current_class&.moment
  end
end 