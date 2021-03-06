class ChangesController < ApplicationController
  before_action :set_change, only: [:show, :edit, :update, :destroy]
  before_action :moderator?

  # GET /changes
  # GET /changes.json
  def index
    @changes = Change.all
  end

  # GET /changes/1
  # GET /changes/1.json
  def show
  end

  # GET /changes/new
  def new
    @change = Change.new
  end

  # GET /changes/1/edit
  def edit
  end

  # POST /changes
  # POST /changes.json
  def create
    listbane = change_params[:listbane]
    @change = Change.new(change_params.except(:listbane))
    @change[:user_id] = current_user.id
    liste = Liste.find_by(bane: listbane)
    @change[:list_id] = liste.id

    respond_to do |format|
      if Liste.mlmmj_sub(change_params[:added_adresses], liste.id) && Liste.mlmmj_unsub(change_params[:removed_adresses], liste.id)
        if @change.save
          format.html { redirect_to @change, notice: "Change was successfully created."   }
          format.json { render json: @change, status: :created, location: @change }
        else
          format.html { redirect_to @change, notice: "Change was not created, check list!."   }
          format.json { render json: 'show', status: :created, location: @change }

#          format.html { render action: 'new' }
#          format.json { render json: @change.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @change, notice: "Change was not created, check list!."   }
#        format.html { render action: 'new' }
        format.json { render json: @change.errors, status: :unprocessable_entity }       
      end
    end
  end

  # PATCH/PUT /changes/1
  # PATCH/PUT /changes/1.json
  def update
    respond_to do |format|
      if @change.update(change_params)
        format.html { redirect_to @change, notice: 'Change was successfully updated.' }
        format.json { head :no_content }
      else
          format.html { redirect_to @change, notice: "Change was not created, check list!."   }
          format.json { render action: 'show', status: :created, location: @change }

        # format.html { render action: 'edit' }
        # format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /changes/1
  # DELETE /changes/1.json
  def destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to changes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_change
      @change = Change.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def change_params
      params.require(:change).permit(:user_id, :list_id, :added_adresses, :removed_adresses, :listbane)
    end
  end
