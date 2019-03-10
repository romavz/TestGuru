class Gist < ApplicationRecord
  belongs_to :users
  belongs_to :questions
end
