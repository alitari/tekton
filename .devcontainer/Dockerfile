FROM debian:10.1

LABEL maintainer="alitari67@gmail.com"

# Configure apt
ENV DEBIAN_FRONTEND=noninteractive

# install the tools i wish to use
RUN apt-get update && \
  apt-get install -y sudo \
  curl \
  git-core \
  locales \
  wget \
  bash-completion \
  vim \
  && locale-gen en_US.UTF-8

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

ENV USER_NAME alitari
ENV USER_PASSWORD password

# add a user (--disabled-password: the user won't be able to use the account until the password is set)
RUN adduser --quiet --disabled-password --shell /bin/zsh --home /home/$USER_NAME --gecos "User" $USER_NAME
# update the password
RUN echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd && usermod -aG sudo $USER_NAME
RUN echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME && chmod 0440 /etc/sudoers.d/$USER_NAME

ENV TERM xterm

# Set the default shell to bash rather than sh
ENV SHELL /bin/bash

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# cluster config
RUN mkdir /home/alitari/.kube
ADD config /home/alitari/.kube/
RUN chmod 777 -R /home/alitari/.kube


# helm
RUN curl -LO https://get.helm.sh/helm-v3.0.0-beta.3-linux-amd64.tar.gz \
    && tar xfv helm-v3.0.0-beta.3-linux-amd64.tar.gz \
    && chmod a+x linux-amd64/helm \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64/ \
    && rm helm-v3.0.0-beta.3-linux-amd64.tar.gz

# tekton client
RUN curl -LO https://github.com/tektoncd/cli/releases/download/v0.4.0/tkn_0.4.0_Linux_x86_64.tar.gz
RUN sudo tar xvzf tkn_0.4.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn
# install as kubectl plugin
RUN ln -s /usr/local/bin/tkn /usr/local/bin/kubectl-tkn

# set home
ENV HOME /home/$USER_NAME

# the user we're applying this too (otherwise it most likely install for root)
USER $USER_NAME

# bash configuration
ADD .bashrc /home/alitari