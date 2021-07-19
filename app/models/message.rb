# frozen_string_literal: true

# modelo para los mensajes
class Message < ApplicationRecord
  belongs_to :chat

  def publish!(user, type, response = nil)
    ActionCable.server.broadcast "room_channel-#{user.id}", { content: response || message, type: type }
  end

  def publish_response!(user, response_text)
    update(response: response_text)
    publish!(user, 'response', response_text)
  end
end
