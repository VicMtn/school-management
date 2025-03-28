# Cleaning database
puts "Cleaning database..."
[Grade, Examination, Course, StudentsClass, Subject, Person, Status, Address, Room, Sector, Moment, SchoolClass, User, PromotionAssert].each do |model|
  model.delete_all
end

# Create statuses
puts "Creating statuses..."
active_status = Status.create!(title: "Active", slug: "active")
inactive_status = Status.create!(title: "Inactive", slug: "inactive")

# Create addresses
puts "Creating addresses..."
addresses = []
40.times do
  addresses << Address.create!(
    zip: Faker::Address.zip_code.to_i,
    town: Faker::Address.city,
    street: Faker::Address.street_name,
    number: Faker::Address.building_number
  )
end

# Create rooms
puts "Creating rooms..."
rooms = []
8.times do |i|
  floor = (i / 4) + 1
  room_number = (i % 4) + 1
  rooms << Room.create!(name: "#{floor}0#{room_number}")
end

# Create sectors
puts "Creating sectors..."
sectors = [
  Sector.create!(name: "Sciences"),
  Sector.create!(name: "Humanities"),
  Sector.create!(name: "Arts"),
  Sector.create!(name: "Technology"),
  Sector.create!(name: "Languages"),
  Sector.create!(name: "Physical Education"),
  Sector.create!(name: "Social Sciences"),
  Sector.create!(name: "Business")
]

# Create moments (periods)
puts "Creating moments..."
current_moment = Moment.create!(
  uid: "2024-S1",
  start_on: Date.new(2024, 9, 1),
  end_on: Date.new(2025, 1, 31),
  moment_type: 0
)

previous_moment = Moment.create!(
  uid: "2024-S0",
  start_on: Date.new(2024, 2, 1),
  end_on: Date.new(2024, 6, 30),
  moment_type: 0
)

older_moment = Moment.create!(
  uid: "2023-S1",
  start_on: Date.new(2023, 9, 1),
  end_on: Date.new(2024, 1, 31),
  moment_type: 0
)

# Array of all moments for easy access
moments = [current_moment, previous_moment, older_moment]

# Create deans
puts "Creating deans..."
deans = []

# Créer un premier doyen avec des identifiants connus
fixed_dean_email = "dean@school.com"
deans << Dean.create!(
  username: "dean1",
  firstname: "John",
  lastname: "Director",
  email: fixed_dean_email,
  phone_number: "0791234567",
  iban: "CH9300762011623852957",
  status: active_status,
  address: addresses[0],
  user: User.create!(
    email: fixed_dean_email,
    password: "password123",
    password_confirmation: "password123"
  )
)

# Créer le deuxième doyen
email = Faker::Internet.unique.email(domain: 'school.com')
deans << Dean.create!(
  username: "dean2",
  firstname: Faker::Name.first_name,
  lastname: Faker::Name.last_name,
  email: email,
  phone_number: Faker::PhoneNumber.cell_phone,
  iban: Faker::Bank.iban(country_code: 'CH'),
  status: active_status,
  address: addresses[1],
  user: User.create!(
    email: email,
    password: "password123",
    password_confirmation: "password123"
  )
)

# Create teachers
puts "Creating teachers..."
teachers = []

# Créer un enseignant avec des identifiants connus
fixed_teacher_email = "teacher@school.com"
teachers << Teacher.create!(
  username: "teacher1",
  firstname: "Robert",
  lastname: "Smith",
  email: fixed_teacher_email,
  phone_number: "0792345678",
  iban: "CH9300762011623852958",
  status: active_status,
  address: addresses[2],
  user: User.create!(
    email: fixed_teacher_email,
    password: "password123",
    password_confirmation: "password123"
  )
)

# Créer les autres enseignants
9.times do |i|
  email = Faker::Internet.unique.email(domain: 'school.com')
  teachers << Teacher.create!(
    username: "teacher#{i+2}",
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: email,
    phone_number: Faker::PhoneNumber.cell_phone,
    iban: Faker::Bank.iban(country_code: 'CH'),
    status: active_status,
    address: addresses[i+4],
    user: User.create!(
      email: email,
      password: "password123",
      password_confirmation: "password123"
    )
  )
end

