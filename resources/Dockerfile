# Ubuntu 18.04 was defined as the base image
FROM ubuntu:18.04

# Owner of the image
LABEL maintainer="adornogomes@gmail.com"

# This environment variable is used during the execution of the application
ENV ARCHITECTURE=InceptionV3

# Update the package list and install some essential packages
RUN apt-get update && \
     apt-get install -y \
     software-properties-common

# Install pip3
RUN apt-get install -y python3-pip

# Install Protobuf 3.19.6 using pip3
RUN pip3 install protobuf==3.19.6

# Install TensorFlow 1.7.0 using pip3
RUN pip3 install tensorflow==1.7.0

# Create a directory named "output"
RUN mkdir /output

# Define the work directory
WORKDIR /exp

# Copy all the files to the image
COPY run_training.sh run_label_sda.sh run_label_cda.sh label_image.py retrain.py /exp/

# Copy the directories "rx" and "test" to the image
COPY rx /exp/rx
COPY test /exp/test

# Expose the TensorBoard port
EXPOSE 6006
