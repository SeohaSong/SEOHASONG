docker run\
    --rm --interactive --tty\
    --gpus all\
    --volume $PWD:/root\
    --workdir /root\
 tensorflow/tensorflow:latest-gpu
