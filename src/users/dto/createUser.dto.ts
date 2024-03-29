import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString, Length } from "class-validator";

export class CreateUserDto{
    @ApiProperty({example: 'qwe', description: 'Логин'})
    @IsString({message: "Должно быть строкой"})
    @Length(4, 50, {message: "Не меньше 4 символов \n"})
    @IsNotEmpty({message: "Поле не должно быть пустым"})
    readonly login: string;

    @ApiProperty({example: '123', description: 'Пароль'})
    @IsString({message: "Должно быть строкой"})
    @Length(4, 50, {message: "Не меньше 4 симолов \n"})
    @IsNotEmpty({message: "Поле не должно быть пустым"})
    readonly password: string;
}
