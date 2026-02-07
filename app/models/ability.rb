# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Event, published: true
    can :manage, User, id: user.id
    can :read, Startup

    if user.member?
      can :read, Startup
      can :create, Startup
      can :manage, Startup, author_id: user.id

      can :create, Event
      can :read, Event, organizer_id: user.id
      can :update, Event, organizer_id: user.id
      can :download_participants, Event, organizer_id: user.id
      # destroy только у admin (см. events_controller#destroy)
      cannot :destroy, Event
      cannot :publish, Event

      can :create, EventParticipation
      can :destroy, EventParticipation, user_id: user.id
    end

    if user.admin?
      can :manage, Startup
      can :manage, Event
      can :publish, Event
      can :manage, EventParticipation
    end
  end
end
