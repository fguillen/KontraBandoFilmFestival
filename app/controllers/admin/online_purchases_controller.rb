class Admin::OnlinePurchasesController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_online_purchase, :only => [:show, :log_book_events]

  def index
    @online_purchases = OnlinePurchase.all
  end

  def show
  end

  def log_book_events
    @log_book_events = @online_purchase.log_book_events.by_recent.paginate(:page => params[:page], :per_page => 10)
  end

private

  def load_online_purchase
    @online_purchase = OnlinePurchase.find(params[:id])
  end
end
