require "test_helper"

class OnlinePurchaseTest < ActiveSupport::TestCase
  def setup
  end

  def test_should_be_valid
    assert(FactoryGirl.create(:online_purchase).valid?)
  end

  def test_set_authorize_params
    online_purchase = FactoryGirl.create(:online_purchase)
    online_purchase.set_authorize_params("https://url.com?token=THE-TOKEN&PayerID=THE-PAYER-ID")

    online_purchase.reload
    assert_equal("THE-TOKEN", online_purchase.token)
    assert_equal("THE-PAYER-ID", online_purchase.payer_id)
  end

  def test_pay
    short_film_user = FactoryGirl.create(:short_film_user)
    online_purchase = FactoryGirl.create(:online_purchase, :short_film_user => short_film_user, :payer_id => "PAYER-ID", :token => "TOKEN", :amount => 10)
    PaypalWrapper.expects(:pay).with("PAYER-ID", "TOKEN", 10)

    online_purchase.pay

    short_film_user.reload
    assert_not_nil(short_film_user.paid_at)
  end

  def test_cancel
    online_purchase = FactoryGirl.create(:online_purchase)
    online_purchase.cancel!
    online_purchase.reload

    assert_not_nil(online_purchase.canceled_at)
  end

end
