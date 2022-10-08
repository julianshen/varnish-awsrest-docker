FROM varnish:7.1

# set the user to root, and install build dependencies
USER root
RUN set -e; \
    apt-get update; \
    apt-get -y install $VMOD_DEPS /pkgs/*.deb; \
    apt-get -y install libmhash-dev; \
    \
# install one, possibly multiple vmods
   install-vmod https://github.com/varnish/varnish-modules/releases/download/0.20.0/varnish-modules-0.20.0.tar.gz; \
    \
   install-vmod https://github.com/xcir/libvmod-awsrest/archive/refs/tags/v70.12.tar.gz; \
    \
# clean up and set the user back to varnish
    apt-get -y purge --auto-remove $VMOD_DEPS varnish-dev; \
    rm -rf /var/lib/apt/lists/*
