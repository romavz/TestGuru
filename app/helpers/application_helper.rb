module ApplicationHelper
  def current_year
    DateTime.now.to_s(:only_year)
  end

  def github_url(title, repo)
    "Project source: #{link_to(title, repo)}"
  end

end
