class StuffController < ApplicationController
  before_action :js_only, except: [:index] # any non json requests we can redirect back to the index page
  before_action :set_stuff, only: [:update, :destroy]

  # GET /stuffs - our only html responding page
  def index
    @stuff = Thing.new
    @stuffs = Thing.all

    # we respond to both json and html, so our ajax can refresh the list view
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stuffs }
     end
  end

  # POST /stuffs
  def create
    @stuff = Thing.new(stuff_params)
      if @stuff.save
        render json: @stuff
      else
        render json: { :errors => @stuff.errors.full_messages }, :status => :unprocessable_entity
      end
  end

  # PATCH/PUT /stuffs/1
  def update
    # respond_to do |format|
      if @stuff.update(stuff_params)
        render json: @stuff
      else
        render json: { :errors => @stuff.errors.full_messages }, :status => :unprocessable_entity
      end
  end

  # DELETE /stuffs/1
  def destroy
    @stuff.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stuff
      @stuff = Thing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stuff_params
      params.require(:stuff).permit(:name, :description)
    end

    def js_only
      if request.format == 'html'
        puts request.format
        redirect_to stuffs_url, notice: 'JSON Only'
      end
    end
end
