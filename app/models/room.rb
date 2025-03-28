class Room < ApplicationRecord
    has_many :courses
    has_many :school_classes, through: :courses
    has_many :teachers, through: :courses
    has_many :subjects, through: :courses

    validates :name, presence: true, uniqueness: true

    
end
