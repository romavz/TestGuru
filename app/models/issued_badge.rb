class IssuedBadge < ApplicationRecord
  belongs_to :test_passage
  belongs_to :badge
end
