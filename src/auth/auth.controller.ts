import { ValidationPipe } from 'src/pipes/validation-pipe';
import { Body, Controller, Post, UsePipes } from '@nestjs/common';
import { ApiHeader, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateUserDto } from 'src/users/dto/createUser.dto';
import { User } from 'src/users/users.model';
import { AuthService } from './auth.service';

@ApiTags('Авторизация')
@Controller('auth')
export class AuthController {
    constructor (private authService: AuthService){}

    @ApiOperation({summary: 'Регистрация'})
    @ApiResponse({status: 200, type: Object, description: "Возвращается JWT токен, тебе его надо сохранить куда-нибудь и дальше по сайту передавать его в хэдере 'Authorization', потому что дальше без него никуда не пустит"})
    //@ApiHeader({name: 'Authorization', description: "Тут токен должен быть"})
    @UsePipes(ValidationPipe)
    @Post('signup')
    signUp(@Body() dto: CreateUserDto){
        return this.authService.signUp(dto);
    }

    @ApiOperation({summary: 'Вход'})
    @ApiResponse({status: 200, type: Object, description: "Возвращается JWT токен, тебе его надо сохранить куда-нибудь и дальше по сайту передавать его в хэдере 'Authorization', потому что дальше без него никуда не пустит"})
    @UsePipes(ValidationPipe)
    @Post('signin')
    signIn(@Body() dto: CreateUserDto){
        return this.authService.signIn(dto);
    }
}
