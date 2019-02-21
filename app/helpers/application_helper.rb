module ApplicationHelper
  def current_year
    Time.current.to_s(:only_year)
  end

  def github_url(account_name, repo_name)
    url = "https://github.com/#{account_name}/#{repo_name}"
    link_to(repo_name, url)
  end

  def flash_message
    msg = flash[:alert]
    content_tag :p, msg, class: 'flash alert' if msg.present?
  end
end
