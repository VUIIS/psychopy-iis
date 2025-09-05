FROM python:3.10

RUN pip install psychopy==2024.1.4

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7

ENTRYPOINT ["bash"]

