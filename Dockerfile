# latest-full on 2023-08-10
FROM texlive/texlive@sha256:a0c7fb23353b7fc0d9faeec4e31d1ba954fa4744cdec237b06e86ec93a132c65 AS texlive

RUN apt update && \
apt install -y gawk && \
curl --output metatype1-ver056.zip  https://ctan.gutenberg-asso.fr/fonts/utilities/metatype1/metatype1-ver056.zip && \
unzip metatype1-ver056.zip

COPY ./Makefile /workdir/mt1
