(
    sudo apt install --yes --no-install-recommends curl
    sudo apt install --yes --no-install-recommends gnupg-agent
    sudo apt install --yes --no-install-recommends ca-certificates
    sudo apt install --yes --no-install-recommends apt-transport-https
    sudo apt install --yes --no-install-recommends software-properties-common

    url=https://download.docker.com/linux/ubuntu
    curl -fsSL $url/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] $url $( lsb_release -cs ) stable"
    sudo apt update --yes
    sudo apt install --yes --no-install-recommends \
    docker-ce docker-ce-cli containerd.io

    sudo service docker restart

    # curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    # curl -s -L https://nvidia.github.io/nvidia-docker/$(. /etc/os-release; echo $ID$VERSION_ID)/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    # sudo apt update -y
    # sudo apt upgrade -y
    # sudo apt install -y nvidia-container-toolkit

    # sudo service docker restart
)
