## Ansible Scripts and other stuff

#### After a new installation
    apt update
    apt --yes upgrade
    
    apt install --yes git gitk
    apt install --yes python3-venv python3-pip
    apt install --yes openssh-client openssh-server
    
    apt install --yes ansible
    
    mkdir -p ~/github
    git clone https://github.com/ceccopierangiolieugenio/scripts.git ~/github/scripts
    
    # Install VScode
    wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O /tmp/vscode.deb
    sudo dpkg -i /tmp/vscode.deb

#### fix for the audio 'chipmunk' effect with usb headphones
From: https://forums.linuxmint.com/viewtopic.php?t=328790

    ansible-playbook -c local -i localhost, audio.fix.yml

#### install and config terminator and fonts
    ansible-playbook -c local -i localhost, terminator.yml -vv

#### install and config vim
    ansible-playbook -c local -i localhost, vim.yml -vv

#### install and config tmux
    ansible-playbook -c local -i localhost, tmux.yml -vv

#### install aws terraform kubectl
    ansible-playbook -c local -i localhost, aws.yml -vv

#### install golang
I assume those env variables already set:

    GOPATH=${HOME}/github/go
    GOBIN=${GOPATH}/bin
    GOROOT=${HOME}/usr/go
    PATH=${GOROOT}/bin:${GOBIN}:${PATH}

run:

    mkdir ${HOME}/usr
    wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
    tar xvf go1.15.7.linux-amd64.tar.gz -C ${HOME}/usr
