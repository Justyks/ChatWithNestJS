import { JwtService } from '@nestjs/jwt/dist';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ChatService } from './chat.service';
import { Controller, Get, Param, Render, Req, Res, UseGuards } from '@nestjs/common';
import { Request } from 'express';

@Controller('chat')
export class ChatController {
    constructor(private chatService: ChatService,
                private jwtService: JwtService){}

    @UseGuards(JwtAuthGuard)
    @Get('/dialog/:login')
    async openChat(@Res() res, @Param('login') login: string, @Req() req: Request){
        const userLogin = req.cookies['login'];
        const messages = await this.chatService.getMessagesWithUser(login, userLogin); 
        res.json(messages);
    }
}
