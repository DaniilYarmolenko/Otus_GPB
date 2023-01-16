# Server side for DDSpace project
## _API для iOS приложения DDSpace, сделанное с помощью VAPOR_
[Админ панель](ddspace.ru) - для просмотра работы api необходим API статус. Зарегистрируйтесь через мобильный клиент и напишите мне в [telegram](t.me/YDmsu)

### Инструкция по запуску своего API на базе DDSpace (для MacOS)
1. Скачайте папку DDArt
2. Откройте файл Package.swift через Xcode или любой другой редактор на MacOS
3. Установите Vapor
```sh
brew install vapor
```
4. Установите [Docker](https://docs.docker.com/desktop/install/mac-install/)
5. Откройте DDart_server/Sources/App/configure.swift и измените параметры для DB (в данном случае используеется PostgreSQL)
```sh
app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: databasePort,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? databaseName
    ), as: .psql)
```
6. Создайте и запустите BD в Docker
```sh
docker run --name postgres -e POSTGRES_DB=vapor_database \
  -e POSTGRES_USER=vapor_username \
  -e POSTGRES_PASSWORD=vapor_password \
  -p 5432:5432 -d postgres
  ```

  Ваш сервер будет запущен локально (стандартно - http://127.0.0.1:8080)
  Подробная информация по установке и работе с vapor - [Документация](https://docs.vapor.codes)
  ### Особую благодарность выражаю:
 - Команде [Kodeco](https://www.kodeco.com) (Команде Ray Wenderlich) - за единственный в своем роде учебник по VAPOR
 - За помощь в решении особо сложных вопросов - [Сообществу vapor](http://vapor.team)
