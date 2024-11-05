# Use una imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza los paquetes del sistema
RUN apt-get update && apt-get upgrade -y

# Instala los paquetes necesarios
RUN apt-get install -y \
    wget \
    build-essential \
    software-properties-common \
    git \
    cmake \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    curl \
    ca-certificates \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgtk2.0-dev \
    libatlas-base-dev \
    gfortran \
    libopenblas-dev \
    libopencv-dev \
    python3-dev \
    python3-pip

# Instala Miniconda
RUN curl -sL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && /opt/conda/bin/conda init

# Instala el kernel de C++ para Jupyter Notebook
RUN pip install --no-cache-dir clingkernel \
    && clingkernel install

# Establecer el punto de entrada
CMD [ "/opt/conda/bin/jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root" ]