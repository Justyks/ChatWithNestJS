import {
    SubscribeMessage,
    WebSocketGateway,
    OnGatewayInit,
    WebSocketServer,
    OnGatewayConnection,
    OnGatewayDisconnect,
} from "@nestjs/websockets";
import { MiddlewareConsumer } from "@nestjs/common";
import { Socket, Server } from "socket.io";
import { Message } from "src/chat/entities/chat.entity";
import { ChatService } from "./../chat/chat.service";
import * as cors from "cors";

@WebSocketGateway({
    cors: { origin: "http://localhost:3000", credentials: true },
})
export class AppGateway
    implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
    constructor(private chatService: ChatService) { }

    @WebSocketServer()
    server: Server;

    @SubscribeMessage('msgToServer')
    async handleMessage(client: Socket, payload: Message): Promise<void> {
        await this.chatService.createMessage(payload); // сохраняем новое сообщение
        client.broadcast.emit('msgToClient', payload); // отправляем сообщение всем подключенным клиентам
    }

    @SubscribeMessage("joinRoom")
    joinRoom(client: Socket, payload) {
        client.join(payload[0]);
        client.to(payload[0]).emit("userConnected", payload[1]);

        client.on("disconnect", () => {
            client.to(payload[0]).emit("userDisconnected", payload[1]);
        });
    }

    afterInit(server: Server) {
        //console.log(server);
        //Выполняем действия
    }

    handleDisconnect(client: Socket) {
        //console.log(`Disconnected: ${client.id}`);
        //Выполняем действия
    }

    async handleConnection(socket: Socket) {
        const { origin } = socket.handshake.headers;
        if (origin !== "http://localhost:3000") {
            return socket.disconnect();
        }
        // continue handling the connection
    }

    configure(consumer: MiddlewareConsumer) {
        consumer
            .apply(cors({ origin: "http://localhost:3000", credentials: true }))
            .forRoutes("*");
    }
}