# Create subjects
puts "Creating subjects..."
subject_data = [
  { slug: "math", name: "Mathematics", sector: "Sciences" },
  { slug: "phys", name: "Physics", sector: "Sciences" },
  { slug: "hist", name: "History", sector: "Humanities" },
  { slug: "geo", name: "Geography", sector: "Humanities" },
  { slug: "info", name: "Computer Science", sector: "Technology" },
  { slug: "engl", name: "English", sector: "Languages" },
  { slug: "biol", name: "Biology", sector: "Sciences" },
  { slug: "chem", name: "Chemistry", sector: "Sciences" },
  { slug: "fren", name: "French", sector: "Languages" },
  { slug: "germ", name: "German", sector: "Languages" },
  { slug: "arts", name: "Arts", sector: "Arts" },
  { slug: "musi", name: "Music", sector: "Arts" },
  { slug: "phyed", name: "Physical Education", sector: "Physical Education" },
  { slug: "econ", name: "Economics", sector: "Business" },
  { slug: "psyc", name: "Psychology", sector: "Social Sciences" },
  { slug: "soci", name: "Sociology", sector: "Social Sciences" }
]

subjects = []
subject_data.each_with_index do |data, i|
  # Trouver le secteur correspondant
  sector = sectors.find { |s| s.name == data[:sector] }
  
  subjects << Subject.create!(
    slug: data[:slug],
    name: data[:name],
    teacher: teachers[i % teachers.size],
    sector: sector
  )
end

# Create school classes
puts "Creating school classes..."
school_classes = []
class_names = [
  { uid: "1A", name: "First Year A" },
  { uid: "1B", name: "First Year B" },
  { uid: "2A", name: "Second Year A" },
  { uid: "2B", name: "Second Year B" }
]

# Select which teachers will be masters (just use the first 2)
master_teachers = teachers[0..1]

class_names.each_with_index do |class_data, i|
  if i < 2
    # Assign first two classes to deans
    school_classes << SchoolClass.create!(
      uid: class_data[:uid],
      name: class_data[:name],
      moment: current_moment,
      room: rooms[i],
      sector: sectors[i % sectors.size],
      master: deans[i]
    )
  else
    # Assign remaining classes to selected teachers
    teacher_index = i - 2  # adjust index to start at 0 for teachers
    school_classes << SchoolClass.create!(
      uid: class_data[:uid],
      name: class_data[:name],
      moment: current_moment,
      room: rooms[i],
      sector: sectors[i % sectors.size],
      master: master_teachers[teacher_index]
    )
  end
end

# Create promotion assertions
puts "Creating promotion assertions..."
promotion_functions = ["average", "minimum", "maximum"]

# Créer des assertions pour chaque moment (période)
moments.each do |moment|
  # Créer une assertion pour chaque secteur principal
  main_sectors = ["Sciences", "Humanities", "Languages", "Technology"]
  
  main_sectors.each_with_index do |sector_name, index|
    sector = sectors.find { |s| s.name == sector_name }
    
    # Choisir une fonction différente pour chaque secteur (pour la variété)
    function = promotion_functions[index % promotion_functions.size]
    
    PromotionAssert.create!(
      description: "#{function.capitalize} grade for #{sector_name}",
      function: function,
      moment: moment,
      sector: sector
    )
  end
end

# Create students
puts "Creating students..."
students = []

# Créer un étudiant avec des identifiants connus
fixed_student_email = "student@school.com"
students << Student.create!(
  username: "student1",
  firstname: "Alice",
  lastname: "Johnson",
  email: fixed_student_email,
  phone_number: "0793456789",
  iban: "CH9300762011623852959",
  status: active_status,
  address: addresses[3],
  user: User.create!(
    email: fixed_student_email,
    password: "password123",
    password_confirmation: "password123"
  )
)

# Créer les autres étudiants
39.times do |i|
  email = Faker::Internet.unique.email(domain: 'school.com')
  students << Student.create!(
    username: "student#{i+2}",
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: email,
    phone_number: Faker::PhoneNumber.cell_phone,
    iban: Faker::Bank.iban(country_code: 'CH'),
    status: active_status,
    address: addresses[(i+4) % addresses.size],
    user: User.create!(
      email: email,
      password: "password123",
      password_confirmation: "password123"
    )
  )
end

# Associate students with classes - make sure all students have a class
puts "Associating students with classes..."
# Ensure every student is assigned to a class
# Distribute students evenly among the classes
students.each_with_index do |student, i|
  StudentsClass.create!(student: student, school_class: school_classes[i % school_classes.size])
end

# Load the courses seeder if needed
# require_relative 'seeds/courses'

