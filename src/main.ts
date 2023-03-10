import { NestFactory } from '@nestjs/core';
import { DocumentBuilder } from '@nestjs/swagger';
import { SwaggerModule } from '@nestjs/swagger/dist';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import { join } from 'path';
import * as cookieParser from 'cookie-parser';

async function start() {
    const PORT = process.env.PORT || 5000;
    const app = await NestFactory.create<NestExpressApplication>(AppModule);

    const config = new DocumentBuilder()
        .setTitle('Чат')
        .setDescription('Документация REST API')
        .setVersion('1.0.0')
        .build();
    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('/api/docs', app, document);
    app.use(cookieParser());
    app.useStaticAssets(join(__dirname, '..', 'src', 'static'));     
    app.setBaseViewsDir(join(__dirname, '..', 'src', 'views'));
    app.setViewEngine('ejs');

    await app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
}

start();