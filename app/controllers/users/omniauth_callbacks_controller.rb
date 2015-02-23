class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2

    # You need to implement the method (find_for_google_oauth2) below in your model (e.g. app/models/user.rb)
    data = request.env['omniauth.auth'].info
    if User.where(:email => data['email']).exists?
      @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end

    else
      flash[:error] = "Not on the authorized user list. Please contact Tyler if this is an error."
      redirect_to root_path
    end



  end

end