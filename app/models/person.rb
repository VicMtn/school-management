class Person < ApplicationRecord
  include PersonType
  include SoftDeletable
  
  belongs_to :status
  belongs_to :address
  belongs_to :user, optional: true
  has_many :addresses, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: true
  validates :iban, presence: true

  def full_name
    "#{firstname} #{lastname}"
  end

  def create_user_account(password)
    return if user.present?
    
    user = User.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
    update!(user: user)
  end
end
