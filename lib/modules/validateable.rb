# Validate if a page has a success HTTP code and the document read from the page is not null

module Validateable
  def is_valid(page)
    return page.code == 200 && page.doc != nil?
  end
end