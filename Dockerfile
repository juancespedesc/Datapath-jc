# Utilizar la imagen base de Ubuntu
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    wget \
    mysql-server\
    && apt-get clean

RUN pip3 install --upgrade pip && \
    pip3 install notebook

WORKDIR /workspace

# Crear el directorio de configuración de Jupyter 
RUN mkdir -p /root/.jupyter

# Añadir el archivo de configuración de Jupyter 
RUN echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \ 
    echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py && \ 
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py && \ 
    echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888 3306

#CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root" ]

CMD service mysql start && \
    jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root