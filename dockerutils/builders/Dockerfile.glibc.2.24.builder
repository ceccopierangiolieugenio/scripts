FROM skysider/glibc_builder64:2.24

RUN apt update -y

RUN apt install -y \
    build-essential \
    libc6-dev-i386 \
    texinfo chrpath \
    diffstat git gawk wget cpio file \
    python 

RUN useradd -m -p 1234 build

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod 755 /usr/bin/repo

CMD ["bash"]

