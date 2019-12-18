# frozen_string_literal: true

# registration controller of devise
class RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    user = User.find_by(username: params[:user][:username])
    if user.present?
      login_user(user)
    else
      build_resource(sign_up_params)
      save_resource(resource)
    end
  end

  def login_user(user)
    if user&.valid_password?(sign_up_params[:password])
      sign_in(user)
      respond_with user, location: after_sign_in_path_for(user)
    else
      flash[:errors] = ['Invalid email or password']
      redirect_to root_path
    end
  end

  def save_resource(resource)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      create_user_and_redirect(resource)
    else
      validate_resource(resource)
    end
  end

  def create_user_and_redirect(resource)
    if resource.active_for_authentication?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end

  def validate_resource(resource)
    clean_up_passwords resource
    flash[:errors] = resource.errors.full_messages
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
