class User < ActiveRecord::Base
  enum role: [:admin, :owner, :manager]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :manager
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]


  # method called in the users\omniauth_callback_controller.rb file
  # in that controller, the user's eamil is checked against the list of
  # approved_users. An error message saying  Not on the authorized list
  # is displayed if they are approved.
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    token = access_token.credentials["token"]
    refresh_token = access_token.credentials["refresh_token"]

    user = User.where(:email => data["email"]).first

    #The user must have already been created in the system
    if user
      user.name = data['name']
      user.first_name = data['first_name']
      user.last_name = data['last_name']
      user.token = token
      user.refresh_token = refresh_token
      user.save!
    end
    user
  end
end
