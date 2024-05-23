class UsersBackofficeController < ApplicationController
  # protegendo a página de usuário para quando tentar acessar sem login, ele barre o acesso
  before_action :authenticate_user!

  layout 'users_backoffice'
end
