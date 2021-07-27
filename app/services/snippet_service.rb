class SnippetService

  class << self
    def snippet_params(shop)
      {
        "asset" => {
          "key" => "snippets/unit_pricing.liquid",
          "value" => (snippet_value(shop) || '').strip
        }
      }
    end

    def snippet_value(shop)
    %Q(
      {% if template contains 'collection' %}
        <script>console.log('up: on collection page');</script>
      {% endif %}
    )
    end

    def active_theme_id(shop)
      resp = Curl.get("https://#{shop.domain}/admin/api/2021-04/themes.json?access_token=#{shop.token}")
      themes = JSON.parse(resp.body)['themes']
      return unless themes

      themes.map {|theme| theme['id'] if theme['role'] == 'main'}.compact.join # => '8598767'
    end

    def get_snippet(shop)
      puts "SnippetService get_snippet"
      key = snippet_params(shop)['asset']['key']

      resp = Curl.get("https://#{shop.domain}/admin/api/2021-04/themes/#{active_theme_id(shop)}/assets.json?asset[key]=#{key}&access_token=#{shop.token}") do |http|
        http.headers['Content-Type'] = 'application/json'
      end

      JSON.parse(resp.body)['asset']
    end

    def create_or_update(shop)
      puts "SnippetService create_or_update"
      params = snippet_params(shop)

      resp = Curl.put("https://#{shop.domain}/admin/api/2021-04/themes/#{active_theme_id(shop)}/assets.json?access_token=#{shop.token}", params.to_json) do |http|
        http.headers['Content-Type'] = 'application/json'
      end

      resp.status.include?('20')
    end

    def destroy(shop)
      puts "SnippetService destroy"
      asset_name = snippet_params(shop)['asset']['key']

      resp = Curl.delete("https://#{shop.domain}/admin/api/2021-04/themes/#{active_theme_id(shop)}/assets.json?asset[key]=#{asset_name}&access_token=#{shop.token}") do |http|
        http.headers['Content-Type'] = 'application/json'
      end

      resp.status.include?('20')
    end
  end

end
