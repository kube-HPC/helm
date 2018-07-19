ARG BASE_PRIVATE_REGISTRY=""
FROM ${BASE_PRIVATE_REGISTRY}hkube/base-node:v1.0.0
LABEL maintainer="eli.maor@gmail.com"
RUN mkdir /hkube
COPY . /hkube/loadversion
RUN cd /hkube/loadversion 
WORKDIR /hkube/loadversion
CMD ["npm", "run", "start:server"]
