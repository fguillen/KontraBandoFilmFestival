class InitShortFilmUserProducerDateOfBirth < ActiveRecord::Migration
  def up
    ShortFilmUser.where(:producer_date_of_birth => nil).each do |short_film_user|
      short_film_user.update_attributes!(:producer_date_of_birth => 19.years.ago)
    end

    change_column :short_film_users, :producer_date_of_birth, :date, :null => false
  end

  def down
    # nothing
  end
end
