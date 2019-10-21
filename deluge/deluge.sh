docker pull linuxserver/deluge
docker container stop deluge
docker container rm deluge
docker run -d \
	--name deluge \
	--net=container:vpn \
	-e PUID=1000 \
	-v ~/media/private:/downloads:rw \
	-v ~/media:/media:rw \
	-v ~/.config/deluge:/config:rw \
	-d linuxserver/deluge
	#-v ~/media/movies_ita:/media/movies_ita:rw \
	#-v ~/media/movies_eng:/media/movies_eng:rw \
	#-v ~/media/private:/media/serie_ita:rw \
	#-v ~/media/private:/media/serie_eng:rw \
