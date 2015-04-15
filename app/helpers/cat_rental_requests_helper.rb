module CatRentalRequestsHelper
  def hidden_patch
    <<-HTML.html_safe
    <input type="hidden" name="_method" value="PATCH">
    HTML
  end
end
