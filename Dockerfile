FROM ubuntu

RUN apt-get update
RUN apt-get install -y vim\
                        wget\
                        build-essential\
                        software-properties-common

WORKDIR /twelf-tools

# Install sml/nj
RUN wget http://smlnj.cs.uchicago.edu/dist/working/110.99.2/config.tgz
RUN tar xvzf config.tgz
RUN config/install.sh
ENV PATH="$PATH:/twelf-tools/bin"

# Install twelf
RUN wget http://twelf.org/releases/twelf-src-1.7.1.tar.gz
RUN tar xvzf twelf-src-1.7.1.tar.gz
# Use .el without the old style backtick
WORKDIR /twelf-tools/twelf/emacs
RUN wget -O twelf.el https://raw.githubusercontent.com/standardml/twelf/c1bec0d0b9fa506e36bb364b1765191b159e6c4c/emacs/twelf.el
WORKDIR /twelf-tools/twelf
RUN make smlnj

# Install Emacs
RUN apt install emacs -y
COPY init.el /root/.emacs.d/

# Prepare sample wokspace
WORKDIR /workspace
COPY sources.cfg /workspace
COPY sometwelf.elf /workspace
