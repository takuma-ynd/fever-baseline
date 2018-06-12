FROM ubuntu:latest

# set TERM
ENV TERM screen-256color

# install and set fish shell
RUN apt-get update && \
    apt-get install -y fish
RUN chsh -s /usr/bin/fish
RUN mkdir -p /root/.config/fish
COPY .config/ /root/.config

# install and set tmux
RUN apt-get update && \
    apt-get install -y tmux

# install preffered software-packages
RUN apt-get update && \
    apt-get install -y less git python python3 python-pip python3-pip

# syntax and style checker
RUN python -m pip install flake8

# install pipenv
RUN pip install pipenv && pip3 install pipenv

# configure emacs
RUN apt-get update && \
    apt-get install -y emacs
RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
COPY .spacemacs /root/.spacemacs
