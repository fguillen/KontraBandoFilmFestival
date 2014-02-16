KontraBandoFilmFestival::Application.config.session_store :active_record_store, :key => '_KontrabandoFilmFestival_session'
ActiveRecord::SessionStore::Session.attr_accessible :data, :session_id
