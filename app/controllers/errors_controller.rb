# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout false

  def error_404; end

  def image
    redirect_to build_attachment_path, status: :permanent_redirect
  end

  private

  def build_attachment_path
    production_prefix = 'https://it52.website.yandexcloud.net'
    [production_prefix, request.path.gsub('uploads/development', 'uploads/production')].join
  end
end
