class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_votable
  acts_as_taggable

end
