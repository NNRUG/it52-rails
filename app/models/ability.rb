class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Event, published: true
    can :manage, User, id: user.id

    if user.member?
      can :create, Event
      can :read, Event, organizer_id: user.id
      can :update, Event, organizer_id: user.id
      cannot :publish, Event

      can :create, EventParticipation
      can :destroy, EventParticipation, user_id: user.id
    end

    if user.admin?
      can :manage, Event
      can :publish, Event
      can :manage, EventParticipation
    end
  end
end
