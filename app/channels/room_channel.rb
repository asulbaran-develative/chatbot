# frozen_string_literal: true

# suscribirse a los canales del chat
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel-#{current_user}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
