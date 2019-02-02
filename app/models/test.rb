class Test < ApplicationRecord
  belongs_to :category

  def self.pluck_by_category(title)
    self.joins("
      INNER JOIN categories ON tests.category_id = categories.id
    ").
    where(
      categories: { title: title }
    ).
    pluck(:title)
  end

end
