module ApplicationHelper

  def csrf_input
    input = <<-HTML
      <input type="hidden"
         name="authenticity_token"
         value="#{form_authenticity_token}">
    HTML
    input.html_safe
  end

  def set_html_method(method)
    input = <<-HTML
      <input type="hidden" name="_method" value= "#{method}">
    HTML
    input.html_safe unless method.downcase.to_sym == :post
  end
end