# Create courses
puts "Creating courses..."
courses = []
week_days = (1..5).to_a  # Monday to Friday
time_slots = [
  { start: "08:15", end: "09:00" },
  { start: "09:05", end: "09:50" },
  { start: "10:05", end: "10:50" },
  { start: "10:55", end: "11:40" },
  { start: "11:45", end: "12:30" },
  { start: "13:20", end: "14:05" },
  { start: "14:10", end: "14:55" },
  { start: "15:05", end: "15:50" },
  { start: "15:55", end: "16:40" },
  { start: "16:45", end: "17:30" },
]

# Distribuer les matières sur différents semestres
first_half_subjects = subjects[0...(subjects.size/2)]
second_half_subjects = subjects[(subjects.size/2)..-1]

# Créer des cours pour chaque semestre
moments.each do |moment|
  # Premier groupe de sujets pour les semestres impairs (S1)
  subjects_for_moment = if moment.uid.include?("S1") || moment.uid.include?("S0")
                         first_half_subjects
                       else
                         second_half_subjects
                       end
  
  subjects_for_moment.each_with_index do |subject, i|
    school_classes.each_with_index do |school_class, j|
      time_slot = time_slots[(i + j) % time_slots.size]
      week_day = week_days[i % week_days.size]
      
      # Assigner une salle au cours, en favorisant la salle de la classe ou une autre si nécessaire
      room = [(i + j) % 2 == 0 ? school_class.room : rooms.sample].sample
      
      courses << Course.create!(
        start_at: time_slot[:start],
        end_at: time_slot[:end],
        archived: false,
        subject: subject,
        school_class: school_class,
        moment: moment,
        teacher: subject.teacher,
        week_day: week_day,
        room_id: room.id
      )
    end
  end
end

# Create examinations
puts "Creating examinations..."
examinations = []

# 3 examinations par cours
courses.each_with_index do |course, i|
  moment_date_start = course.moment.start_on
  
  # Créer 3 examens pour chaque cours à différentes dates dans le semestre
  3.times do |exam_num|
    # Répartir les examens dans le semestre (début, milieu, fin)
    date_offset = case exam_num
                 when 0 then 30  # Premier exam après 1 mois
                 when 1 then 75  # Deuxième exam vers le milieu du semestre
                 when 2 then 120 # Dernier exam vers la fin du semestre
                 end
    
    examination_date = moment_date_start + date_offset.days
    
    examinations << Examination.create!(
      title: "#{course.subject.name} - Exam #{exam_num + 1}",
      effective_date: examination_date,
      course: course
    )
  end
end

# Create grades
puts "Creating grades..."
students.each do |student|
  # Get the student's class
  student_class = student.students_classes.first.school_class
  
  # Get examinations for courses in that class
  class_examinations = examinations.select do |exam| 
    exam.course.school_class == student_class
  end
  
  # Create grades for each examination
  class_examinations.each do |exam|
    Grade.create!(
      value: rand(5..20),
      execute_on: exam.effective_date,
      examination: exam,
      student: student
    )
  end
end

# Verifications
puts "\nVerifications of created data :"
puts "--------------------------------"
puts "Status : #{Status.count}"
puts "Addresses : #{Address.count}"
puts "Rooms : #{Room.count}"
puts "Sectors : #{Sector.count}"
puts "Moments : #{Moment.count}"
puts "People (total) : #{Person.count}"
puts "- Deans : #{Dean.count}"
puts "- Teachers : #{Teacher.count}"
puts "- Students : #{Student.count}"
puts "Subjects : #{Subject.count}"
puts "School Classes : #{SchoolClass.count}"
puts "Students Classes : #{StudentsClass.count}"
puts "Courses : #{Course.count}"
puts "Examinations : #{Examination.count}"
puts "Grades : #{Grade.count}"
puts "Promotion Assertions : #{PromotionAssert.count}"
puts "--------------------------------"

puts "\nVerifications of associations :"
puts "--------------------------------"
school_classes.each do |school_class|
  puts "#{school_class.name} : #{school_class.students_classes.count} students"
end

puts "Class masters:"
school_classes.each do |school_class|
  master = school_class.master
  master_type = master.is_a?(Dean) ? "Dean" : "Teacher"
  puts "- #{school_class.name} : Master is #{master.full_name} (#{master_type})"
end

puts "Number of courses per teacher:"
teachers.each do |teacher|
  puts "- #{teacher.full_name} : #{teacher.courses.count} courses"
end

puts "Subject sectors:"
subjects.each do |subject|
  puts "- #{subject.name} : #{subject.sector&.name || 'No sector'}"
end

puts "Promotion assertions per moment:"
moments.each do |moment|
  puts "- #{moment.uid} : #{PromotionAssert.where(moment: moment).count} assertions"
end
puts "--------------------------------"

puts "\nSeeding completed!"

