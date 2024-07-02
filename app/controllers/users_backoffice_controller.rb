class UsersBackofficeController < ApplicationController
  # protegendo a página de usuário para quando tentar acessar sem login, ele barre o acesso
  before_action :authenticate_user!
  before_action :build_profile

  layout 'users_backoffice'

  private

  def build_profile
    current_user.build_user_profile if current_user.user_profile.blank?
  end
end
