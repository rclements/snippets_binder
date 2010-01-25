# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_snippets_binder_session',
  :secret      => 'd8b7173f21c1e4ab0baf8e64aad0627cbda253928dca5858adbe3dab4137a3d784b62395113e6cd133c1b8a3b407162764e045374dc028454bb2b9751fea1f3e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
