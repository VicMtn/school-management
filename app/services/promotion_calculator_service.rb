class PromotionCalculatorService
  def initialize(student, moment)
    @student = student
    @moment = moment
    @promotion_asserts = PromotionAssert.where(moment: @moment)
    @school_class = @student.school_classes.joins(:moment).where(moment: @moment).first
  end

  def promoted?
    return false unless @school_class
    return false if @promotion_asserts.empty?
    
    @promotion_asserts.all? do |assert|
      meets_assert_requirement?(assert)
    end
  end
  
  def results
    return { promoted: false, reason: "No class found for student in this moment" } unless @school_class
    return { promoted: false, reason: "No promotion rules defined for this moment" } if @promotion_asserts.empty?
    
    sector_results = {}
    valid_asserts = true
    
    @promotion_asserts.each do |assert|
      sector_grade = calculate_sector_grade(assert.sector)
      sector_results[assert.sector.name] = {
        grade: sector_grade,
        function: assert.function,
        meets_requirement: meets_assert_requirement?(assert)
      }
      
      valid_asserts = false unless meets_assert_requirement?(assert)
    end
    
    {
      promoted: valid_asserts,
      school_class: @school_class.name,
      moment: @moment.uid,
      sector_results: sector_results
    }
  end
  
  private
  
  def meets_assert_requirement?(assert)
    sector_grade = calculate_sector_grade(assert.sector)
    return false unless sector_grade
    
    # La note de passage par défaut est 10
    # Cela pourrait être configurable dans l'assertion future
    passing_grade = 10
    
    case assert.function
    when "average"
      sector_grade >= passing_grade
    when "minimum"
      sector_grade >= passing_grade
    when "maximum"
      sector_grade >= passing_grade
    else
      false
    end
  end
  
  def calculate_sector_grade(sector)
    # Trouver tous les examens de ce secteur pour cet étudiant
    courses = @school_class.courses.joins(:subject).where(subjects: { sector_id: sector.id })
    return nil if courses.empty?
    
    examinations = Examination.where(course_id: courses.pluck(:id))
    return nil if examinations.empty?
    
    grades = Grade.where(examination_id: examinations.pluck(:id), student_id: @student.id)
    return nil if grades.empty?
    
    # Calculer la moyenne des notes
    grades.average(:value).to_f
  end
end 