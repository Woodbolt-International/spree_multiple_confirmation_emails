require 'spec_helper'
require 'email_spec'

describe Spree::ReimbursementMailer, :type => :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:reimbursement) { create(:reimbursement) }

  before do
    reimbursement.order.email = Faker::Internet.email
  end

  context "when order does have multiple recipients" do
    before do
      reimbursement.order.additional_confirmation_emails = 3.times.map { Faker::Internet.email }.join(",")
    end

    it "sends reimbursement email to all recipients" do
      message = Spree::ReimbursementMailer.reimbursement_email(reimbursement)
      message.deliver_now
      expect(message.to).to eq(reimbursement.order.all_recipients.split(","))
      expect(ActionMailer::Base.deliveries.count).to eq 1
      expect(ActionMailer::Base.deliveries.first.to).to eq(reimbursement.order.all_recipients.split(","))
    end
  end

  context "when order does not have multiple recipients" do
    before do
      reimbursement.order.additional_confirmation_emails = ""
    end

    it "sends reimbursement email just to order customer" do
      message = Spree::ReimbursementMailer.reimbursement_email(reimbursement)
      message.deliver_now
      expect(message.to).to eq([reimbursement.order.email])
      expect(ActionMailer::Base.deliveries.count).to eq 1
      expect(ActionMailer::Base.deliveries.first.to).to eq([reimbursement.order.email])
    end
  end
end
