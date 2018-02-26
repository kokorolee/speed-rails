class Admin::OrdersController < AdminController
  inherit_resources
  assign_params :id, :order_no, :order_date, :state, :customer_id, :discount_type, :discount_value, order_items_attributes: [:id, :product_id, :order_id, :qty, :user_id]

  assign_created_by :order
  assign_updated_by :order
  before_action :prepare_data, only: ['index', 'new', 'show']
  # layout :false, only: ['new', 'edit']
  respond_to :html, :js

  protected
    def prepare_data
      @category_products = Category.includes(:products).all
    end

    def collection
      @order = Order.new
      @orders = Order.all
    end
end

