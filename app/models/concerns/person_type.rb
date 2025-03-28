module PersonType
  extend ActiveSupport::Concern

  def dean?
    type == 'Dean'
  end

  def teacher?
    type == 'Teacher'
  end

  def student?
    type == 'Student'
  end
end 