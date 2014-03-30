require "test_helper"

class ShortFilm::OnlinePurchasesControllerTest < ActionController::TestCase
  def setup
  end

  def test_create
    setup_short_film_user

    OnlinePurchase.any_instance.stubs(:to_param).returns("ONLINE_PAYMENT_ID")

    PaypalWrapper.expects(:get_authorization_url).with(
      I18n.t("controllers.online_purchases.create.description"),
      15.00,
      "http://test.host/short_film/online_purchases/ONLINE_PAYMENT_ID/confirm",
      "http://test.host/short_film/online_purchases/ONLINE_PAYMENT_ID/cancel",
    ).returns("http://authorized.url")

    assert_difference "OnlinePurchase.count", 1 do
      post(
        :create
      )
    end

    assert_redirected_to "http://authorized.url"

    online_purchase = OnlinePurchase.last
    assert_equal(@short_film_user, online_purchase.short_film_user)
  end

  def test_confirm
    short_film_user = FactoryGirl.create(:short_film_user)
    online_purchase = FactoryGirl.create(:online_purchase, :short_film_user => short_film_user)

    OnlinePurchase.any_instance.expects(:set_authorize_params)
    OnlinePurchase.any_instance.expects(:pay)

    get(:confirm, :id => online_purchase)

    assert_redirected_to [:short_film, short_film_user]
    assert_not_nil(flash[:notice])
  end

  def test_cancel
    short_film_user = FactoryGirl.create(:short_film_user)
    online_purchase = FactoryGirl.create(:online_purchase, :short_film_user => short_film_user)

    get(:cancel, :id => online_purchase)

    assert_redirected_to [:short_film, short_film_user]
    assert_not_nil(flash[:alert])

    online_purchase.reload
    assert_not_nil(online_purchase.canceled_at)
  end
end
