# enumerize :property_type, in: {string: 1, text: 2, select: 3, multiple_select: 4, single_choice: 5, multiple_choice: 6, number: 7, date_picker: 8, :file_upload: 9}

class PropertySelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    collection = input_html_options["data-collection"]

    label_method = :to_s
    value_method = :to_s

    @builder.collection_select(
      attribute_name, collection, value_method, label_method,
      input_options, input_html_options
    )
  end

  def input_html_options
    super.merge({class: 'form-control choz'})
  end
end


