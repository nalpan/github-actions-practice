FROM timbru31/node-alpine-git:14
COPY --from=trajano/alpine-libfaketime  /faketime.so /lib/faketime.so
COPY index.js /index.js
ENV LD_PRELOAD=/lib/faketime.so
ENV FAKETIME=+15d

# CMD date
CMD node /index.js
