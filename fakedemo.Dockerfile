FROM timbru31/node-alpine-git:14
COPY --from=trajano/alpine-libfaketime  /faketime.so /lib/faketime.so
ENV LD_PRELOAD=/lib/faketime.so
ENV FAKETIME=+15d
RUN mkdir /work-directory
COPY index.js /work-directory/index.js
COPY package.json /work-directory/package.json
RUN cd /work-directory && \ 
npm i

# CMD node /work-directory/index.js
CMD cd /work-directory && npm start
