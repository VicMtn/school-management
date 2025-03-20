

# Cleaning database
puts "Cleaning database..."
[Grade, Examination, Course, StudentsClass, Subject, Person, Status, Address, Room, Sector, Moment, SchoolClass].each do |model|
  model.delete_all
end

# Create statuses
puts "Creating statuses..."
active_status = Status.create!(title: "Active", slug: "active")
inactive_status = Status.create!(title: "Inactive", slug: "inactive")

# Create addresses
puts "Creating addresses..."
addresses = [
  Address.create!(zip: 75001, town: "Paris", street: "Rue de Rivoli", number: "1"),
  Address.create!(zip: 75002, town: "Paris", street: "Rue Montorgueil", number: "2"),
  Address.create!(zip: 75003, town: "Paris", street: "Rue de Bretagne", number: "3"),
  Address.create!(zip: 75004, town: "Paris", street: "Rue des Archives", number: "4"),
  Address.create!(zip: 75005, town: "Paris", street: "Rue Mouffetard", number: "5"),
  Address.create!(zip: 75006, town: "Paris", street: "Rue de Seine", number: "6"),
  Address.create!(zip: 75007, town: "Paris", street: "Rue de Grenelle", number: "7"),
  Address.create!(zip: 75008, town: "Paris", street: "Avenue des Champs-Élysées", number: "8"),
  Address.create!(zip: 75009, town: "Paris", street: "Rue de la Paix", number: "9"),
  Address.create!(zip: 75010, town: "Paris", street: "Rue du Faubourg Saint-Martin", number: "10"),
  Address.create!(zip: 75011, town: "Paris", street: "Rue de la Roquette", number: "11"),
  Address.create!(zip: 75012, town: "Paris", street: "Rue de Charenton", number: "12"),
  Address.create!(zip: 75013, town: "Paris", street: "Rue de la Butte aux Cailles", number: "13"),
  Address.create!(zip: 75014, town: "Paris", street: "Rue du Montparnasse", number: "14"),
  Address.create!(zip: 75015, town: "Paris", street: "Rue de Vaugirard", number: "15"),
  Address.create!(zip: 75016, town: "Paris", street: "Avenue Victor Hugo", number: "16"),
  Address.create!(zip: 75017, town: "Paris", street: "Rue des Batignolles", number: "17"),
  Address.create!(zip: 75018, town: "Paris", street: "Rue de la Goutte d'Or", number: "18"),
  Address.create!(zip: 75019, town: "Paris", street: "Rue de Crimée", number: "19"),
  Address.create!(zip: 75020, town: "Paris", street: "Rue de Ménilmontant", number: "20")
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
  Sector.create!(name: "Lettres"),
  Sector.create!(name: "Arts"),
  Sector.create!(name: "Technologies")
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
    firstname: "Jean",
    lastname: "Dupont",
    email: "jean.dupont@school.com",
    phone_number: "0612345678",
    iban: "FR7630006000011234567890189",
    status: active_status,
    address: addresses[0]
  ),
  Dean.create!(
    username: "dean2",
    firstname: "Marie",
    lastname: "Martin",
    email: "marie.martin@school.com",
    phone_number: "0623456789",
    iban: "FR7630006000011234567890188",
    status: active_status,
    address: addresses[1]
  )
]

# Create teachers
puts "Creating teachers..."
teachers = [
  Teacher.create!(
    username: "teacher1",
    firstname: "Pierre",
    lastname: "Durand",
    email: "pierre.durand@school.com",
    phone_number: "0634567890",
    iban: "FR7630006000011234567890187",
    status: active_status,
    address: addresses[2]
  ),
  Teacher.create!(
    username: "teacher2",
    firstname: "Sophie",
    lastname: "Petit",
    email: "sophie.petit@school.com",
    phone_number: "0645678901",
    iban: "FR7630006000011234567890186",
    status: active_status,
    address: addresses[3]
  ),
  Teacher.create!(
    username: "teacher3",
    firstname: "Lucas",
    lastname: "Bernard",
    email: "lucas.bernard@school.com",
    phone_number: "0656789012",
    iban: "FR7630006000011234567890185",
    status: active_status,
    address: addresses[4]
  )
]

# Create subjects
puts "Creating subjects..."
subjects = [
  Subject.create!(
    slug: "math",
    name: "Mathématiques",
    teacher: teachers[0]
  ),
  Subject.create!(
    slug: "phys",
    name: "Physique",
    teacher: teachers[0]
  ),
  Subject.create!(
    slug: "hist",
    name: "Histoire",
    teacher: teachers[1]
  ),
  Subject.create!(
    slug: "geo",
    name: "Géographie",
    teacher: teachers[1]
  ),
  Subject.create!(
    slug: "info",
    name: "Informatique",
    teacher: teachers[2]
  ),
  Subject.create!(
    slug: "angl",
    name: "Anglais",
    teacher: teachers[2]
  )
]

