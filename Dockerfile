FROM debian:stretch

ENV FAH_VERSION=7.5

ENV DEBIAN_FRONTEND=noninteractive

# viewer and control not needed
# https://download.foldingathome.org/releases/public/release/fahcontrol/debian-stable-64bit/v${FAH_VERSION}/latest.deb \
# https://download.foldingathome.org/releases/public/release/fahviewer/debian-stable-64bit/v${FAH_VERSION}/latest.deb
RUN apt-get update \
	&& apt-get install --no-install-recommends -y curl adduser bzip2 \
	&& curl -sLfk -o /tmp/fahclient.deb https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v${FAH_VERSION}/latest.deb \
	&& mkdir -p /etc/fahclient/ \
	&& touch /etc/fahclient/config.xml \
	&& dpkg --install /tmp/fah*.deb \
	&& apt-get remove -y curl \
	&& apt-get autoremove -y \
	&& rm --recursive --verbose --force /tmp/* /var/log/* /var/lib/apt/

EXPOSE 7396

ENTRYPOINT ["FAHClient", "--web-allow=0/0:7396", "--allow=0/0:7396"]
CMD ["--user=Anonymous", "--team=0", "--gpu=false", "--smp=true", "--power=full"]
