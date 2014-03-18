class ListesController < ApplicationController
  before_action :set_liste, only: [:show, :edit, :update, :destroy]
  before_action :can_admin?, only: [:edit, :update, :destroy, :massnew]
  before_action :can_moderate?, only: [:show]
  before_action :moderator?

  # GET /listes
  # GET /listes.json
  def index
    @listes = Liste.lists_for_user(current_user)
  end

  # GET /listes/1
  # GET /listes/1.json
  def show
    @change = Change.new
    @subscribers = Liste.subscribers(params[:id])
  end

  # GET /listes/new
  def new
    @liste = Liste.new
  end

  # GET /listes/1/edit
  def edit
  end

  def massnew
    alllistes = Liste.all
    paths = Path.all
    @unconfed = Array.new

    paths.each do |single|
      Dir.glob("#{single.path}*") { |f| 
        @unconfed << f if FileTest.directory?(f)     
      }
    end
    alllistes.each { |e|
      @unconfed.delete(e.bane) if @unconfed.include?(e.bane) 
    }
  end

  # POST /listes
  # POST /listes.json
  def create
    @liste = Liste.new(liste_params)

    respond_to do |format|
      if @liste.save
        format.html { redirect_to @liste, notice: 'Liste was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @liste }

        format.js   {}
        format.json { render json: @liste, status: :created, location: @liste }

      else
        format.html { render action: 'new' }
        format.json { render json: @liste.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listes/1
  # PATCH/PUT /listes/1.json
  def update
    respond_to do |format|
      if @liste.update(liste_params)
        format.html { redirect_to @liste, notice: 'Liste was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @liste.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listes/1
  # DELETE /listes/1.json
  def destroy
    @liste.destroy
    respond_to do |format|
      format.html { redirect_to listes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liste
      @liste = Liste.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def liste_params
      params.require(:liste).permit(:navn, :bane, :beskrivelse, {:group_ids => []})
    end

  end
