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
    @welcome_message = I18n.t(:hello)
  end

  def edit; end

  def update
    @message = @chat.messages.new(chat_params)

    if @message.save
      @message.publish!(current_user, 'send')
      response = ChatRequest::State.show(current_user, chat_params['message'].squish)
      @message.publish_response!(current_user, response)
    end

    head 200, content_type: 'application/json'
  end

  private

  def set_chat
    @chat = current_user.chat.last
  end

  def chat_params
    params.require(:chat).permit(:message)
  end
end
