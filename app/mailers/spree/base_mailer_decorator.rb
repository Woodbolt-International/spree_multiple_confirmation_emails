module AddAllRecipients
  def mail(headers={}, &block)
    headers[:to] = all_recipients
    super
  end
end

Spree::BaseMailer.class_eval do
  prepend AddAllRecipients

  private
  def all_recipients
    ""
  end
end
