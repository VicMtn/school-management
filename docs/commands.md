# Addresses (has many people)
rails generate scaffold Address zip:integer town:string street:string number:string

# Rooms
rails generate scaffold Room name:string

# Status (has many people)
rails generate scaffold Status title:string slug:string

# People (belongs to an Address and a Status; has an enum role)
rails generate scaffold Person username:string lastname:string firstname:string email:string phone_number:string iban:string role:integer status:references address:references

# Sectors (has many SchoolClasses and PromotionAsserts)
rails generate scaffold Sector name:string

# Moments (has many SchoolClasses, Courses, and PromotionAsserts)
# Note: "type" is renamed to "moment_type" to avoid conflicts.
rails generate scaffold Moment uid:string start_on:date end_on:date moment_type:integer

# PromotionAsserts (belongs to a Moment and a Sector)
rails generate scaffold PromotionAssert description:string function:string moment:references sector:references

# Subjects (has many Courses; references a teacher from people)
rails generate scaffold Subject slug:string name:string teacher:references

# SchoolClasses (renamed from classes)
# It belongs to a Moment, Room, master (a Person), and Sector.
rails generate scaffold SchoolClass uid:string name:string moment:references room:references master:references sector:references

# StudentsClasses join model (for many-to-many between People (students) and SchoolClasses)
rails generate model StudentsClass student:references school_class:references

# Courses (belongs to Subject, SchoolClass, Moment, and a teacher; has an enum week_day)
rails generate scaffold Course start_at:time end_at:time archived:boolean subject:references school_class:references moment:references teacher:references week_day:integer

# Examinations (belongs to a Course; has many Grades)
rails generate scaffold Examination title:string effective_date:date course:references

# Grades (belongs to an Examination and a student (Person))
rails generate scaffold Grade value:integer execute_on:date examination:references student:references