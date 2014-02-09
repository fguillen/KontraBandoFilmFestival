require "test_helper"

class ShortFilmUserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:short_film_user).valid?
  end
end
