import { HttpStatus } from '@nestjs/common/enums';
import { JwtService } from '@nestjs/jwt/dist';
import { Injectable, UnauthorizedException, HttpException } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { CreateUserDto } from 'src/users/dto/createUser.dto';
import { User } from 'src/users/users.model';
import * as bcrypt from 'bcryptjs'

@Injectable()
export class AuthService {
    constructor(private jwtService: JwtService,
                private userService: UsersService) {
        
    }

    async signIn(dto: CreateUserDto){
        const user = await this.validateUser(dto);
        return this.generateToken(user);
    }

    async signUp(dto: CreateUserDto){
        const candidate = await this.userService.getUserByLogin(dto.login);
        if(!candidate){
            const hashPassword = await bcrypt.hash(dto.password, 5);
            const user = await this.userService.createUser({...dto, password: hashPassword})
            return this.generateToken(user);
        }
        throw new HttpException("Пользователь с таким логином уже существует", HttpStatus.BAD_REQUEST);
    }

    private async validateUser(dto: CreateUserDto){
        const user = await this.userService.getUserByLogin(dto.login);
        const passwordMatch = await bcrypt.compare(dto.password, user.password);
        if(user && passwordMatch){
            return user;
        }
        throw new UnauthorizedException({message: "Данные неверны"});
    }

    private async generateToken(user: User){
        const payload = {login: user.login, id: user.id}
        return{
            token: this.jwtService.sign(payload)
        }
    }
}
