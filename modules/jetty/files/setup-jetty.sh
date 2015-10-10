#!/bin/bash

wget http://download.eclipse.org/jetty/9.2.13.v20150730/dist/jetty-distribution-9.2.13.v20150730.zip -O /tmp/jetty-dist.zip

pushd /tmp > /dev/null

  unzip -o jetty-dist.zip
  mv jetty-distribution-9.2.13.v20150730 /opt/jetty

popd > /dev/null

chown -R jetty:jetty /opt/jetty

ln -s /opt/jetty/bin/jetty.sh /etc/init.d/jetty
