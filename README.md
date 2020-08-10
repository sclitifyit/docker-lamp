# docker-lamp

Docker example with Apache, MySql 8.0, PhpMyAdmin, Php and SSL Certificate

- You can use MariaDB 10.1 if you checkout to the tag `mariadb-10.1`
- You can use MySql 5.7 if you checkout to the tag `mysql5.7`

I use following command to build and start the docker containers:

```
docker-compose build && docker-compose up -d
```

Open phpmyadmin at [http://localhost:8000](http://localhost:8000)
Open web browser to look at a simple php example at [http://localhost](http://localhost) or with SSL at [https://localhost](https://localhost)

Run mysql client:

- `docker-compose exec db mysql -u root -p` 

Enjoy !
