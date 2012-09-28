class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:failure] = "registration is not allowed"
    redirect_to root_path
  end
end
