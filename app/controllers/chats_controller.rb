# frozen_string_literal: true

# Controlador de chats
class ChatsController < ApplicationController
  before_action :set_chat, only: %i[show edit update destroy]

  def index
    @chats = Chat.all
  end

  def new
    redirect_to new_user_session_path and return if current_user.nil?

    session['current_user'] = current_user.id
    @chat = current_user.chat.create
    @welcome_message = 'Hola, soy un bot y tratare de ayudarte con tus consultas, '\
                       'aunque soy muy joven ya tengo opciones programadas. <br>'\
                       'Puede escribir <strong>menu</strong> para ver las opciones.<br>'\
                       'Tambien puede enviar menu en cualquier momento para regrar '\
                       'a las opciones principales<br>'
  end

  def edit; end

  def update
    @message = @chat.message.new(chat_params)
    if @message.save
      send_message(chat_params['message'], 'send')
      response = ChatRequest::State.show(current_user, chat_params['message'].squish)
      send_message(response, 'response')
    end
    head 200, content_type: 'application/json'
  end

  def send_message(message, type)
    ActionCable.server.broadcast "room_channel-#{current_user.id}", { content: message, type: type }
  end

  private

  def set_chat
    @chat = current_user.chat.last
  end

  def chat_params
    params.require(:chat).permit(:message)
  end
end
