class ImagePreviewInput < SimpleForm::Inputs::FileInput
    def input(wrapper_options=nil)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      url = preview_url(merged_input_options)

      out = ''
      template.content_tag(:div, class: 'form-group property_custom_input') do
        out << template.image_tag(url, class: 'img-responsive foxy-image-property') if url
        out << @builder.input("#{attribute_name}_cache", as: 'hidden')
      end
      (out << super).html_safe
    end

    private

    def preview_url(merged_input_options)
      use_default_url = options.delete(:use_default_url) || false
      version = merged_input_options.delete(:preview_version)

      if merged_input_options[:preview_url]
        merged_input_options[:preview_url]
      elsif object && object.send("#{attribute_name}?") || use_default_url
        object.send(attribute_name).tap {|o| break o.send(version) if version}.send('url')
      end
    end
  end