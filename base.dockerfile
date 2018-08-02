FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y software-properties-common wget

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
RUN apt-add-repository ppa:ansible/ansible

RUN apt-get update
RUN apt-get install -y build-essential \
    sudo \
    libboost-all-dev \
    cmake \
    ninja-build \
    git \
    clang-6.0 \
    curl \
    ansible

RUN apt-get clean autoclean
RUN apt-get autoremove -y

RUN ln -s /usr/bin/clang-6.0 /usr/bin/clang
RUN ln -s /usr/bin/clang-cpp-6.0 /usr/bin/clang-cpp
RUN ln -s /usr/bin/clang++-6.0 /usr/bin/clang++
RUN ln -s /usr/bin/llvm-6.0 /usr/bin/llvm

# Run Ansible set-up
COPY . /faasm/code
WORKDIR /faasm/code/ansible
RUN ansible-playbook libs.yml

CMD /bin/bash
