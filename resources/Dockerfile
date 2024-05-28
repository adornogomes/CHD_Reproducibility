# Use Ubuntu 18.04 como imagem base
FROM ubuntu:18.04

# Definir o responsável pela imagem
LABEL maintainer="adornogomes@gmail.com"

# Definir a variável de ambiente ARCHITECTURE
ENV ARCHITECTURE=InceptionV3

# Atualizar a lista de pacotes e instalar alguns pacotes essenciais
RUN apt-get update && \
     apt-get install -y \
     software-properties-common

# Garantir que pip3 esteja instalado
RUN apt-get install -y python3-pip

# Instalar Protobuf 3.19.6 usando pip3
RUN pip3 install protobuf==3.19.6

# Instalar TensorFlow 1.7.0 usando pip3
RUN pip3 install tensorflow==1.7.0

# Criar o diretório /output
RUN mkdir /output

# Definir o diretório de trabalho
WORKDIR /exp

# Copiar múltiplos arquivos para a imagem
COPY run_training.sh run_label_sda.sh run_label_cda.sh label_image.py retrain.py /exp/

# Copiar um diretório completo para a imagem
#COPY rx /exp/rx
#COPY test /exp/test

# Expose the TensorBoard port
EXPOSE 6006
