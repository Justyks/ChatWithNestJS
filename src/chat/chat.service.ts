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

    async getMessagesWithUser(loginOfCompanion: string, user: string){
        return await this.chatRepository.findAll({where:{
            [Op.or]: [
                {[Op.and]: [{login: loginOfCompanion}, {recipient: user}]},
                {[Op.and]: [{login: user}, {recipient: loginOfCompanion}]}
    ]}});
    }
}
