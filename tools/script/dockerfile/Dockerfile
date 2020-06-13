FROM ubuntu


ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8


# snap install classic --edge --devmode
# sudo classic
# sudo apt update
# sudo apt install git


RUN yes | apt-get update
RUN yes | apt-get upgrade

RUN yes | apt-get install vim
RUN yes | apt-get install curl
RUN yes | apt-get install net-tools
RUN yes | apt-get install bzip2
RUN yes | apt-get install unzip
RUN yes | apt-get install xz-utils
RUN yes | apt-get install sudo

RUN yes | apt-get install gcc
RUN yes | apt-get install g++
RUN yes | apt-get install default-jre
ENV JAVA_HOME=/usr/lib/jvm/default-java


RUN yes | adduser seohasong
RUN echo "seohasong ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/seohasong
USER seohasong
WORKDIR /home/seohasong


RUN curl -o Anaconda.sh \
    https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
RUN (echo ""; echo "yes"; echo ""; echo "yes"; echo "no") | bash Anaconda.sh
RUN rm -rf Anaconda.sh .bashrc-anaconda3.bak
ENV PATH=/home/seohasong/anaconda3/bin:$PATH

RUN pip install --upgrade pip
RUN conda update -n base conda

RUN jupyter-notebook --generate-config
RUN config=~/.jupyter/jupyter_notebook_config.py;\
    line=$(grep -n NotebookApp.ip $config | cut -d ":" -f 1);\
    sed -i $line"s/.*/c.NotebookApp.ip = '0.0.0.0'/" $config;\
    line=$(grep -n NotebookApp.token $config | cut -d ":" -f 1);\
    sed -i $line"s/.*/c.NotebookApp.token = ''/" $config

RUN pip install tensorflow
RUN pip install boto3
RUN pip install django
RUN pip install gensim
RUN pip install opencv-python
RUN pip install konlpy
RUN pip install jpype1

# RUN pip install pymysql


# RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo bash
# RUN yes | sudo apt-get install nodejs
# RUN npm config set user root

# RUN sudo npm install -g ionic
# RUN sudo npm install -g @angular/cli


ENTRYPOINT [ "bash", "/home/seohasong/SEOHASONG/profile.sh" ]
