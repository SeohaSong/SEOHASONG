sudo apt update --yes
sudo apt upgrade --yes

sudo apt install --yes --no-install-recommends gcc


sudo apt-key adv\
    --fetch-keys\
 http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub

sudo sh -c ''\
'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /"'\
' > /etc/apt/sources.list.d/cuda.list'

sudo apt update --yes

sudo apt install --yes --no-install-recommends cuda-toolkit-11-0

cp -r /usr/local/cuda/samples .