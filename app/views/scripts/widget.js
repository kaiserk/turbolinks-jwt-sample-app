var loadScript = function(url, callback){

    /* JavaScript that will load the jQuery library on Google's CDN.
       Once the jQuery library is loaded, the function passed as argument,
       callback, will be executed. */

    var script = document.createElement("script");
    script.type = "application/javascript";

    if (script.readyState) { //IE
        script.onreadystatechange = function() {
            if (script.readyState == "loaded" || script.readyState == "complete") {
                script.onreadystatechange = null;
                callback();
            }
        };
    } else { //Others
        script.onload = function() {
            callback();
        };
    }

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);

};

var unitPricing = {
  initiate: function(jQuery191) {
    // dont load on unsupported or unwanted pages
    if (!this.isWidgetEnabled()) {return false;}

    else {
      //Load Stylesheet
      var root = '<%= ENV["HOST"] %>',
          head = document.getElementsByTagName('head')[0],
          stylesheet = document.createElement('link');

      stylesheet.type = 'text/css';
      stylesheet.rel = 'stylesheet';
      stylesheet.href = root + '/widget.css';
      head.appendChild(stylesheet);

      $ = window.jQuery;
      console.log('Unit Pricing initiated.');
      this.getProductIdAndUnitPrice($);

      $('.insert-unit-pricing').each(function(index, el) {
        let product_id = $(this).attr('data-product');
        unitPricing.getUnitPriceForCollections(product_id, $(this));
      });

      $('.single-option-selector').change(function() {
        variant_id = window.location.href.split('variant=');
        variant_id = variant_id[1];
        unitPricing.getUnitPrice(variant_id, true);
        console.log(variant_id);
      });
    }
  },

  isWidgetEnabled: function () {
    var enabled = true;
    var metas = document.getElementsByTagName('meta');

    // html to disable unit pricing widget
    // <meta name='unitpricing:enabled' content='false'>

    for (i=0; i<metas.length; i++){
      if (metas[i].getAttribute('name') == 'unitpricing:enabled'){
        if (metas[i].getAttribute('content') === 'false'){
          enabled = false;
          console.log('Unit pricing disabled on this page.');
        }
      }
    }

    return enabled;
  },



  // deprecated - a collections url can still contain product (ie: collections/product-feed/products/coca-cola)
  isCollectionsPage: function() {
    var is_collection = false;
    var page_url = $(location).attr('href');
    if (page_url.indexOf('/collections/') > -1) { is_collection = true; }

    return is_collection;
  },

  getProductIdAndUnitPrice: function($) {
    var page_url = $(location).attr('href');
    if (page_url.indexOf('product') === -1) {return false;}

    // remove query params, if present
    if (page_url.indexOf('/?') > -1) {page_url = page_url.split( '/?' )[0];}
    if (page_url.indexOf('?') > -1) {page_url = page_url.split( '?' )[0];}

    $.ajax({
        url: page_url + '.json',
        success: function(data) {
          var product_id = data.product.id;
          unitPricing.getUnitPrice(product_id, false);
        }
    })

    var variant = $('#ProductSelect-product-template');
    if (!(variant == undefined || variant.length == 0)) {
      var variant_id = $('#ProductSelect-product-template option:selected').val();
      unitPricing.getUnitPrice(variant_id, true);
    }

  },

  getUnitPriceForCollections: function(product_id, this_element) {
    $.ajax({
      url: '<%= ENV["HOST"] %>' + '/unit_prices/' + product_id,
      method: 'get',
      success: function(data) {
        let unit_price = data.unit_price;
        let collection_label_text = '<%= @shop.preference.collection_label_text %>';
        let units = data.units;
        let content = '';

        if (data.is_variant) {
            content = '<div><span id="unit-price-label">' + collection_label_text + '</span></div>';
        } else {
          if (unit_price > 0) {
            let delimiter = '<%= @shop.preference.delimiter %>';
            let display_price = unit_price.toString().replace('.', delimiter);
              content = '<div><span id="unit-price-label">' + 
                '<%= @shop.preference.label_text %>&nbsp;' + 
                '<span id="unit-price-currency"><%= @shop.preference.currency %></span>' + 
                '<span id="unit-price-calc">' + display_price +
              '</span></div>';
          }
        }

        this_element.html(content);
      }
    });
    return false;

  },

  getUnitPrice: function(product_id, is_variant) {
    let url = '<%= ENV["HOST"] %>' + '/unit_prices/' + product_id;
    if (is_variant === true) {
      url = '<%= ENV["HOST"] %>' + '/unit_prices_variants/' + product_id;
    }
    $.ajax({
      url: url,
      method: 'get',
      success: function(data) {
        var unit_price = data.unit_price,
            variant_label_text = '<%= @shop.preference.variant_label_text %>',
            units = data.units;

        var pricing_area = unitPricing.getProductPageDropzone();
        var is_loaded = unitPricing.isUnitPriceDiv();

        if (unit_price > 0) {
          if (pricing_area) {
            var delimiter = '<%= @shop.preference.delimiter %>',
                display_price = unit_price.toString().replace('.', delimiter);
            if (!is_loaded) {
              if ('<%= @shop.preference.insert_order %>' == 'before') {
                $(pricing_area).before('<div id="unit-price-div"><span id="unit-price-label"><%= @shop.preference.label_text %> <span id="unit-price-currency"><%= @shop.preference.currency %></span><span id="unit-price-calc">'+display_price+'</span></div>');
              }
              else {
                $(pricing_area).after('<div id="unit-price-div"><span id="unit-price-label"><%= @shop.preference.label_text %> <span id="unit-price-currency"><%= @shop.preference.currency %></span><span id="unit-price-calc">'+display_price+'</span></div>');
              }
            } else {
              $('#unit-price-div').html('<span id="unit-price-label"><%= @shop.preference.label_text %> <span id="unit-price-currency"><%= @shop.preference.currency %></span><span id="unit-price-calc">'+display_price+'</span>');
            }
          }
          // send admin error alert with this page URL
          else { 
            console.log("Couldn't find pricing dropzone.") 
          }
        }

        //if (variant_label_text && variant_label_text.length > 0 && units && !is_loaded) {
          //$(pricing_area).after('<div id="unit-price-variant-div"><span id="unit-price-unit-count">'+units+'</span><span id="unit-price-variant-label"> '+variant_label_text+'</span></div>');
        //}
      }
    })
  },

  getProductPageDropzone: function() {
    var price = $('[itemprop="price"]');

    if (price == undefined || price.length == 0) {
      var price = $('.price:visible');
    }

    if (price == undefined || price.length == 0) {
      var price = $('#AddToCart');
    }

    if (price == undefined || price.length == 0) {
      var price = $('#addToCart');
    }

    if (price == undefined || price.length == 0) {
      var price = $('.product-price__price');
    }

    if (price.length >= 1) { return price; }
    else { return false; }
  },

  isUnitPriceDiv: function() {
    var price = $('#unit-price-div');
    if (price == undefined || price.length == 0) {
      return false;
    } else {
      return true;
    }
  },

  getProductPrice: function() {
    var price = $('[itemprop="price"]').attr('content');
    console.log('Price found: ' + price)
  },

  hideWidget: function() {
    $('#unit-price-calc').hide();
  }
};

if ((typeof jQuery === 'undefined') || (parseFloat(jQuery.fn.jquery) < 1.7)) {
    loadScript('//ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js', function(){
        jQuery = jQuery.noConflict(true);
        unitPricing.initiate(jQuery);
    });
} else {
    setTimeout(function() {
        (window.jQuery || loadScript("https://code.jquery.com/jquery-2.1.4.min.js", this.initiate()));
        unitPricing.initiate(jQuery);
    }, 500);
}