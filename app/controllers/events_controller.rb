require 'icalendar'

class EventsController < ApplicationController
  respond_to :html
  # responders :flash

  helper_method :past_events_page?

  before_action :set_event, only: [:show, :edit, :destroy, :update, :publish, :cancel_publication, :participants]
  before_action :check_actual_slug, only: :show
  before_action :define_meta_tags, only: [:show, :edit]
  before_action :set_organizer, only: :create

  load_and_authorize_resource param_method: :event_params

  has_scope :ordered_desc, type: :boolean, allow_blank: true, default: true

  def index
    model = Event.includes(:event_participations, :participants, :organizer)
    @events = model.visible_by_user(current_user)
    @events = if past_events_page?
                @events.past.page(params[:page]).decorate
              else
                @events.future.decorate
              end
    @rss_events = model.published.future.order(published_at: :asc).decorate
    @all_events = model.published.order(started_at: :asc)
    respond_to do |format|
      format.html
      format.json { render json: @all_events.to_json }
      format.atom
      format.ics { render body: Calendar.new(@all_events).to_ical }
    end
  end

  def show
    @event = @event.decorate
    flash[:warning] = t('.waiting_for_approval') unless @event.published?
    respond_to do |format|
      format.html { respond_with @event }
      format.ics { render body: Calendar.new(@event).to_ical, mime_type: Mime::Type.lookup("text/calendar") }
    end
    #respond_with @event
  end

  def participants
    participants = @event.participants
    filename = "#{ @event.id }_#{ @event.slug }_participants"
    columns_to_export = %w(email profile_link full_name employment)

    respond_to do |format|
      format.csv {
        send_data RenderARCollectionToCsv.perform(participants, columns_to_export),
                  type: Mime::Type.lookup('text/csv'),
                  disposition: "attachment; filename=#{filename}.csv"
      }
    end
  end

  def new
    respond_with @event
  end

  def create
    @event.save
    respond_with @event
  end

  def edit
    respond_with @event
  end

  def destroy
    @event.destroy
    redirect_to :index
  end

  def update
    @event.update_attributes event_params
    respond_with @event
  end

  def publish
    @event.publish!
    flash[:success] = t('.success_message')
    redirect_to action: :show
  end

  def cancel_publication
    @event.cancel_publication!
    flash[:success] = t('.success_message')
    redirect_to action: :show
  end

  private

  def define_common_meta_tags
    image_path = ActionController::Base.helpers.asset_url('it52_logo_fb@2x.png', type: :image)
    set_meta_tags({
      site: t(:app_name),
      description: t(:app_description),
      keywords: t(:app_keywords),
      canonical: root_path,
      reverse: true,
      image_src: image_path,
      charset: 'utf-8',

      og: {
        site_name: :site,
        locale: 'ru_RU',
        image: image_path,
        description: t(:app_description),
        url: root_path
      }
    })
  end

  def define_meta_tags
    set_meta_tags @event

    @structured_data = {
      "@context": "http://schema.org",
      "@type": "Event",
      name: @event.title,
      startDate: @event.started_at.iso8601,
      url: event_url(@event),
      image:  @event.title_image.square_500.url,
      description: @event.decorate.simple_description,
      # canonical: event_url(@event),
      # publisher: Figaro.env.mailing_host,
      performer: {
        "@type": "PerformingGroup",
        legalName: Figaro.env.mailing_host,
        name: Figaro.env.mailing_host,
        url: "https://#{Figaro.env.mailing_host}"
      },
      location: {
        "@type": "Place",
        name: @event.place,
        address: @event.place
      },
      organizer: {
        "@type": "Person",
        url: user_url(@event.organizer),
        name: @event.organizer.to_s
      }
    }
  end

  def check_actual_slug
    slug_correct = request.path == event_path(@event, format: request.format.symbol.to_s)
    slug_correct = request.path == event_path(@event) if request.format.symbol == :html
    redirect_to @event, status: :moved_permanently unless slug_correct
  end

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def set_organizer
    @event = Event.new(event_params)
    @event.organizer = current_user || nil
  end

  def event_params
    permitted_attrs = %i[
      title description started_at title_image place
      title_image title_image_cache location foreign_link
    ]
    params[:event].delete(:location) if params[:event][:location].blank?
    params.require(:event).permit(*permitted_attrs)
  end

  def past_events_page?
    @past ||= request.path.include?('past')
  end
end
