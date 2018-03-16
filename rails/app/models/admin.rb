class Admin < User
    
    def send_welcome_mail
        UserMailer.admin_welcome_mail(self.name, self.email).deliver_later
    end
end