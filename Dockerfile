FROM homeassistant/home-assistant:0.72.0

RUN apt-get update \
      && apt-get dist-upgrade -y \
      && apt-get install build-essential git-core -y

RUN cd /root \
      && git clone https://github.com/OpenZWave/open-zwave.git

COPY custom_Defs.h /root/open-zwave/cpp/src/Defs.h

RUN cd /root/open-zwave \
      && make \
      && make install

RUN apt-get purge build-essential git-core -y \
      && apt-get autoremove -y \
      && rm -rf /root/open-zwave

WORKDIR /usr/src/app
CMD [ "python", "-m", "homeassistant", "--config", "/config" ]
