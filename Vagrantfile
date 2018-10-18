# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  config.vm.synced_folder ".", "/linkerd2-proxy"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 4
  end
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    apt-get update
    apt-get install -y curl git gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu
  SHELL
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
    source $HOME/.cargo/env
    rustup target add armv7-unknown-linux-gnueabihf
    rustup target add aarch64-unknown-linux-gnu
    echo '[target.armv7-unknown-linux-gnueabihf]' | tee -a $HOME/.cargo/config
    echo 'linker = \"arm-linux-gnueabihf-gcc\"' | tee -a $HOME/.cargo/config
    echo '[target.aarch64-unknown-linux-gnu]' | tee -a $HOME/.cargo/config
    echo 'linker = \"aarch64-linux-gnu-gcc\"' | tee -a $HOME/.cargo/config
  SHELL
end
