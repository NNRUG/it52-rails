# frozen_string_literal: true

require 'icalendar'

# rubocop:disable Metrics/ClassLength
class EventsController < ApplicationController
  respond_to :html

  helper_method :unapproved_count, :educational?, :current_filter?, :filter_params

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_model, only: %i[index]
  before_action :set_event, only: %i[show edit destroy update publish cancel_publication participants]
  before_action :check_actual_slug, only: :show
  before_action :define_meta_tags, only: %i[show edit]
  before_action :set_organizer, only: :create
  before_action :set_filter_kind, only: :index

  load_and_authorize_resource param_method: :event_params, except: %i[index participants]

  has_scope :ordered_desc, type: :boolean, allow_blank: true, default: true

  def index
    @events = if filter_params[:status] == 'unapproved'
                @model.unapproved.visible_by_user(current_user)
              else
                @model.published.filter_by(**filter_params)
              end

    @events = @events.page(params[:page]).decorate
    @rss_events = @model.published.order(published_at: :desc).limit(100).decorate
    respond_to do |format|
      format.html
      format.json { render json: @model.published.order(started_at: :asc).page(params[:page]).to_json }
      format.atom
      format.ics { render body: Calendar.new(@model.published.order(started_at: :desc).page(params[:page])).to_ical }
      format.rss
    end
  end

  def show
    @event = @event.decorate
    flash[:warning] = t('.waiting_for_approval') unless @event.published?
    respond_to do |format|
      format.html { respond_with @event }
      format.ics { render body: Calendar.new(@event).to_ical, mime_type: Mime::Type.lookup('text/calendar') }
    end
  end

  def participants
    authorize! :download_participants, @event
    participants = @event.participants
    filename = "#{@event.id}_#{@event.slug}_participants"
    columns_to_export = %w[email profile_link full_name employment]

    respond_to do |format|
      format.csv do
        send_data RenderArCollectionToCsv.perform(participants, columns_to_export),
                  type: Mime::Type.lookup('text/csv'),
                  disposition: "attachment; filename=#{filename}.csv"
      end
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
    if @event.published?
      redirect_back(fallback_location: root_path, alert: 'Вы не можете удалить опубликованное событие') && return
    end
    notice_text = if @event.destroy
                    'Событие удалено'
                  else
                    "Невозможно удалить событие. #{@event.errors.error_messages.to_sentence}"
    end

    redirect_back(fallback_location: root_path, notice: 'Событие удалено')
  end

  def update
    @event.update event_params
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
    set_meta_tags(
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
    )
  end

  def define_meta_tags
    set_meta_tags @event

    @structured_data = {
      '@context': 'http://schema.org',
      '@type': 'Event',
      name: @event.title,
      startDate: @event.started_at.iso8601,
      endDate: (@event.started_at + 6.hours).iso8601,
      url: event_url(@event),
      image: @event.title_image.square_500.url,
      description: @event.decorate.simple_description,
      performer: {
        '@type': 'PerformingGroup',
        image: @event.organizer.avatar_image.square_150.url,
        name: @event.organizer.to_s,
        sameAs: user_url(@event.organizer)
      },
      location: {
        '@type': 'Place',
        name: @event.place,
        address: @event.place
      },
      offers: {
        '@type': 'Offer',
        url: event_url(@event),
        availability: 'http://schema.org/InStock',
        price: 0,
        priceCurrency: 'RUB',
        validFrom: ((@event.published_at || Time.current) + 6.hours).iso8601
      },
      organizer: {
        '@type': 'Person',
        url: user_url(@event.organizer),
        name: @event.organizer.to_s
      }
    }
  end

  def check_actual_slug
    slug_correct = request.path == event_path(@event, format: request.format.symbol.to_s)
    if request.format.symbol == :html
      slug_correct = request.path == event_path(@event)
    end
    redirect_to @event, status: :moved_permanently unless slug_correct
  end

  def set_model
    @model = Event.includes(:event_participations, :participants, :organizer, :taggings)
  end

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def educational?
    action_name == 'index_education'
  end

  def set_filter_kind
    session[:events_kind_filter] = params[:kind] || session[:events_kind_filter] || 'all'
  end

  def filter_params
    params.permit(:kind, :status, :tag).to_h
          .merge(kind: session[:events_kind_filter])
          .symbolize_keys
  end

  def current_filter?(key)
    key.to_s == session[:events_kind_filter].to_s
  end

  def set_organizer
    @event = Event.new(event_params)
    @event.organizer = current_user || nil
  end

  def event_params
    permitted_attrs = %i[
      title description started_at title_image place kind
      title_image title_image_cache location foreign_link
      tag_list address_comment
    ]
    params[:event].delete(:location) if params[:event][:location].blank?
    params.require(:event).permit(*permitted_attrs)
  end

  def unapproved_count
    Event.unapproved.visible_by_user(current_user).count
  end
end
# rubocop:enable Metrics/ClassLength
