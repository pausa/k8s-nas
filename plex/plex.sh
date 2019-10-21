docker pull linuxserver/plex
docker container stop plex
docker container rm plex
docker run -d \
	--net=host \
	--name=plex \
	-v ~/media:/media:rw \
	-v ~/.config/plex:/config:rw \
	-e PUID=1000 \
	-e PGID=100 \
	linuxserver/plex
