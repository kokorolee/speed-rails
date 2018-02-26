class Admin::PartnerTypesController < AdminController
  inherit_resources

  assign_params :name, :reduction, :condition, :desc, :status, :value_condition

  def create
    super do |format|
      format.html {redirect_to admin_partner_types_path()}
    end
  end

  def update
    super do |format|
      format.html {redirect_to admin_partner_types_path()}
    end
  end

  def collection
    @collection = PartnerType.all
  end

end