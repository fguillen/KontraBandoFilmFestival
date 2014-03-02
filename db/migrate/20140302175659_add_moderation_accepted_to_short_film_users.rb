class AddModerationAcceptedToShortFilmUsers < ActiveRecord::Migration
  def change
    add_column :short_film_users, :moderation_accepted, :boolean
  end
end
