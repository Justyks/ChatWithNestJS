import { UsersService } from './../users/users.service';
import { Message } from 'src/chat/entities/chat.entity';
import { JwtService } from '@nestjs/jwt/dist';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ChatService } from './chat.service';
import { Controller, Get, Param, Query, Render, Req, Res, UseGuards } from '@nestjs/common';
import { query, Request, Response } from 'express';
import { ApiOperation, ApiParam, ApiQuery, ApiResponse, ApiTags } from '@nestjs/swagger';
import uuid = require('uuid');
import io = require("socket.io")

@ApiTags('Чат')
@Controller('chat')
export class ChatController {
    constructor(private chatService: ChatService,
        private userService: UsersService,
        private jwtService: JwtService) { }

    @ApiOperation({ summary: 'Открытие списка диалогов' })
    @ApiResponse({ status: 200, type: Message, description: "Возвращется список юзеров" })
    @UseGuards(JwtAuthGuard)
    @Get('/dialogs/')
    async viewChats(@Res() res, @Req() req: Request) {
        const users = await this.userService.getAllUsers();
        return users;
    }

    @ApiOperation({ summary: 'Открытие чата с каким-то юзером, здесь надо параметром передать логин юзера' })
    @ApiQuery({ example: "?login=vlad", description: "GET параметр отправителя, если его нет возвращается информационное сообщение" })
    @ApiResponse({ status: 200, type: Message, description: "Возвращается JSON с сообщениями" })
    @UseGuards(JwtAuthGuard)
    @Get('/dialog/')
    async openChat(@Res() res, @Req() req: Request) {
        if (req.query.login) {
            const userLogin = req.cookies['login'];
            const messages = await this.chatService.getMessagesWithUser(req.query.login.toString(), userLogin);
            res.json(messages);
            return;
        }
        res.send("Chat opened select user to chat with");
    }

    @ApiOperation({ summary: 'Переход в звонок, тебе надо будет ссылаться сюда, это наверное не нужно' })
    //@UseGuards(JwtAuthGuard)
    @Get('/call/')
    async getRoom(@Res() res: Response, @Req() req: Request) {
        res.redirect(`call/${uuid.v4()}`)
    }

    @ApiOperation({ summary: 'Звонок' })
    //@UseGuards(JwtAuthGuard)
    @Get('/call/:login')
    async callUser(@Res() res: Response, @Req() req: Request) {
        res.render('room', { roomId: req.params.login, userLogin: req.cookies['login'] });
    }
}
