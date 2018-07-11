FROM alpine
MAINTAINER Eli Maor
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl nano zsh bash \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

# ADD run.sh /run.sh
# ENTRYPOINT [ "/run.sh" ]

