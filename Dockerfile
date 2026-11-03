# Everything has to line up dependency-wise - psychopy is very picky
#   Debian bullseye to get libffi7
#   Python 3.10.16 for psychopy 2024.2.4
#   psychopy 2024.2.4 for psydat files created by 2024.2.4
#
# And we need to preload libffi7

FROM python:3.10.16-bullseye

RUN set -eux; \
  # force stable mirrors instead of deb.debian.org CDN edge
  printf '%s\n' \
    'deb http://ftp.debian.org/debian bullseye main' \
    'deb http://ftp.debian.org/debian bullseye-updates main' \
    'deb http://security.debian.org/debian-security bullseye-security main' \
    > /etc/apt/sources.list; \
  rm -rf /var/lib/apt/lists/*; \
  apt-get -o Acquire::Retries=5 update; \
  apt-get install -y --no-install-recommends libgtk-3-dev; \
  rm -rf /var/lib/apt/lists/*; \
  pip install --upgrade pip; \
  pip install psychopy==2024.2.4
  
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7

COPY psychopy-tools /opt/psychopy-tools/

ENV PATH=/opt/psychopy-tools:${PATH}

