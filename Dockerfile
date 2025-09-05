FROM python:3.10

RUN apt update -y && \
	apt install -y libgtk-3-dev && \
	pip install --upgrade pip && \
	pip install psychopy==2024.1.4

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7


