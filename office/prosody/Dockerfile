FROM prosody/prosody

USER root
RUN apt-get -qq update; apt-get -y dist-upgrade; apt-get -qqy install mercurial
RUN hg clone https://hg.prosody.im/prosody-modules/ prosody-modules; mv -v prosody-modules/* /usr/lib/prosody/modules/
RUN apt-get -qqy install lua-ldap
USER prosody
