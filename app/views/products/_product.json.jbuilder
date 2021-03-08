json.extract! product, :id, :name, :price, :material_id, :description, :like, :created_at, :updated_at
json.url product_url(product, format: :json)
