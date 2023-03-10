import { JwtService } from '@nestjs/jwt/dist';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ChatService } from './chat.service';
import { Controller, Get, Param, Render, Req, Res, UseGuards } from '@nestjs/common';

@Controller('chat')
export class ChatController {
    constructor(private chatService: ChatService,
                private jwtService: JwtService){}

    @UseGuards(JwtAuthGuard)
    @Get('/dialog/:login')
    async openChat(@Res() res, @Param('login') login: string, @Req() req){
        const decodedJwtToken: JwtPayload = this.jwtService.decode(req.headers.authorization.split(' ')[1]);
        console.log(typeof(decodedJwtToken));
        const messages = await this.chatService.getMessagesWithUser(login); 
        res.json(messages);
    }
}
