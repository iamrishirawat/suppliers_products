class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.includes(:mappings).all
    @suppliers.each { |s|
      s.active = s.mappings.where(is_active: true).size
      s.total = s.mappings.size
    }

    @items_import = Mapping.new
  end

  def show
    @supplier = Supplier.where(id: params["id"]).includes(products: :mappings).where(products: {mappings: {supplier_id: params["id"]}}).first
    p @supplier
  end

end
