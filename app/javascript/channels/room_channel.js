import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Conectado');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('Desconectado');
  },

  received(data) {

    document.getElementById("new_message").innerHTML += data.content + ' <br><br>';
    document.getElementById('chat_message').value= ''
    var myDiv = document.getElementById("main_body");
    myDiv.scrollTop = myDiv.scrollHeight;
  }
});
