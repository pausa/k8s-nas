docker build . -t localhost:32000/smart:latest
docker push localhost:32000/smart:latest
docker run --device /dev/sda:/scanning/sda --cap-add SYS_RAWIO --rm -it localhost:32000/smart
