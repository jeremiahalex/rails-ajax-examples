class ThingsController < ApplicationController
  before_action :js_only, except: [:index] # any non js requests we can redirect back to the index page
  before_action :set_thing, only: [:show, :edit, :update, :destroy]

  # GET /things - our only html responding page
  def index
    @thing = Thing.new
    @things = Thing.all
  end

  # GET /things/1
  def show
  end

  # GET /things/new
  def new
    @thing = Thing.new
    render :form
  end

  # GET /things/1/edit
  def edit
    render :form
  end

  # POST /things
  def create
    @thing = Thing.new(thing_params)

    unless @thing.save
      render :form
    end
  end

  # PATCH/PUT /things/1
  def update
    # respond_to do |format|
      unless @thing.update(thing_params)
      else
        render :form
      end
  end

  # DELETE /things/1
  def destroy
    @removed_id = @thing.id
    @thing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = Thing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:name, :description)
    end

    def js_only
      if request.format != 'js'
        redirect_to things_url, notice: 'Javascript Only'
      end
    end
end
