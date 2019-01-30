FROM debian

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y libasound2-dev checkinstall libpython2.7-dev \
			build-essential vim htop mc wget

RUN wget http://pjsip.org/release/2.5.5/pjproject-2.5.5.tar.bz2 -O /usr/local/src/pjproject-2.5.5.tar.bz2
RUN cd /usr/local/src/ && tar xjvf pjproject-2.5.5.tar.bz2

RUN export CFLAGS="$CFLAGS -fPIC" && \
	cd /usr/local/src/pjproject-2.5.5/ && \
	./configure && \
	make dep && \
	make -j 2

RUN cd /usr/local/src/pjproject-2.5.5/ && \
	checkinstall --pkgname pjsua-python

RUN cd /usr/local/src/pjproject-2.5.5/pjsip-apps/src/python/ && \
	apt-get install -y python3 python-minimal

RUN cd /usr/local/src/pjproject-2.5.5/pjsip-apps/src/python/ && \
	python setup.py install

RUN cd /usr/local/src/pjproject-2.5.5/pjsip-apps/src/python/ && \
	python3 setup.py install
