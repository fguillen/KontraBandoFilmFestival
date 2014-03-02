class AddPaidAtToShortFilmUsers < ActiveRecord::Migration
  def change
    add_column :short_film_users, :paid_at, :datetime
  end
end
