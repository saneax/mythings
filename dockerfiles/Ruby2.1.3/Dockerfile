FROM ruby:2.2.3
MAINTAINER Sanjay Upadhyay "saneax@gmail.com"
RUN useradd -ms /bin/bash sanjayu
COPY resources/* /home/sanjayu/
RUN mkdir /home/sanjayu/workspace
RUN chown -R sanjayu:sanjayu /home/sanjayu
RUN cd /home/sanjayu && git clone https://github.com/saneax/vimrc .vim \
  && cd .vim && git submodule init && git submodule update && \
  cd /home/sanjayu && ln -s .vim/.vimrc .vimrc
RUN apt-get update && apt-get install -y vim

USER sanjayu
ENV HOME /home/sanjayu


WORKDIR /home/sanjayu/workspace
RUN git clone https://github.com/neo/ruby_koans
RUN cd ruby_koans && rake gen
