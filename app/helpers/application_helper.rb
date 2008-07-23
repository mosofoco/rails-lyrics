# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def alphabetical_browser(controller)
    browser = []
    for letter in ApplicationController::ALPHABET
      string = link_to letter.upcase, :controller => 'artists', :action => 'index', :letter => letter
      browser << string
    end
    browser.join(" ")
  end
end
