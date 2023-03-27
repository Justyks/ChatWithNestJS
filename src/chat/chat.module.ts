import { Message } from 'src/chat/entities/chat.entity';
import { UsersModule } from 'src/users/users.module';
import { ChatService } from './chat.service';
import { Module, forwardRef } from '@nestjs/common';
import { SequelizeModule } from '@nestjs/sequelize';
import { ChatController } from './chat.controller';
import { AuthModule } from 'src/auth/auth.module';

@Module({
    controllers: [ChatController],
    providers: [ChatService],
    imports: [SequelizeModule.forFeature([Message]),
                AuthModule,
                UsersModule],
    exports: [ChatService]
})
export class ChatModule {
  
}
