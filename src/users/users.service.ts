import { ApiTags } from '@nestjs/swagger';
import { InjectModel } from '@nestjs/sequelize';
import { Injectable } from '@nestjs/common';
import { User } from './users.model';
import { CreateUserDto } from './dto/createUser.dto';

@Injectable()
export class UsersService {
    constructor(@InjectModel(User) private userRepository: typeof User){}

    async getAllUsers() {
        const users = await this.userRepository.findAll();
        return users;
    }

    async createUser(dto: CreateUserDto){
        const user = await this.userRepository.create(dto);
        return user;
    }

    async getUserByLogin(login: string){
        const user = await this.userRepository.findOne({where:{login}});
        return user;
    }
}
