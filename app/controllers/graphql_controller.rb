class GraphqlController < AuthenticatedController
  before_action :set_shop
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :null_session, unless: -> { request.local? }

  def index
    @shop_origin = current_shopify_domain
    @shop_id = @shop.id
  end

  def execute
    variables = prepare_variables(params[:variables])
    # variables = { shopId: @shop.id }
    variables[:shopId] = @shop.id
    puts '*** variables ***'
    puts variables

    query = params[:query]

    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = TurbolinksJwtTest2Schema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    # puts variables_param
    # puts @shop.id
    # variables_param['shop_id'] = @shop.id
    # puts variables_param
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
