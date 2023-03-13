const socket = io('http://localhost:5000');
const videoGrid = document.getElementById('video-grid');
const myPeer = new Peer(undefined, {
    host: '/',
    port: '5001'
})
const peers = {};
const myVideo = document.createElement('video');
myVideo.muted = true;


navigator.mediaDevices.getUserMedia({
    video: true,
    audio: false // Тут потом звук размуть, а то у меня чуть уши не вытекли))
}).then(stream => {
    addVideoStream(myVideo, stream);

    myPeer.on('call', call => { //В такой функции делаешь кнопки принятия и отклоенения вызова
        call.answer(stream);
        const video = document.createElement('video');

        call.on('stream', userVideoStream => {
            addVideoStream(video, userVideoStream);
        })
    })

    socket.on('userConnected', userId => {
        connectToNewUser(userId, stream);
    })
});

socket.on('userDisconnected', userId => {
    //if(peers[userId]){
        console.log(peers);
        console.log(userId);
        console.log(peers[userId]);
        peers[userId].close()
    //}
});

myPeer.on('open', id => {
    socket.emit('joinRoom', ROOM_ID , id);
});

function addVideoStream(video, stream){ //Добавление видео
    video.srcObject = stream;
    video.addEventListener('loadedmetadata', () => {
        video.play();
    });
    videoGrid.append(video);
}

function connectToNewUser(userId, stream){
    const call = myPeer.call(userId, stream);// Это функция вызова, тут они автоматически коннектятся по переходу по ссылке
    const video = document.createElement('video');

    call.on('stream', userVideoStream => {
        addVideoStream(video, userVideoStream);
    })

    call.on('close', () => {
        console.log('disconnect');
        video.remove();
    });

    peers[userId] = call;
    console.log(peers);
}