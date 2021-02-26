LOCAL_CONTAINER="ljcv-segment:latest"
CONTAINER="gcr.io/development-219501/ljcv-segment:latest"
CONTAINER=$LOCAL_CONTAINER
DATA=$LAYERJOT_HOME/Segmentation/data
SRC=$LAYERJOT_HOME/Segmentation/image-segmentation-keras

# Build the container
dc_build() {
  rm -rf build
  docker build -t $LOCAL_CONTAINER \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    -f Dockerfile .
}

# Tag the build
dc_tag_push() {
  docker tag $LOCAL_CONTAINER $CONTAINER
  docker push $CONTAINER
}

# Run a shell for development
dc_bash() {
  docker run \
    --gpus all \
    --mount type=bind,source=${SRC},target=/image-segmentation-keras \
    --mount type=bind,source=${DATA},target=/data \
    --rm --ipc=host -it ${CONTAINER}
}
