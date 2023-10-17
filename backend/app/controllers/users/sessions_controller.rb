# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionFix

  respond_to :json

  before_action :configure_sign_in_params, only: :create

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email username])
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: I18n.t('devise.sessions.logged_in') },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: I18n.t('devise.sessions.logged_out')
      }, status: :ok
    else
      render json: {
        status: 401,
        message: I18n.t('devise.failure.no_active_session')
      }, status: :unauthorized
    end
  end
end
