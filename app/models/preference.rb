class Preference < ActiveRecord::Base
  belongs_to :shop

  CURRENCIES = {'AUD' => 'AU$', 'DKK' => 'kr', 'EUR' => '€', 'GBP' => '£', 'CHF' => 'SFr. ', 'USD' => '$', 'Other' => ''}

  after_update :update_theme_snippet

  def update_theme_snippet
    return true unless self.shop.theme_scope_enabled? # => legacy users don't have this feature
    return true if self.shop.snippet_locked? # => legacy users don't have this feature

    #SnippetService.create_or_update(self.shop)
  end

  def get_friendly_currency
    if CURRENCIES.key(self.currency) == nil
      return self.currency
    else
      return CURRENCIES.key(self.currency)
    end
  end

  def get_currency_code
    CURRENCIES.each do |key, variable|
      if self.currency == variable
        return key
      end
    end
    return "Other"
  end

end