# Create school classes
puts "Creating school classes..."
school_classes = [
  SchoolClass.create!(
    uid: "1A",
    name: "Première A",
    moment: current_moment,
    room: rooms[0],
    sector: sectors[0],
    master: deans[0]
  ),
  SchoolClass.create!(
    uid: "1B",
    name: "Première B",
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
    firstname: "Lucas",
    lastname: "Moreau",
    email: "lucas.moreau@school.com",
    phone_number: "0656789012",
    iban: "FR7630006000011234567890185",
    status: active_status,
    address: addresses[5]
  ),
  Student.create!(
    username: "student2",
    firstname: "Emma",
    lastname: "Laurent",
    email: "emma.laurent@school.com",
    phone_number: "0667890123",
    iban: "FR7630006000011234567890184",
    status: active_status,
    address: addresses[6]
  ),
  Student.create!(
    username: "student3",
    firstname: "Hugo",
    lastname: "Simon",
    email: "hugo.simon@school.com",
    phone_number: "0678901234",
    iban: "FR7630006000011234567890183",
    status: active_status,
    address: addresses[7]
  ),
  Student.create!(
    username: "student4",
    firstname: "Léa",
    lastname: "Michel",
    email: "lea.michel@school.com",
    phone_number: "0689012345",
    iban: "FR7630006000011234567890182",
    status: active_status,
    address: addresses[8]
  ),
  Student.create!(
    username: "student5",
    firstname: "Arthur",
    lastname: "Dubois",
    email: "arthur.dubois@school.com",
    phone_number: "0690123456",
    iban: "FR7630006000011234567890181",
    status: active_status,
    address: addresses[9]
  ),
  Student.create!(
    username: "student6",
    firstname: "Chloé",
    lastname: "Robert",
    email: "chloe.robert@school.com",
    phone_number: "0611234567",
    iban: "FR7630006000011234567890180",
    status: active_status,
    address: addresses[10]
  ),
  Student.create!(
    username: "student7",
    firstname: "Louis",
    lastname: "Richard",
    email: "louis.richard@school.com",
    phone_number: "0622345678",
    iban: "FR7630006000011234567890179",
    status: active_status,
    address: addresses[11]
  ),
  Student.create!(
    username: "student8",
    firstname: "Jade",
    lastname: "Petit",
    email: "jade.petit@school.com",
    phone_number: "0633456789",
    iban: "FR7630006000011234567890178",
    status: active_status,
    address: addresses[12]
  ),
  Student.create!(
    username: "student9",
    firstname: "Gabriel",
    lastname: "Durand",
    email: "gabriel.durand@school.com",
    phone_number: "0644567890",
    iban: "FR7630006000011234567890177",
    status: active_status,
    address: addresses[13]
  ),
  Student.create!(
    username: "student10",
    firstname: "Rose",
    lastname: "Leroy",
    email: "rose.leroy@school.com",
    phone_number: "0655678901",
    iban: "FR7630006000011234567890176",
    status: active_status,
    address: addresses[14]
  ),
  Student.create!(
    username: "student11",
    firstname: "Raphaël",
    lastname: "Morel",
    email: "raphael.morel@school.com",
    phone_number: "0666789012",
    iban: "FR7630006000011234567890175",
    status: active_status,
    address: addresses[15]
  ),
  Student.create!(
    username: "student12",
    firstname: "Alice",
    lastname: "Fournier",
    email: "alice.fournier@school.com",
    phone_number: "0677890123",
    iban: "FR7630006000011234567890174",
    status: active_status,
    address: addresses[16]
  ),
  Student.create!(
    username: "student13",
    firstname: "Adam",
    lastname: "Girard",
    email: "adam.girard@school.com",
    phone_number: "0688901234",
    iban: "FR7630006000011234567890173",
    status: active_status,
    address: addresses[17]
  ),
  Student.create!(
    username: "student14",
    firstname: "Lina",
    lastname: "Bonnet",
    email: "lina.bonnet@school.com",
    phone_number: "0699012345",
    iban: "FR7630006000011234567890172",
    status: active_status,
    address: addresses[18]
  ),
  Student.create!(
    username: "student15",
    firstname: "Noah",
    lastname: "Dupuis",
    email: "noah.dupuis@school.com",
    phone_number: "0610123456",
    iban: "FR7630006000011234567890171",
    status: active_status,
    address: addresses[19]
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
  )
]

# Create examinations
puts "Creating examinations..."
examinations = [
  Examination.create!(
    title: "Contrôle de Mathématiques",
    effective_date: Date.new(2024, 10, 15),
    course: courses[0]
  ),
  Examination.create!(
    title: "Contrôle de Physique",
    effective_date: Date.new(2024, 10, 16),
    course: courses[1]
  ),
  Examination.create!(
    title: "Contrôle d'Histoire",
    effective_date: Date.new(2024, 10, 17),
    course: courses[2]
  ),
  Examination.create!(
    title: "Contrôle de Géographie",
    effective_date: Date.new(2024, 10, 18),
    course: courses[3]
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
  puts "- #{teacher.full_name} : #{teacher.courses.count} cours"
end
puts "--------------------------------"

puts "\nSeeding completed!"

