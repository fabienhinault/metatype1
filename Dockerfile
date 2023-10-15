# latest-full on 2023-08-26
FROM texlive/texlive@sha256:f3f3e87322a0fffd82821afd49fc4818a964b7b1246d4b6d8416eae99f3f2bec AS texlive

RUN apt-get update && \
apt-get install -y gawk && \ 
curl --output metatype1-ver056.zip  https://ctan.gutenberg-asso.fr/fonts/utilities/metatype1/metatype1-ver056.zip && \
unzip metatype1-ver056.zip

COPY ./Makefile /mt1

WORKDIR /mt1

# test the image on sample font
RUN cp ./sample/tapes.mp ./ && make FONT=tapes
