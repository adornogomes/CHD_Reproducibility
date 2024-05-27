#!/bin/bash

# Function to verify and install a package with apt-get (Ubuntu) or dnf (Fedora)
VerifyAndInstallPackage() {
    package=$1

    # Check if the system is Ubuntu (based on the presence of /etc/apt/sources.list)
    if [ -f /etc/apt/sources.list ]; then
        if ! dpkg -s "$package" >/dev/null 2>&1; then
            echo "$package is not installed. Installing $package..."

            if [[ $package == *virtualbox* ]]; then
               sudo apt-get update -y
               sudo apt-get install -y wget gnupg2
               wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
               wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
               sudo sh -c 'echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" > /etc/apt/sources.list.d/virtualbox.list'
            fi

            if [[ $package == *vagrant* ]]; then
               sudo apt-get update -y
               sudo apt-get install -y wget gnupg2
               wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
               echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            fi

            sudo apt-get update
            sudo apt-get install -y "$package"

            if [ $? -eq 0 ]; then
                echo "$package was installed successfully."
            else
                echo "Error during the installation of $package. Check error messages."
                exit 1
            fi
        else
            echo "$package is already installed."
        fi
    # Check if the system is Fedora (based on the presence of /etc/redhat-release)
    elif [ -f /etc/redhat-release ]; then
        if ! rpm -q "$package" >/dev/null 2>&1; then
            echo "$package is not installed. Installing $package..."
            sudo dnf install -y "$package"

            if [ $? -eq 0 ]; then
                echo "$package was installed successfully."
            else
                echo "Error during the installation of $package. Check error messages."
                exit 1
            fi
        else
            echo "$package is already installed."
        fi
    else
        echo "Unsupported distribution."
        exit 1
    fi
}

# Verify and install Vagrant based on the distribution
VerifyAndInstallPackage 'vagrant'

# Verify and install VirtualBox based on the distribution
VerifyAndInstallPackage 'virtualbox-7.0'

# Download the scripts from Github
wget https://raw.githubusercontent.com/adornogomes/CHD_Reproducibility/main/resources/Vagrantfile -O Vagrantfile
wget https://raw.githubusercontent.com/adornogomes/CHD_Reproducibility/main/resources/chd_ecf.yml -O chd_ecf.yml

# Run vagrant up command
vagrant up

# Check the exit code of the command
if [ $? -eq 0 ]; then
    echo "The CHD environment is up and ready to run the application."
else
    echo "vagrant up failed."
fi
