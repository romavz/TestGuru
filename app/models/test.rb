class Test < ApplicationRecord
  belongs_to :category

  def self.take_titles_by_category(title)
    self.joins("
      INNER JOIN categories
        ON tests.category_id = categories.id
    ").
    where(
      categories: { title: title }
    ).
    order(title: :desc).
    pluck(:title)
  end

end
