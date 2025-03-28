class Admin::PeopleController < Admin::BaseController
  before_action :set_person, only: [:create_user]

  def create_user
    if @person.user.present?
      flash[:alert] = "User account already exists for this person"
    else
      password = SecureRandom.hex(8)
      user = User.new(email: @person.email, password: password, password_confirmation: password)
      user.person = @person

      if user.save
        # TODO: Send email with credentials
        flash[:notice] = "User account created successfully. Temporary password: #{password}"
      else
        flash[:alert] = "Failed to create user account: #{user.errors.full_messages.join(', ')}"
      end
    end

    redirect_to admin_root_path
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end
end 