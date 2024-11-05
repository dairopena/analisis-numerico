# Usa la imagen base de Gitpod con soporte para Python y Jupyter
FROM gitpod/workspace-full:latest

# Instala Miniconda en el directorio del usuario
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /home/gitpod/miniconda && \
    rm /tmp/miniconda.sh && \
    /home/gitpod/miniconda/bin/conda init bash && \
    /home/gitpod/miniconda/bin/conda config --set auto_activate_base false

# Añade Miniconda al PATH
ENV PATH="/home/gitpod/miniconda/bin:$PATH"

# Instala Cling para C++
RUN sudo apt-get update && \
    sudo apt-get install -y cling

# Instala el kernel de Jupyter para C++ utilizando Cling
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install jupyter && \
    jupyter-kernelspec install cling --user
