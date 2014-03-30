require "test_helper"

class Admin::OnlinePurchasesControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    online_purchase_1 = FactoryGirl.create(:online_purchase)
    online_purchase_2 = FactoryGirl.create(:online_purchase)

    get :index

    assert_template "admin/online_purchases/index"
    assert_equal([online_purchase_1, online_purchase_2].ids, assigns(:online_purchases).ids)
  end

  def test_show
    online_purchase = FactoryGirl.create(:online_purchase)

    get :show, :id => online_purchase

    assert_template "admin/online_purchases/show"
    assert_equal(online_purchase, assigns(:online_purchase))
  end

  def test_log_book_events
    online_purchase = FactoryGirl.create(:online_purchase)
    online_purchase.log_book_events << FactoryGirl.create(:log_book_event)

    get :log_book_events, :id => online_purchase

    assert_template "log_book_events"
  end
end
