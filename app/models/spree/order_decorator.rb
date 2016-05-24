module Spree
  Order.class_eval do
    validates :additional_confirmation_emails,
              :format => { :with => /(\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})(,\s*([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,}))*\z)/i },
              :allow_blank => true

    def all_recipients
      additional_confirmation_emails_to_a.unshift(email).join(",")
    end

    def additional_confirmation_emails_to_a
      additional_confirmation_emails.split(/\s*,\s*/)
    end
  end
end
