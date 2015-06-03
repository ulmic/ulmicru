# -*- coding: utf-8 -*-
module ApplicationWorker
  extend ActiveSupport::Concern
  include Timeout

  included do
    include Sidekiq::Worker
  end
end
