class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2

    # method (find_for_google_oauth2) is in User model

    #The user must have already been created in the database (i.e. admin can create users with an email -
    # when the oauth process happens, this user is merged with the google oauth user)
    if User.where(:email => request.env['omniauth.auth'].info['email']).exists?
      @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]

        redirect_to new_user_registration_url
      end

    else
      flash[:error] = 'Not on the authorized user list. Please contact Tyler if this is an error.'
      redirect_to root_path
    end



  end

end