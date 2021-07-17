class ChatsController < ApplicationController
  before_action :set_chat, only: %i[show edit update destroy]

  def index
    @chats = Chat.all
  end

  def new
    @chat = current_user.chat.create
    @welcome_message = 'Hola, soy un chatbot y tratare de ayudarte con tus consultas, '\
                       'aunque soy muy joven ya tengo opciones programadas. <br>'\
                       'Puede escribir <strong>menu</strong> para ver las opciones.<br>'\
                       'Tambien puede enviar menu en cualquier momento para regrar '\
                       'a las opciones principales<br>'
  end

  def edit; end

  def update
    @message = @chat.message.new(chat_params)
    if @message.save
      ActionCable.server.broadcast 'room_channel', { content: chat_params['message'] }
      response = ChatRequest::State.show(current_user, chat_params['message'].squish)
      ActionCable.server.broadcast 'room_channel', { content: response }
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
