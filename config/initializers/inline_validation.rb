ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    %{#{html_tag}#{instance.error_message.first}<span class="errorMessage" for="#{instance.send(:tag_id)}"></span>}.html_safe
  else
    %{#{html_tag}}.html_safe
  end
end

