class AdminsBackofficeController < ApplicationController
  # protegendo a página de administrador para quando tentar acessar sem login, ele barre o acesso
  before_action :authenticate_admin!

  layout 'admins_backoffice'
end
