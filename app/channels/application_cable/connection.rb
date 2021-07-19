# frozen_string_literal: true

module ApplicationCable
  # coccion con el usuario
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      if request.session.fetch('current_user', nil).present?
        request.session.fetch('current_user', nil)
      else
        0
      end
    end
  end
end
