class Admin::ProductsController < AdminController
  inherit_resources
  assign_params :name, :product_type, :user_id, :price, :discount_price, :category_id, :created_by, :updated_by, :reduction

  assign_created_by :product
  assign_updated_by :product

  # layout 'blank', only: ['new', 'show']
  respond_to :html, :js

  protected
    def collection
      @category_products = Category.includes(:products).all
    end
end

