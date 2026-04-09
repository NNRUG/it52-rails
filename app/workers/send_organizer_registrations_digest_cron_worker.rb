# frozen_string_literal: true

# Sidekiq-cron: ежедневная сводка организаторам о числе зарегистрировавшихся на их мероприятия.
class SendOrganizerRegistrationsDigestCronWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform
    OrganizerRegistrationsDigestSender.call
  end
end
