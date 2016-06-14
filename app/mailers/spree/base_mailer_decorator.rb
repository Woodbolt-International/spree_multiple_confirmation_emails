module AddAllRecipients
  def mail(headers = {}, &block)
    headers[:to] = all_recipients if all_recipients.present?
    super
  end
end

Spree::BaseMailer.class_eval do
  prepend AddAllRecipients

  private

  # this method will be implemented in each mailer_decorator
  # retrieving order.all_recipients from the mailer context object
  def all_recipients
    ""
  end
end
