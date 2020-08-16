# docker-lamp

Docker example with Apache, MySql 8.0, PhpMyAdmin and Php

- You can use MariaDB 10.1 if you checkout to the tag `mariadb-10.1` - contribution made by [luca-vercelli](https://github.com/luca-vercelli)
- You can use MySql 5.7 if you checkout to the tag `mysql5.7`

I use docker-compose as an orchestrator. To run these containers:

```
docker-compose build && docker-compose up -d
```

Open phpmyadmin at [http://localhost:8000](http://localhost:8000)
Open web browser to look at server stats dasboard at [http://localhost:19999](http://localhost:19999)
Open web browser to look at a simple php example at [https://localhost](https://localhost)

Run mysql client:

- `docker-compose exec db mysql -u root -p` 

Enjoy !
