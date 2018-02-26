class Admin::CustomersController < AdminController
  inherit_resources
  layout 'blank', only: ['new', 'edit']
  respond_to :html, :js
  before_filter :properties, only: ['new', 'edit', 'show']
  before_filter :set_partner, only: ['create', 'update']
  assign_params :code, :fullname,:title, :phone_number, :source_id, :private, :assign_user_id, :state_id, :created_by, :updated_by, :email, :note, property_matches_attributes: [:id, :object_id, :property_key, :property_value, :property_id, :photo], partner_ids: []


  def show
    @attactments = []
    @notes = resource.notes.order(created_at: :desc)
    show!
  end

  protected
    def properties
      @group_properties = GroupProperty.includes(:properties).where("group_type = ?", 'customers')
    end

    def collection
      @customers = Customer.joins(:partners).all
      # @customers = @customers.where("partners.id in (?)", [current_partner.id]) if current_partner

    end

    def set_partner
      params[:partner_ids] = [current_partner.id] if current_partner.present? && params[:partner_ids].blank?
    end
end
