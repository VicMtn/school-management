# Generation Commands for School Management Application

### Generate users with Devise
rails generate devise:install
rails generate devise User

### Addresses (has many people)
rails generate scaffold Address zip:integer town:string street:string number:string

### Statuses (has many people)
rails generate scaffold Status title:string slug:string

### Rooms
rails generate scaffold Room name:string

### Sectors
rails generate scaffold Sector name:string

### Moments
rails generate scaffold Moment uid:string start_on:date end_on:date moment_type:integer

### People (child classes: Student, Teacher, etc.)
rails generate scaffold Person username:string lastname:string firstname:string email:string phone_number:string iban:string role:integer status:references address:references user:references

### Add type for STI and soft delete
rails generate migration AddTypeAndDeletedAtToPeople type:string deleted_at:datetime

### SchoolClasses
rails generate scaffold SchoolClass uid:string name:string moment:references room:references master:references sector:references

### Add deleted_at to SchoolClass for soft delete
rails generate migration AddDeletedAtToSchoolClasses deleted_at:datetime

### StudentsClasses (join table)
rails generate model StudentsClass student:references school_class:references

### Add deleted_at to StudentsClasses for soft delete
rails generate migration AddDeletedAtToStudentsClasses deleted_at:datetime

### Subjects
rails generate scaffold Subject slug:string name:string teacher:references

### Add sector_id and deleted_at to Subjects
rails generate migration AddSectorIdAndDeletedAtToSubjects sector:references deleted_at:datetime

### Courses
rails generate scaffold Course start_at:time end_at:time archived:boolean subject:references school_class:references moment:references teacher:references week_day:integer

### Add deleted_at and room_id to Courses
rails generate migration AddDeletedAtAndRoomIdToCourses deleted_at:datetime room:references

### Examinations
rails generate scaffold Examination title:string effective_date:date course:references

### Add deleted_at to Examinations
rails generate migration AddDeletedAtToExaminations deleted_at:datetime

### Grades
rails generate scaffold Grade value:integer execute_on:date examination:references student:references

### Add execution_date and deleted_at to Grades
rails generate migration AddExecutionDateAndDeletedAtToGrades execution_date:datetime deleted_at:datetime

### PromotionAsserts
rails generate scaffold PromotionAssert description:string function:string moment:references sector:references

### Add deleted_at to PromotionAsserts
rails generate migration AddDeletedAtToPromotionAsserts deleted_at:datetime

### Configure generated migrations to add indexes and constraints if needed

### Run migrations
rails db:migrate