class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :authenticate_credential!

  def current_agent
    current_credential.agent
  end
end
