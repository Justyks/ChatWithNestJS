import { Message } from './entities/chat.entity';
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { Op } from 'sequelize';

@Injectable()
export class ChatService {
    constructor(@InjectModel(Message) private chatRepository: typeof Message){}

    async createMessage(payload: Message){
        return await this.chatRepository.create(payload);
    }

    async getMessagesWithUser(loginOfCompanion: string, user?: string){
        user = "he";
        return await this.chatRepository.findAll({where:{[Op.or]: [{login: loginOfCompanion}, {login: user}]}}); 
    }
}
