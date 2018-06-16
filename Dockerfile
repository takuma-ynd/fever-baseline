FROM ubuntu:latest

# set TERM
ENV TERM screen-256color

# add all locales (without this, locale in config file will not be configured properly)
RUN apt-get install -y locales-all

# install and set fish shell
RUN apt-get update && \
    apt-get install -y fish
RUN chsh -s /usr/bin/fish
RUN mkdir -p /root/.config/fish
COPY .config/ /root/.config

# install preffered software-packages
RUN apt-get update && \
    apt-get install -y less git wget cmake python python3 python-pip python3-pip

# syntax and style checker
RUN python -m pip install flake8

# install pipenv
RUN pip install pipenv && pip3 install pipenv

# configure emacs
RUN apt-get update && \
    apt-get install -y emacs
RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
COPY .spacemacs /root/.spacemacs

# configure tmux
RUN apt-get update && \
    apt-get install -y tmux

## clone from repo
RUN git clone --recursive https://github.com/takuma-ynd/tmux-config.git /root/.tmux
RUN bash /root/.tmux/installer-for-docker.sh

# welcome back to the home dir!
WORKDIR /root

# start fish shell
ENTRYPOINT /usr/bin/fish
