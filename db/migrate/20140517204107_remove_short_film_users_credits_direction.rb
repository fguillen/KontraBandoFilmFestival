class RemoveShortFilmUsersCreditsDirection < ActiveRecord::Migration
  def change
    remove_column :short_film_users, :credits_direction
  end
end
