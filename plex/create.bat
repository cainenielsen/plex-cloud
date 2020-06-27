docker create ^
--name=plex ^
--net=host ^
-e PUID=1000 ^
-e PGID=1000 ^
-e VERSION=docker ^
-v /config:/config ^
-v /library/tv:/tv ^
-v /library/movies:/movies ^
--restart unless-stopped ^
linuxserver/plex ^