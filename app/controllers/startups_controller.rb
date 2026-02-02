# frozen_string_literal: true

class StartupsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_startup, only: %i[show edit update destroy]

  load_and_authorize_resource except: %i[index show new create]

  # GET /startups
  # GET /startups.json
  def index
    set_index_meta_tags!
    @startups = Startup.order(:title)
  end

  # GET /startups/1
  # GET /startups/1.json
  def show
    set_meta_tags @startup
  end

  # GET /startups/new
  def new
    @startup = Startup.new
  end

  # GET /startups/1/edit
  def edit; end

  # POST /startups
  # POST /startups.json
  def create
    @startup = Startup.new(startup_params)
    @startup.author_id = current_user.id

    respond_to do |format|
      if @startup.save
        format.html { redirect_to @startup, notice: 'Startup was successfully created.' }
        format.json { render :show, status: :created, location: @startup }
      else
        format.html { render :new }
        format.json { render json: @startup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /startups/1
  # PATCH/PUT /startups/1.json
  def update
    respond_to do |format|
      if @startup.update(startup_params)
        format.html { redirect_to @startup, notice: 'Startup was successfully updated.' }
        format.json { render :show, status: :ok, location: @startup }
      else
        format.html { render :edit }
        format.json { render json: @startup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /startups/1
  # DELETE /startups/1.json
  def destroy
    @startup.destroy
    respond_to do |format|
      format.html { redirect_to startups_url, notice: 'Startup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_index_meta_tags!
    image_path = helpers.image_url('it52_logo_fb@2x.png')
    set_meta_tags(
      title: I18n.t('meta.startups.index.title'),
      description: I18n.t('meta.startups.index.description'),
      canonical: startups_url,
      publisher: ENV.fetch('mailing_host') { 'mailing_host' },
      image_src: image_path,
      og: {
        title: I18n.t('meta.startups.index.title'),
        url: startups_url,
        description: I18n.t('meta.startups.index.description'),
        image: image_path,
        updated_time: Startup.order(updated_at: :asc).last
      }
    )
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_startup
    @startup = Startup.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def startup_params
    params.require(:startup).permit(:title, :url, :logo, :intro, :description, contacts: %i[name email])
  end
end
