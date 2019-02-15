module ApplicationHelper
  def current_year
    DateTime.now.to_s(:only_year)
  end
end
