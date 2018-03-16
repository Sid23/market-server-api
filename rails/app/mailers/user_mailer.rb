class UserMailer < ApplicationMailer

    def user_welcome_mail(name, email)
        @name = name
        mail subject: "#{@name} welcome in market place!", to: email
    end
    
    def admin_welcome_mail(name, email)
        @name = name
        mail subject: "You are now Admin of market-place-api-server!", to: email
    end

end
