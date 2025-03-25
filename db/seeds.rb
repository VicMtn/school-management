# Cleaning database
puts "Cleaning database..."
[Grade, Examination, Course, StudentsClass, Subject, Person, Status, Address, Room, Sector, Moment, SchoolClass, User].each do |model|
  model.delete_all
end

# Create statuses
puts "Creating statuses..."
active_status = Status.create!(title: "Active", slug: "active")
inactive_status = Status.create!(title: "Inactive", slug: "inactive")

# Create addresses
puts "Creating addresses..."
addresses = [
  Address.create!(zip: 8001, town: "Zurich", street: "Bahnhofstrasse", number: "1"),
  Address.create!(zip: 8002, town: "Zurich", street: "Rennweg", number: "2"),
  Address.create!(zip: 3000, town: "Bern", street: "Spitalgasse", number: "3"),
  Address.create!(zip: 3001, town: "Bern", street: "Marktgasse", number: "4"),
  Address.create!(zip: 4000, town: "Basel", street: "Freie Strasse", number: "5"),
  Address.create!(zip: 4001, town: "Basel", street: "Gerbergasse", number: "6"),
  Address.create!(zip: 1000, town: "Lausanne", street: "Rue du Bourg", number: "7"),
  Address.create!(zip: 1001, town: "Lausanne", street: "Rue de la Madeleine", number: "8"),
  Address.create!(zip: 6900, town: "Lugano", street: "Via Nassa", number: "9"),
  Address.create!(zip: 6901, town: "Lugano", street: "Via Pessina", number: "10"),
  Address.create!(zip: 6000, town: "Lucerne", street: "Kapellgasse", number: "11"),
  Address.create!(zip: 6001, town: "Lucerne", street: "Hirschmattstrasse", number: "12"),
  Address.create!(zip: 9000, town: "St. Gallen", street: "Marktgasse", number: "13"),
  Address.create!(zip: 9001, town: "St. Gallen", street: "Spisergasse", number: "14"),
  Address.create!(zip: 2500, town: "Biel", street: "Nidaugasse", number: "15"),
  Address.create!(zip: 2501, town: "Biel", street: "Obergasse", number: "16"),
  Address.create!(zip: 1700, town: "Fribourg", street: "Rue de Lausanne", number: "17"),
  Address.create!(zip: 1701, town: "Fribourg", street: "Rue de Romont", number: "18"),
  Address.create!(zip: 1950, town: "Sion", street: "Rue du Grand-Pont", number: "19"),
  Address.create!(zip: 1951, town: "Sion", street: "Rue du Midi", number: "20")
]

# Create rooms
puts "Creating rooms..."
rooms = [
  Room.create!(name: "101"),
  Room.create!(name: "102"),
  Room.create!(name: "201"),
  Room.create!(name: "202"),
  Room.create!(name: "301"),
  Room.create!(name: "302"),
  Room.create!(name: "401"),
  Room.create!(name: "402")
]

# Create sectors
puts "Creating sectors..."
sectors = [
  Sector.create!(name: "Sciences"),
  Sector.create!(name: "Humanities"),
  Sector.create!(name: "Arts"),
  Sector.create!(name: "Technology")
]

# Create moments (periods)
puts "Creating moments..."
current_moment = Moment.create!(
  uid: "2024-S1",
  start_on: Date.new(2024, 9, 1),
  end_on: Date.new(2025, 6, 30),
  moment_type: 0
)

