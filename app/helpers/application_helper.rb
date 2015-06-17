module ApplicationHelper

  def date_fix(date)
    date.strftime("%m/%d/%Y %l: %M%P %Z")
  end
end
