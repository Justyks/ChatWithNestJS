const socket = io('http://localhost:5000');
const msgBox = document.getElementById('exampleFormControlTextarea1');
const msgCont = document.getElementById('data-container');
const login = document.getElementById('email');
console.log(document.referrer);
//Получаем старые сообщения с сервера
const messages = [];
function getMessages() {
 fetch('http://localhost:5000/chat/dialog/:login')//Здесь надо будет сделать замену логина
   .then((response) => response.json())
   .then((data) => {
     loadDate(data);
     data.forEach((el) => {
       messages.push(el);
     });
   })
   .catch((err) => console.error(err));
}
getMessages();
 
//Когда пользователь нажимает клавишу enter key, отправляем сообщение.
msgBox.addEventListener('keydown', (e) => {
 if (e.keyCode === 13) {
   sendMessage({ login: login.value, text: e.target.value });
   e.target.value = '';
 }
});
 
//Отображаем сообщения пользователям
function loadDate(data) {
 let messages = '';
 data.map((message) => {
   messages += ` <li class="bg-primary p-2 rounded mb-2 text-light">
      <span class="fw-bolder">${message.login}</span>
      ${message.text}
    </li>`;
 });
 msgCont.innerHTML = messages;
}
 
//socket.io
//Создаём событие sendMessage, чтобы передать сообщение
function sendMessage(message) {
 socket.emit('msgToServer', message);
}
//Слушаем событие recMessage, чтобы получать сообщения, отправленные пользователями
socket.on('msgToClient', (message) => {
 messages.push(message);
 loadDate(messages);
})