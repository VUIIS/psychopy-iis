# Everything has to line up dependency-wise - psychopy is very picky
#   Debian bullseye to get libffi7
#   Python 3.10.16 for psychopy 2024.1.4
#   psychopy 2024.1.4 for psydat files created by 2024.1.4, 2024.1.5

FROM python:3.10.16-bullseye

RUN apt update -y && \
	apt install -y libgtk-3-dev && \
	pip install --upgrade pip && \
	pip install psychopy==2024.2.4

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7
