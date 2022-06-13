module ApplicationHelper
  def full_title(pageTitle)
    return "MICROPOSTS" if pageTitle.blank?
    "#{pageTitle} | MP"
  end
end
