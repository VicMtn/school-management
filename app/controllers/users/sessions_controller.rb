class Users::SessionsController < Devise::SessionsController
  # skip the devise flash messages
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in) if false # never set flash message
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message!(:notice, :signed_out) if false # never set flash message
    yield if block_given?
    respond_to_on_destroy
  end
end 