# Create deans
puts "Creating deans..."
deans = [
  Dean.create!(
    username: "dean1",
    firstname: "John",
    lastname: "Smith",
    email: "john.smith@school.com",
    phone_number: "0791234567",
    iban: "CH9300762011623852957",
    status: active_status,
    address: addresses[0],
    user: User.create!(
      email: "john.smith@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Dean.create!(
    username: "dean2",
    firstname: "Mary",
    lastname: "Johnson",
    email: "mary.johnson@school.com",
    phone_number: "0792345678",
    iban: "CH9300762011623852958",
    status: active_status,
    address: addresses[1],
    user: User.create!(
      email: "mary.johnson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  )
]

# Create teachers
puts "Creating teachers..."
teachers = [
  Teacher.create!(
    username: "teacher1",
    firstname: "Peter",
    lastname: "Brown",
    email: "peter.brown@school.com",
    phone_number: "0793456789",
    iban: "CH9300762011623852959",
    status: active_status,
    address: addresses[2],
    user: User.create!(
      email: "peter.brown@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Teacher.create!(
    username: "teacher2",
    firstname: "Sarah",
    lastname: "Wilson",
    email: "sarah.wilson@school.com",
    phone_number: "0794567890",
    iban: "CH9300762011623852960",
    status: active_status,
    address: addresses[3],
    user: User.create!(
      email: "sarah.wilson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Teacher.create!(
    username: "teacher3",
    firstname: "Michael",
    lastname: "Taylor",
    email: "michael.taylor@school.com",
    phone_number: "0795678901",
    iban: "CH9300762011623852961",
    status: active_status,
    address: addresses[4],
    user: User.create!(
      email: "michael.taylor@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Teacher.create!(
    username: "teacher4",
    firstname: "Emma",
    lastname: "Davis",
    email: "emma.davis@school.com",
    phone_number: "0796789012",
    iban: "CH9300762011623852962",
    status: active_status,
    address: addresses[5],
    user: User.create!(
      email: "emma.davis@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  )
]

# Create subjects
puts "Creating subjects..."
subjects = [
  Subject.create!(
    slug: "math",
    name: "Mathematics",
    teacher: teachers[0]
  ),
  Subject.create!(
    slug: "phys",
    name: "Physics",
    teacher: teachers[0]
  ),
  Subject.create!(
    slug: "hist",
    name: "History",
    teacher: teachers[1]
  ),
  Subject.create!(
    slug: "geo",
    name: "Geography",
    teacher: teachers[1]
  ),
  Subject.create!(
    slug: "info",
    name: "Computer Science",
    teacher: teachers[2]
  ),
  Subject.create!(
    slug: "engl",
    name: "English",
    teacher: teachers[2]
  ),
  Subject.create!(
    slug: "biol",
    name: "Biology",
    teacher: teachers[3]
  ),
  Subject.create!(
    slug: "chem",
    name: "Chemistry",
    teacher: teachers[3]
  )
]

# Create school classes
puts "Creating school classes..."
school_classes = [
  SchoolClass.create!(
    uid: "1A",
    name: "First Year A",
    moment: current_moment,
    room: rooms[0],
    sector: sectors[0],
    master: deans[0]
  ),
  SchoolClass.create!(
    uid: "1B",
    name: "First Year B",
    moment: current_moment,
    room: rooms[1],
    sector: sectors[1],
    master: teachers[0]
  )
]

# Create students
puts "Creating students..."
students = [
  Student.create!(
    username: "student1",
    firstname: "James",
    lastname: "Anderson",
    email: "james.anderson@school.com",
    phone_number: "0796789012",
    iban: "CH9300762011623852963",
    status: active_status,
    address: addresses[6],
    user: User.create!(
      email: "james.anderson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student2",
    firstname: "Emma",
    lastname: "Thompson",
    email: "emma.thompson@school.com",
    phone_number: "0797890123",
    iban: "CH9300762011623852964",
    status: active_status,
    address: addresses[7],
    user: User.create!(
      email: "emma.thompson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student3",
    firstname: "William",
    lastname: "White",
    email: "william.white@school.com",
    phone_number: "0798901234",
    iban: "CH9300762011623852965",
    status: active_status,
    address: addresses[8],
    user: User.create!(
      email: "william.white@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student4",
    firstname: "Olivia",
    lastname: "Martinez",
    email: "olivia.martinez@school.com",
    phone_number: "0799012345",
    iban: "CH9300762011623852966",
    status: active_status,
    address: addresses[9],
    user: User.create!(
      email: "olivia.martinez@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student5",
    firstname: "Henry",
    lastname: "Garcia",
    email: "henry.garcia@school.com",
    phone_number: "0790123456",
    iban: "CH9300762011623852967",
    status: active_status,
    address: addresses[10],
    user: User.create!(
      email: "henry.garcia@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student6",
    firstname: "Sophia",
    lastname: "Lee",
    email: "sophia.lee@school.com",
    phone_number: "0791234567",
    iban: "CH9300762011623852968",
    status: active_status,
    address: addresses[11],
    user: User.create!(
      email: "sophia.lee@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student7",
    firstname: "Lucas",
    lastname: "Rodriguez",
    email: "lucas.rodriguez@school.com",
    phone_number: "0792345678",
    iban: "CH9300762011623852969",
    status: active_status,
    address: addresses[12],
    user: User.create!(
      email: "lucas.rodriguez@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student8",
    firstname: "Isabella",
    lastname: "Lopez",
    email: "isabella.lopez@school.com",
    phone_number: "0793456789",
    iban: "CH9300762011623852970",
    status: active_status,
    address: addresses[13],
    user: User.create!(
      email: "isabella.lopez@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student9",
    firstname: "Mason",
    lastname: "Gonzalez",
    email: "mason.gonzalez@school.com",
    phone_number: "0794567890",
    iban: "CH9300762011623852971",
    status: active_status,
    address: addresses[14],
    user: User.create!(
      email: "mason.gonzalez@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student10",
    firstname: "Mia",
    lastname: "Wilson",
    email: "mia.wilson@school.com",
    phone_number: "0795678901",
    iban: "CH9300762011623852972",
    status: active_status,
    address: addresses[15],
    user: User.create!(
      email: "mia.wilson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student11",
    firstname: "Ethan",
    lastname: "Anderson",
    email: "ethan.anderson@school.com",
    phone_number: "0796789012",
    iban: "CH9300762011623852973",
    status: active_status,
    address: addresses[16],
    user: User.create!(
      email: "ethan.anderson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student12",
    firstname: "Charlotte",
    lastname: "Taylor",
    email: "charlotte.taylor@school.com",
    phone_number: "0797890123",
    iban: "CH9300762011623852974",
    status: active_status,
    address: addresses[17],
    user: User.create!(
      email: "charlotte.taylor@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student13",
    firstname: "Alexander",
    lastname: "Thomas",
    email: "alexander.thomas@school.com",
    phone_number: "0798901234",
    iban: "CH9300762011623852975",
    status: active_status,
    address: addresses[18],
    user: User.create!(
      email: "alexander.thomas@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student14",
    firstname: "Amelia",
    lastname: "Moore",
    email: "amelia.moore@school.com",
    phone_number: "0799012345",
    iban: "CH9300762011623852976",
    status: active_status,
    address: addresses[19],
    user: User.create!(
      email: "amelia.moore@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  ),
  Student.create!(
    username: "student15",
    firstname: "Benjamin",
    lastname: "Jackson",
    email: "benjamin.jackson@school.com",
    phone_number: "0790123456",
    iban: "CH9300762011623852977",
    status: active_status,
    address: addresses[0],
    user: User.create!(
      email: "benjamin.jackson@school.com",
      password: "password123",
      password_confirmation: "password123"
    )
  )
]

# Associate students with classes (8 in the first class, 7 in the second)
puts "Associating students with classes..."
students[0..7].each do |student|
  StudentsClass.create!(student: student, school_class: school_classes[0])
end
students[8..14].each do |student|
  StudentsClass.create!(student: student, school_class: school_classes[1])
end

# Load the courses seeder
require_relative 'seeds/courses'

# Create courses
puts "Creating courses..."
courses = [
  Course.create!(
    start_at: "08:00",
    end_at: "09:30",
    archived: false,
    subject: subjects[0],
    school_class: school_classes[0],
    moment: current_moment,
    teacher: teachers[0],
    week_day: 1
  ),
  Course.create!(
    start_at: "10:00",
    end_at: "11:30",
    archived: false,
    subject: subjects[1],
    school_class: school_classes[1],
    moment: current_moment,
    teacher: teachers[0],
    week_day: 2
  ),
  Course.create!(
    start_at: "13:30",
    end_at: "15:00",
    archived: false,
    subject: subjects[2],
    school_class: school_classes[0],
    moment: current_moment,
    teacher: teachers[1],
    week_day: 3
  ),
  Course.create!(
    start_at: "15:30",
    end_at: "17:00",
    archived: false,
    subject: subjects[3],
    school_class: school_classes[1],
    moment: current_moment,
    teacher: teachers[1],
    week_day: 4
  ),
  Course.create!(
    start_at: "08:00",
    end_at: "09:30",
    archived: false,
    subject: subjects[4],
    school_class: school_classes[0],
    moment: current_moment,
    teacher: teachers[2],
    week_day: 5
  ),
  Course.create!(
    start_at: "10:00",
    end_at: "11:30",
    archived: false,
    subject: subjects[5],
    school_class: school_classes[1],
    moment: current_moment,
    teacher: teachers[2],
    week_day: 5
  ),
  Course.create!(
    start_at: "13:30",
    end_at: "15:00",
    archived: false,
    subject: subjects[6],
    school_class: school_classes[0],
    moment: current_moment,
    teacher: teachers[3],
    week_day: 1
  ),
  Course.create!(
    start_at: "15:30",
    end_at: "17:00",
    archived: false,
    subject: subjects[7],
    school_class: school_classes[1],
    moment: current_moment,
    teacher: teachers[3],
    week_day: 2
  )
]

# Create examinations
puts "Creating examinations..."
examinations = [
  Examination.create!(
    title: "Mathematics Test",
    effective_date: Date.new(2024, 10, 15),
    course: courses[0]
  ),
  Examination.create!(
    title: "Physics Test",
    effective_date: Date.new(2024, 10, 16),
    course: courses[1]
  ),
  Examination.create!(
    title: "History Test",
    effective_date: Date.new(2024, 10, 17),
    course: courses[2]
  ),
  Examination.create!(
    title: "Geography Test",
    effective_date: Date.new(2024, 10, 18),
    course: courses[3]
  ),
  Examination.create!(
    title: "Computer Science Test",
    effective_date: Date.new(2024, 10, 19),
    course: courses[4]
  ),
  Examination.create!(
    title: "English Test",
    effective_date: Date.new(2024, 10, 20),
    course: courses[5]
  ),
  Examination.create!(
    title: "Biology Test",
    effective_date: Date.new(2024, 10, 21),
    course: courses[6]
  ),
  Examination.create!(
    title: "Chemistry Test",
    effective_date: Date.new(2024, 10, 22),
    course: courses[7]
  )
]

# Create grades
puts "Creating grades..."
students[0..7].each do |student|
  Grade.create!(
    value: rand(10..20),
    execute_on: Date.new(2024, 10, 15),
    examination: examinations[0],
    student: student
  )
end

students[8..14].each do |student|
  Grade.create!(
    value: rand(10..20),
    execute_on: Date.new(2024, 10, 16),
    examination: examinations[1],
    student: student
  )
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
puts "--------------------------------"

puts "\nVerifications of associations :"
puts "--------------------------------"
puts "First class (1A) : #{school_classes[0].students_classes.count} students"
puts "Second class (1B) : #{school_classes[1].students_classes.count} students"
puts "Number of courses per teacher :"
teachers.each do |teacher|
  puts "- #{teacher.full_name} : #{teacher.courses.count} courses"
end
puts "--------------------------------"

puts "\nSeeding completed!"

