class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :facebook, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
      @user = User.find_for_oauth(env["omniauth.auth"], current_user)
      auth = request.env['omniauth.auth']
      @identity = Identity.find_for_oauth(auth)
      
      # 새로운 유저라면?
      if @user.persisted?
        
         # 가입형식별 redirct
        if @identity.provider == "twitter"
          register_info2_path
        else
          register_info1_path
        end
        
      # 이미 있는 유저라면?
      else
        home_main_path
      end  
  end
end