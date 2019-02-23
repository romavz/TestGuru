module ApplicationHelper
  def current_year
    Time.current.to_s(:only_year)
  end

  def github_url(account_name, repo_name)
    url = "https://github.com/#{account_name}/#{repo_name}"
    link_to(repo_name, url)
  end

  def flash_message(type)
    msg = flash[type]
    content_tag :p, msg, class: "flash #{type}" if msg.present?
  end

  def app_name
    "TestGuru"
  end
end
