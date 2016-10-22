
[ ! -f /root/roughfox.cid ] &&
xhost + &&
docker run \
    --cidfile /root/roughfox.cid \
    --restart always \
    --detach \
    --env BIN_URL=git@github.com:endlesselectron/bin.git \
    --env BIN_TAG=2.3.2 \
    --env PROJECT_UPSTREAM=git@github.com:lonealarm/roughfox.git \
    --env PROJECT_ORIGIN=git@github.com:lonealarm/roughfox.git \
    --env GIT_EMAIL=emory.merryman@gmail.com \
    --env GIT_NAME="Emory Merryman" \
    --env UUID=$(uuidgen) \
    --volume dot_ssh:/root/.ssh \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --privileged \
    --env DISPLAY \
    --volume /tmp/.X11 \
    --publish 127.0.0.1:80:8080 \
    --env DOCKER_API_VERSION=1.22 \
    emorymerryman/cloud9:2.2.1 &
true

