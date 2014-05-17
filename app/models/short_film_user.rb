class ShortFilmUser < ActiveRecord::Base
  acts_as_authentic do |c|
    c.email_field = :director_email
    c.validate_email_field = false
  end

  GENRES = [
    :documentary,
    :fiction,
    :anime,
    :other
  ]

  LANGUAGES = [
    :english,
    :spanish,
    :catalonian,
    :no_sound,
    :other
  ]

  TUTOR_KINDS = [
    :mother,
    :father,
    :legal,
    :none
  ]

  strip_attributes
  log_book

  attr_protected nil

  validates :title, :presence => true
  validates :length_minutes, :presence => true
  validates :length_minutes, :numericality => { :less_than_or_equal_to => 7 }
  # validates :length_seconds, :presence => true
  validates :language, :presence => true
  validates :genre, :presence => true

  validates :synopsis, :presence => true
  validates :director_name, :presence => true
  validates :director_dni, :presence => true
  validates :director_date_of_birth, :presence => true
  validates :director_phone, :presence => true
  validates :director_email, :presence => true
  validates :director_email, :uniqueness => true, :format => { :with => RubyRegex::Email }

  validates :tutor_kind, :presence => true, :if => Proc.new { |e| e.underage? }
  validates :tutor_name, :presence => true, :if => Proc.new { |e| e.underage? }
  validates :tutor_dni, :presence => true, :if => Proc.new { |e| e.underage? }
  validates :tutor_phone, :presence => true, :if => Proc.new { |e| e.underage? }
  validates :tutor_email, :presence => true, :if => Proc.new { |e| e.underage? }

  validates :accept_authenticity, :acceptance => { :accept => true }
  validates :accept_authorization, :acceptance => { :accept => true }
  validates :accept_responsability, :acceptance => { :accept => true }

  validates :thumbnail, :attachment_presence => true

  scope :validated, -> { where(:moderation_accepted => true) }

  ATTACH_STYLES = {
    :front => "205x126#",
    :front_medium => "287x177#",
    :front_big => "600x",
    :admin => "303x203#"
  }

  # TODO: ugly! the point is that in test we don't use S3 so it needs another config
  if APP_CONFIG[:s3_credentials]
    has_attached_file(
      :thumbnail,
      :styles => ATTACH_STYLES,
      :storage => :s3,
      :s3_credentials => APP_CONFIG[:s3_credentials],
      :path => "/assets/uploads/:rails_env/:id/:style.:extension",
      :url => ":s3_domain_url"
    )
  else
    has_attached_file(
      :thumbnail,
      :styles => ATTACH_STYLES,
      :url => "/assets/uploads/:rails_env/:id/:style.:extension",
      :path => ":rails_root/public:url"
    )
  end

  def to_param
    "#{id}-#{title.to_url}"
  end

  def length
    "%02d:%02d" % [length_minutes, length_seconds]
  end

  # Yep!, I know this can be optimized :)
  def previous
    short_film_users = ShortFilmUser.all
    index = short_film_users.find_index(self)
    index > 0 ? short_film_users[index - 1] : nil
  end

  def next
    short_film_users = ShortFilmUser.all
    index = short_film_users.find_index(self)
    index < (short_film_users.length - 1) ? short_film_users[index + 1] : nil
  end

  def underage?
    return false if director_date_of_birth.nil?
    director_date_of_birth > 18.years.ago
  end

  def send_reset_password_email
    reset_perishable_token!
    Notifier.short_film_user_reset_password(self).deliver
  end
end
