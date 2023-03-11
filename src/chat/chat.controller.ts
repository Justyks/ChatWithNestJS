import { Message } from 'src/chat/entities/chat.entity';
import { JwtService } from '@nestjs/jwt/dist';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ChatService } from './chat.service';
import { Controller, Get, Param, Query, Render, Req, Res, UseGuards } from '@nestjs/common';
import { query, Request } from 'express';
import { ApiOperation, ApiParam, ApiQuery, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('Чат')
@Controller('chat')
export class ChatController {
    constructor(private chatService: ChatService,
                private jwtService: JwtService){}

    @ApiOperation({summary: 'Открытие чата с каким-то юзером, здесь надо параметром передать логин юзера'})
    @ApiQuery({example: "?login=vlad", description: "GET параметр отправителя, если его нет возвращается информационное сообщение"})
    @ApiResponse({status: 200, type: Message, description: "Возвращается JSON с сообщениями"})
    @UseGuards(JwtAuthGuard)
    @Get('/dialog/')
    async openChat(@Res() res, @Req() req: Request){
        if(req.query.login){
            const userLogin = req.cookies['login'];
            const messages = await this.chatService.getMessagesWithUser(req.query.login.toString(), userLogin); 
            res.json(messages);
            return;
        }
        res.send("Chat opened select user to chat with");
    }
}
