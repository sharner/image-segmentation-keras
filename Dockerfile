FROM nvcr.io/nvidia/tensorflow:20.12-tf2-py3

ARG USER_ID
ARG GROUP_ID

# Add dependencies here
# Dependencies
RUN apt update && apt install -y \
    ibsm6 libxext6 \
    libeigen3-dev

# Simple root password in case we want to customize the container
RUN echo "root:root" | chpasswd
RUN addgroup --gid $GROUP_ID user
RUN useradd -G video,audio -ms /bin/bash --uid $USER_ID --gid $GROUP_ID user
RUN apt-get update && \
      apt-get -y install sudo

RUN echo "user:user" | chpasswd && adduser user sudo

COPY . workspace/

# Install
RUN cd workspace \
  && python setup.py install

USER user
 