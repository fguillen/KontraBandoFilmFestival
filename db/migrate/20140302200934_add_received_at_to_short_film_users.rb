class AddReceivedAtToShortFilmUsers < ActiveRecord::Migration
  def change
    add_column :short_film_users, :received_at, :datetime
  end
end
