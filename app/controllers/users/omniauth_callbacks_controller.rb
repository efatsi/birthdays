class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.where(omniauth_hash.slice(:provider, :uid)).first_or_create

    @user.update_attributes(credentials)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private

  def omniauth_hash
    request.env["omniauth.auth"]
  end

  def credentials
    {
      :provider => omniauth_hash.provider,
      :uid      => omniauth_hash.uid,
      :email    => omniauth_hash.info.email,
      :token    => omniauth_hash.credentials.token,
      :password => Devise.friendly_token[0,20],
      :name     => omniauth_hash.info.name,
      :image    => omniauth_hash.info.image
    }
  end
end
