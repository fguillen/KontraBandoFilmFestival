class ModifyShortFilmUserCreditsActors < ActiveRecord::Migration
  def up
    change_column :short_film_users, :credits_actors, :text
  end

  def down
    # nothing
  end
end
