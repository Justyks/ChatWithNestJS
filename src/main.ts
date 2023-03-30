import { NestFactory } from '@nestjs/core';
import { DocumentBuilder } from '@nestjs/swagger';
import { SwaggerModule } from '@nestjs/swagger/dist';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import { join } from 'path';
import * as cookieParser from 'cookie-parser';
import fs from 'fs';
import https from 'https';


async function start() {
    const PORT = process.env.PORT || 5000;
    // const httpsOptions = {
    //     key: fs.readFileSync('./secrets/private-key.pem'),
    //     cert: fs.readFileSync('./secrets/public-certificate.pem'),
    //   };
    const app = await NestFactory.create<NestExpressApplication>(AppModule);
    app.enableCors();

    const config = new DocumentBuilder()
        .setTitle('Чат')
        .setDescription('Документация')
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