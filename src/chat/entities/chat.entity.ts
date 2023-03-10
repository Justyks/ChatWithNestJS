import { ApiProperty } from '@nestjs/swagger';
import {Column, DataType, Model, Table} from 'sequelize-typescript';

   interface MessageCreationAttrs{
    login: string;
    password: string;
}
@Table({tableName: 'messages'})
export class Message extends Model<Message, MessageCreationAttrs>{
    @ApiProperty({example: '1', description: 'Уникальный идентификатор'})
    @Column({type: DataType.INTEGER, unique: true, autoIncrement: true, primaryKey: true})
    id: number;

    @ApiProperty({example: 'qwe', description: 'Логин'})
    @Column({type: DataType.STRING, allowNull: false})
    login: string;

    @ApiProperty({example: 'hello', description: 'Текст сообщения'})
    @Column({type: DataType.STRING, allowNull: false})
    text: string;
}