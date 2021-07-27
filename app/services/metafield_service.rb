class MetafieldService

  class << self
    def helpers
      ActionController::Base.helpers
    end

    # should also work to update existing* metafields
    def new_metafield_params(object) # => product, variant
      {
        "metafield" => {
          "namespace" => "unit_pricing",
          "key" => 'per',
          "value" => formatted_price(object),
          "value_type" => "string"
        }
      }
    end

    def formatted_price(object)
      helpers.number_with_precision(object.unit_price, precision: 2).to_s
    end

    def shopify_resource(object)
      object.class.to_s.downcase + 's'
    end

    def get_metafields(object)
      shop = object.shop

      resp = Curl.get("https://#{shop.domain}/admin/#{shopify_resource(object)}/#{object.shopify_id}/metafields.json?access_token=#{shop.token}") do |http|
        http.headers['Content-Type'] = 'application/json'
      end

      fields = resp.status.include?('20') ? JSON.parse(resp.body)['metafields'] : []
      if fields && fields.length > 0
        object.skip_callback(true)
        object.update(shopify_metafield_id: fields.first['id'])
      end
    end

    def save_metafield_id(object, response)
      metafield = JSON.parse(response.body)['metafield']
      object.skip_callback(true)
      object.update(shopify_metafield_id: metafield['id'])
    end

    def create_or_update(object)
      shop = object.shop
      params = new_metafield_params(object)
      resp = Curl.post("https://#{shop.shopify_domain}/admin/#{shopify_resource(object)}/#{object.shopify_id}/metafields.json?access_token=#{shop.shopify_token}", params.to_json) do |http|
        http.headers['Content-Type'] = 'application/json'
      end

      save_metafield_id(object, resp) if resp.status.include?('20')
      resp.status.include?('20')
    end

    def destroy_fields(object)
      return nil unless object.shopify_metafield_id?
      shop = object.shop

      resp = Curl.delete("https://#{shop.domain}/admin/#{shopify_resource(object)}/#{object.shopify_id}/metafields/#{object.shopify_metafield_id}.json?access_token=#{shop.token}") do |http|
        http.headers['Content-Type'] = 'application/json'
      end

      if resp.status.include?('20')
        object.update(shopify_metafield_id: nil) unless object.destroyed? # => dont update if object being deleted
        return true
      else
        return false
      end
    end

    def destroy(product)
      if product.variants.count > 0
        product.variants.each do |variant|
          destroy_fields(variant)
        end
      end

      destroy_fields(product)
    end
  end

end
