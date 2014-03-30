class OnlinePurchase < ActiveRecord::Base
  attr_protected nil
  belongs_to :short_film_user

  validates :amount, :presence => true
  validates :description, :presence => true

  def set_authorize_params(authorize_response)
    paypal_params = PaypalWrapper.parse_authorize_response(authorize_response)

    update_attributes!(
      :token => paypal_params.token,
      :payer_id => paypal_params.payer_id
    )
  end

  def pay
    raise Exception, "OnlinePurchase [#{id}] already paid" if paid?

    PaypalWrapper.pay(payer_id, token, amount)
    update_attribute(:paid_at, Time.now)

    short_film_user.update_attributes!(:paid_at => Time.now)
  end

  def cancel!
    update_attributes!(:canceled_at => Time.now)
  end

  def paid?
    !paid_at.nil?
  end
end
