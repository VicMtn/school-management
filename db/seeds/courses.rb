# frozen_string_literal: true

# This seeder creates a complete schedule for each class
# It should be called after teachers, subjects, school_classes, and moments are created

puts "\nCreating courses schedule..."

# Get all active moments
moments = Moment.where('end_on >= ?', Date.current)

# Define the schedule structure
# Each class will have 6 periods per day, from Monday to Friday
# Format: [start_time, end_time]
periods = [
  ['08:00', '09:30'],  # Period 1
  ['09:45', '11:15'],  # Period 2
  ['11:30', '13:00'],  # Period 3
  ['14:00', '15:30'],  # Period 4
  ['15:45', '17:15'],  # Period 5
  ['17:30', '19:00']   # Period 6
]

# Get all subjects and teachers
subjects = Subject.all
teachers = Teacher.all

# For each moment (semester)
moments.each do |moment|
  # Get all classes for this moment
  school_classes = SchoolClass.where(moment: moment)
  
  school_classes.each do |school_class|
    # Create a schedule for each day of the week (Monday = 1, Friday = 5)
    (1..5).each do |week_day|
      # Randomly select subjects for this day
      # We want to ensure each subject appears at least once per week
      daily_subjects = subjects.sample(periods.length)
      
      periods.each_with_index do |period, index|
        subject = daily_subjects[index]
        teacher = subject.teacher
        
        Course.create!(
          start_at: period[0],
          end_at: period[1],
          archived: false,
          subject: subject,
          school_class: school_class,
          moment: moment,
          teacher: teacher,
          week_day: week_day
        )
      end
    end
  end
end

puts "Created #{Course.count} courses" 