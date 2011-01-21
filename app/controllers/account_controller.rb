class AccountController < ApplicationController
  def login
  end

  def authenticate  
    self.logged_in_user = User.authenticate(params[:user][:email], params[:user][:password])
       if is_logged_in?
           redirect_to index_url
        else
           flash[:error] = "Nieprawidłowy login lub hasło"
           redirect_to :action => 'login'
        end
  end
  
  
  def logout
    if request.post?
      reset_session
      flash[:notice] = "Wylogowano pomyślnie"
    end
    redirect_to index_url
  end

end
