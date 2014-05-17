require "test_helper"

class ShortFilmUserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:short_film_user).valid?
  end

  def test_length
    short_film_user = FactoryGirl.create(:short_film_user, :length_minutes => 1, :length_seconds => 2)
    assert_equal("01:02", short_film_user.length)

    short_film_user = FactoryGirl.create(:short_film_user, :length_minutes => 6, :length_seconds => 20)
    assert_equal("06:20", short_film_user.length)
  end

  def test_previous
    short_film_user_1 = FactoryGirl.create(:short_film_user)
    short_film_user_2 = FactoryGirl.create(:short_film_user)

    assert_equal(nil, short_film_user_1.previous)
    assert_equal(short_film_user_1.id, short_film_user_2.previous.id)
  end

  def test_next
    short_film_user_1 = FactoryGirl.create(:short_film_user)
    short_film_user_2 = FactoryGirl.create(:short_film_user)

    assert_equal(short_film_user_2.id, short_film_user_1.next.id)
    assert_equal(nil, short_film_user_2.next)
  end

  def test_scope_validated
    short_film_user_1 = FactoryGirl.create(:short_film_user, :moderation_accepted => false)
    short_film_user_2 = FactoryGirl.create(:short_film_user, :moderation_accepted => true)

    assert_ids([short_film_user_2], ShortFilmUser.validated)
  end

  def test_validate_tutor_fields_if_lower_age
    short_film_user = FactoryGirl.create(:short_film_user, :director_date_of_birth => "1990-01-01")
    assert_equal(true, short_film_user.valid?)

    short_film_user.director_date_of_birth = "2000-01-01"
    assert_equal(false, short_film_user.valid?)

    assert_equal(true, short_film_user.errors.include?(:tutor_kind))
    assert_equal(true, short_film_user.errors.include?(:tutor_name))
    assert_equal(true, short_film_user.errors.include?(:tutor_phone))
    assert_equal(true, short_film_user.errors.include?(:tutor_email))
    assert_equal(true, short_film_user.errors.include?(:tutor_dni))

    short_film_user.tutor_kind = "mother"
    short_film_user.tutor_name = "tutor name"
    short_film_user.tutor_phone = "tutor phone"
    short_film_user.tutor_email = "email@email.com"
    short_film_user.tutor_dni = "tutor dni"

    assert_equal(true, short_film_user.valid?)
  end

  def test_underage
    short_film_user = FactoryGirl.build(:short_film_user)

    short_film_user.director_date_of_birth = nil
    assert_equal(false, short_film_user.underage?)

    short_film_user.director_date_of_birth = "1990-01-01"
    assert_equal(false, short_film_user.underage?)

    short_film_user.director_date_of_birth = 16.years.ago
    assert_equal(true, short_film_user.underage?)

  end
end
