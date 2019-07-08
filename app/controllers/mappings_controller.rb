class MappingsController < ApplicationController
  require 'roo'

  def create
    @import = Mapping.new(file: params["mapping"]["file"])
    begin
      @file_items = open_spreadsheet @import.file
      sheet = @file_items.sheet(0).parse(headers: true).drop(1)
      data_import sheet
    rescue => e
      flash[:error] = e.message
    end
    redirect_to root_path
  end

  private

  def open_spreadsheet file
    case File.extname(file.original_filename)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def data_import sheet
    Mapping.delete_all
    Supplier.delete_all
    Product.delete_all
    @suppliers_hash = {}
    @products_hash = {}
    sheet.each do |hash|
      unless @suppliers_hash[hash["supplier_id"]]
        create_supplier hash
      end
      unless @suppliers_hash[hash["product_id"]]
        create_product hash
      end
      if @suppliers_hash[hash["supplier_id"]] && @products_hash[hash["product_id"]]
        establish_mapping hash
      end
    end
  end

  def create_supplier hash
    supplier = Supplier.new(name: hash["supplier_name"])
    if supplier.save
      @suppliers_hash[hash["supplier_id"]] = supplier
    end
  end

  def create_product hash
    product = Product.new(title: hash["product_title"], category: hash["category"], price: hash["price"])
    if product.save
      @products_hash[hash["product_id"]] = product
    end
  end

  def establish_mapping hash
    mapping = Mapping.new(supplier_id: @suppliers_hash[hash["supplier_id"]].id, product_id: @products_hash[hash["product_id"]].id, is_active: (hash["is_active"] == 1))
    mapping.save
  end

end
