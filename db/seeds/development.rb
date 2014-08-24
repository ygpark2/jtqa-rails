
# This will be run during `rake db:seed` in the :development environment.

include Sprig::Helpers

sprig [Role, User, Brisbane, Sydney, Melbourne, Comment]
