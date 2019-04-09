FROM joined-docker.artifactory.danskenet.net/node:10.13.0-alpine

COPY .npmrc /
COPY test.js /
COPY package.json /
RUN npm install

CMD [ "node", "/test" ]
