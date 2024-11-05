FROM gitpod/workspace-full

USER gitpod

# Instalar miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm Miniconda3-latest-Linux-x86_64.sh

# Agregar conda al PATH
ENV PATH="/home/gitpod/miniconda3/bin:${PATH}"

# Configurar conda y instalar jupyter con soporte para C++
RUN conda init bash \
    && conda create -n cling -c conda-forge xeus-cling notebook -y \
    && echo "conda activate cling" >> ~/.bashrc

# Instalar extensiones útiles de Jupyter
RUN conda run -n cling pip install jupyterlab-git \
    && conda run -n cling pip install jupyterlab-gitplus \
    && conda run -n cling pip install notebook

# Limpiar caché de conda
RUN conda clean --all -f -y

# Configurar Jupyter
RUN mkdir -p /home/gitpod/.jupyter \
    && echo "c.NotebookApp.token = ''" > /home/gitpod/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.password = ''" >> /home/gitpod/.jupyter/jupyter_notebook_config.py