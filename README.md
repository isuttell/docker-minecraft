# docker-minecraft
A forge minecraft server using Docker

## Running
```
docker-compose up
```

## Stopping
```
docker-compose down
```

## Backups

The following command generates a dated tarball in the backups folder. It can be
run regularly using crontab
```shell
./backup.sh
```
