# enumerize :property_type, in: {string: 1, text: 2, select: 3, multiple_select: 4, single_choice: 5, multiple_choice: 6, number: 7, date_picker: 8, :file_upload: 9}

class PropertyTextInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'property_custom_input') do
      template.concat @builder.text_area(attribute_name, input_html_options)
    end
  end

  def input_html_options
    super.merge({class: 'form-control'})
  end
end


