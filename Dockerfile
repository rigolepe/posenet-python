FROM tensorflow/tensorflow:nightly-py3-jupyter
# This is the CPU version!
# see: https://www.tensorflow.org/install/docker
# see: https://hub.docker.com/r/tensorflow/tensorflow/

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      git \
      wget && \
    pip install --upgrade pip && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /work/

WORKDIR /work

RUN pip install -r requirements.txt

RUN git clone https://github.com/patlevin/tfjs-to-tf.git && \
    cd tfjs-to-tf && \
    pip install . && \
    cd .. && \
    rm -r tfjs-to-tf

ENV PYTHONPATH='/work/:$PYTHONPATH'

CMD ["bash"]
