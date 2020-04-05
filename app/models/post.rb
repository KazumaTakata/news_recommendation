class Post < ApplicationRecord
  has_many :counters
  has_many :users, through: :counters
end
