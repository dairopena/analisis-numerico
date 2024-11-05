# Use Arch Linux as the base image
FROM archlinux:latest

# Update the package lists and install necessary dependencies
RUN pacman -Syyu --noconfirm \
    && pacman -S --noconfirm \
        wget \
        base-devel \
        git \
        cmake \
        ncurses \
        xz \
        tk \
        libffi \
        lzma \
        curl \
        ca-certificates \
        glib2 \
        gtk2 \
        atlas-lapack \
        gfortran \
        openblas \
        opencv \
        python3 \
        python3-pip

# Install Miniconda
RUN curl -sL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && /opt/conda/bin/conda init

# Install the C++ kernel for Jupyter Notebook
RUN pip install --no-cache-dir clingkernel \
    && clingkernel install

# Set the entry point
CMD [ "/opt/conda/bin/jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root" ]