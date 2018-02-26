class Property < ApplicationRecord
  belongs_to :group_property

  enumerize :property_type, in: {string: 1, text: 2, select: 3, multiple_select: 4, single_choice: 5, multiple_choice: 6, number: 7, date_picker: 8, file_upload: 9}

  after_create :assign_to_table

  protected

    def assign_to_table
      table = self.group_property.group_type.classify.constantize

      data = table.all

      data.each do |dt|
        PropertyMatch.create({property_id: self.id,
          property_key: self.internal_name, property_value: '', object_id: dt.id})
      end

    end
end
