import { ChatService } from './../chat/chat.service';
import {
  SubscribeMessage,
  WebSocketGateway,
  OnGatewayInit,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
 } from '@nestjs/websockets';
 import { Socket, Server } from 'socket.io';
 import { Message } from 'src/chat/entities/chat.entity';

@WebSocketGateway()
export class AppGateway
 implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
 constructor(private chatService: ChatService) {}
 
 @WebSocketServer() 
 server: Server;
 
 @SubscribeMessage('msgToServer')
 async handleMessage(client: Socket, payload: Message): Promise<void> {
   await this.chatService.createMessage(payload);
   this.server.emit('msgToClient', payload);
 }
 
 afterInit(server: Server) {
   //console.log(server);
   //Выполняем действия
 }
 
 handleDisconnect(client: Socket) {
   //console.log(`Disconnected: ${client.id}`);
   //Выполняем действия
 }
 
 handleConnection(client: Socket, ...args: any[]) {
   //console.log(`Connected ${client.id}`);
   //Выполняем действия
 }
}
