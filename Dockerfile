FROM node:12.16-slim

RUN apt update && apt install -yqq \
    sudo \
    git \
    rsync \
    ssh \
    chromium \
    chromium-l10n \
    fonts-liberation \
    fonts-roboto \
    hicolor-icon-theme \
    libcanberra-gtk-module \
    libexif-dev \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpango1.0-0 \
    libv4l-0 \
    fonts-symbola \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/chromium.d/ \
    && /bin/echo -e 'export GOOGLE_API_KEY="AIzaSyCkfPOPZXDKNn8hhgu3JrA62wIgC93d44k"\nexport GOOGLE_DEFAULT_CLIENT_ID="811574891467.apps.googleusercontent.com"\nexport GOOGLE_DEFAULT_CLIENT_SECRET="kdloedMFGdGla2P1zacGjAQh"' > /etc/chromium.d/googleapikeys

RUN npm install -g @angular/cli

RUN groupadd -r chromium && useradd -r -g chromium -G audio,video chromium \
    && mkdir -p /home/chromium/Downloads && chown -R chromium:chromium /home/chromium

RUN useradd -r nyhasinavalona -G sudo,chromium \
    && mkdir -p /home/nyhasinavalona \
    && chown -R nyhasinavalona:nyhasinavalona /home/nyhasinavalona

USER nyhasinavalona

WORKDIR /home/nyhasinavalona

CMD /bin/bash