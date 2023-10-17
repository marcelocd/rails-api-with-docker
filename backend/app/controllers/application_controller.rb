class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :authenticate_user!
end
