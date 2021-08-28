class PreferencesController < AuthenticatedController
  # protect_from_forgery except: :edit
  before_action :set_shop
  before_action :set_preference, only: [:show, :edit, :update, :destroy]

  # GET /preferences
  def index
    puts "PreferencesC index"
    redirect_to new_preference_path if @shop.preference.nil?
    redirect_to edit_preference_path(@shop.preference.id) if @shop.preference.present?
  end

  # GET /preferences/1
  def show
    puts "PreferencesC show"
  end

  # GET /preferences/new
  def new
    puts "PreferencesC new"
    @preference = Preference.new
  end

  # GET /preferences/1/edit
  def edit
    puts "PreferencesC edit"
  end

  # POST /preferences
  def create
    puts "PreferencesC create"
    @preference = @shop.build_preference(preference_params)
    coerce_currency

    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  def update
    puts "PreferencesC update"
    coerce_currency
    set_label_text

    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference, notice: 'Your preferences were saved successfully.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  def destroy
    puts "PreferencesC destroy"
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      @preference = Preference.find(params[:id])
    end

    def coerce_currency
      if preference_params['currency'] == 'Other'
        @preference.currency = params['other_currency']
      else
        symbol = Preference::CURRENCIES[preference_params['currency']]
        @preference.currency = symbol if symbol.present?
      end
    end

    def set_label_text
      label_text = preference_params['label_text']
      @preference.label_text = label_text
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:preference).permit(:currency, :label_text, :shop_id)
    end
end
