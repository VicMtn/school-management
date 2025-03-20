class Person < ApplicationRecord
  belongs_to :status
  belongs_to :address

  validates :username, presence: true, uniqueness: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: true
  validates :iban, presence: true

  def full_name
    "#{firstname} #{lastname}"
  end
end
