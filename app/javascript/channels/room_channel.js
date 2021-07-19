import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    document.getElementById("send_button").disabled = false;
    console.log('Conectado');
  },

  disconnected() {
    document.getElementById("send_button").disabled = true;
    console.log('Desconectado');
  },

  received(data) {
    var div_type = { "response": { "position": "justify-content-start", "type": "msg_cotainer"},
                     "send": { "position": "justify-content-end", "type": "msg_cotainer_send" }}
    var body = `<div class="d-flex ${div_type[data.type].position} mb-4">
                 <div class="${div_type[data.type].type}">
                   ${data.content}
                 </div>
               </div>`

    send_data(body);               
  }
});

function send_data(body){
  document.getElementById("new_message").innerHTML += body;
  document.getElementById('chat_message').value= ''
  var myDiv = document.getElementById("main_body");
  myDiv.scrollTop = myDiv.scrollHeight;
  stopCount() ;
  startCount() ;
}
var timer_automatic;

function startCount() {
  timer_automatic = setTimeout(function(){ remember_data() }, 20000);
}

function stopCount() {
  clearTimeout(timer_automatic);
}

function remember_data(){
  var body = `<div class="d-flex justify-content-start mb-4">
                <div class="msg_cotainer">
                    <strong>Puedo ayudarte en algo?.</stong><br>
                    Recuerda que puedes escribi <strong>menu</strong> para conocer las opcines.<br>
                </div>
              </div>`
  send_data(body);
}