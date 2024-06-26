import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { SequelizeModule } from '@nestjs/sequelize';
import { User } from './users/users.model';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';
import { AppGateway } from './app/app.gateway';
import { ChatService } from './chat/chat.service';
import { Message } from './chat/entities/chat.entity';
import { ChatModule } from './chat/chat.module';
import * as cors from 'cors'

@Module({
    imports: [ConfigModule.forRoot
        ({ envFilePath: `.${process.env.NODE_ENV}.env` }),
    SequelizeModule.forRoot({
        dialect: 'postgres',
        host: process.env.POSTGRES_HOST,
        port: Number(process.env.POSTGRES_PORT),
        username: process.env.POSTGRES_USER,
        password: process.env.POSTGRES_PASSWORD,
        database: process.env.POSTGRES_DB,
        models: [User, Message],
        autoLoadModels: true
    }),
        UsersModule,
        AuthModule,
        ChatModule],
    controllers: [],
    providers: [AppGateway],
})
export class AppModule implements NestModule {
    configure(consumer: MiddlewareConsumer) {
        consumer.apply(cors({ origin: "http://localhost:3000", credentials: true }));
    }
}
