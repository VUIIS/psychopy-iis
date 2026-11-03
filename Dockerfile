# Everything has to line up dependency-wise - psychopy is very picky
#   Debian bullseye to get libffi7
#   Python 3.10.16 for psychopy 2024.2.4
#   psychopy 2024.2.4 for psydat files created by 2024.2.4
#
# And we need to preload libffi7

# Original working build was from
#FROM python:3.10.16-bullseye@sha256:4a06424c5af4323658efc417968a67df7890db405fa46474d12963c1c796ff22

# Build from existing working image instead
FROM baxterprogers/psychopy-iis@sha256:02c342ce4152ed6c009aa415dc277de746539aba827e3d28e20c6248684dc494

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7

COPY psychopy-tools /opt/psychopy-tools/

ENV PATH=/opt/psychopy-tools:${PATH}
