FROM dustynv/jetson-inference:r32.7.1  
RUN mkdir -p /tao-tool-kit
COPY ./tao-converter /usr/bin/
CMD bash
