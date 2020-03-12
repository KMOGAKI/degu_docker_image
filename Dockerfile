FROM ubuntu:19.04

MAINTAINER AtmarkTechno, Inc.

RUN set -x && \
apt-get -y update && \ 
apt-get -y install openssh-server \
cmake \
ccache doxygen dfu-util device-tree-compiler \
python3-ply python3-pip python3-setuptools python3-wheel xz-utils file \
make gcc-arm-none-eabi autoconf automake libtool

ENV HOSTNAME degu-builder

RUN useradd -m -s /bin/bash devel && \
echo 'devel:devel' | chpasswd

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
EXPOSE 22

RUN wget https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/0.9.5/zephyr-sdk-0.9.5-setup.run
RUN sh zephyr-sdk-0.9.5-setup.run

#COPY api-server /opt/api-server
#CMD ["/opt/api-server/server_start"]

# docker run \
# --ip=192.168.56.100 \
# --name=spus \

RUN apt-get -y install git
RUN apt-get -y install ninja-build gperf
RUN pip3 install wheel==0.30.0 breathe==4.9.1 sphinx==1.7.5 docutils==0.14 sphinx_rtd_theme sphinxcontrib-svg2pdfconverter junit2html PyYAML>=3.12 ply==3.10 hub==2.0 gitlint pyelftools==0.24 pyocd==0.12.0 pyserial pykwalify colorama Pillow intelhex

RUN echo "export ZEPHYR_TOOLCHAIN_VARIANT=zephyr\nexport ZEPHYR_SDK_INSTALL_DIR=/opt/zephyr-sdk" > ~/.zephyrrc
