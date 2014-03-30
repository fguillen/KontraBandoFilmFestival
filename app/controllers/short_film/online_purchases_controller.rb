class ShortFilm::OnlinePurchasesController < ShortFilm::ShortFilmController
  before_filter :require_short_film_user, :only => [:create]

  def create
    online_purchase =
      OnlinePurchase.create!(
        :short_film_user_id => current_short_film_user.id,
        :description => t("controllers.online_purchases.create.description"),
        :amount => APP_CONFIG[:fee_euros]
      )

    url =
      PaypalWrapper.get_authorization_url(
        t("controllers.online_purchases.create.description"),
        APP_CONFIG[:fee_euros],
        confirm_short_film_online_purchase_url(online_purchase),
        cancel_short_film_online_purchase_url(online_purchase)
      )

    redirect_to url
  end

  def confirm
    online_purchase = OnlinePurchase.find(params[:id])
    online_purchase.set_authorize_params(request.url)
    online_purchase.pay

    redirect_to [:short_film, online_purchase.short_film_user], :notice => t("controllers.online_purchases.confirmed")
  end

  def cancel
    online_purchase = OnlinePurchase.find(params[:id])
    online_purchase.cancel!

    redirect_to [:short_film, online_purchase.short_film_user], :alert => t("controllers.online_purchases.canceled")
  end

private

  def load_short_film_user
    @short_film_user = ShortFilmUser.find(params[:id])
  end
end