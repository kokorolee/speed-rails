class Admin::PropertiesController < AdminController
  inherit_resources
  layout 'blank', only: ['new', 'show']
  respond_to :html, :js

  assign_params :name, :group_property_id, :property_type, :property_required,
    :status, :internal_name, :intro

  protected

    def collection
      @group_properties = GroupProperty.includes(:properties).all
    end
end
