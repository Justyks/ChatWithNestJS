import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { CreateUserDto } from './dto/createUser.dto';
import { UsersService } from './users.service';

@ApiTags('Это работа с пользователями ее на фронт никак кидать не надо')
@Controller('users')
export class UsersController {
    constructor(private usersService: UsersService){}

    @UseGuards(JwtAuthGuard)
    @Get()
    getAllUsers(){
        return this.usersService.getAllUsers();
    }

    @Post()
    createUser(@Body() dto: CreateUserDto){
        return this.usersService.createUser(dto);
    }
}
