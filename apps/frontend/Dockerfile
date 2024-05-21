
FROM node:20-alpine


WORKDIR /frontend



COPY package.json package-lock.json ./
COPY ./store ./store
COPY ./ui ./ui
RUN npm install



# CMD [ "sh"]
# CMD [ "npm","run","dev" ]
CMD ["sh", "-c", "while :; do sleep 1; done"]


# "@radix-ui/react-accordion": "^1.1.2",
# "@radix-ui/react-dialog": "^1.0.5",
# "@radix-ui/react-icons": "^1.3.0",
# "@radix-ui/react-slot": "^1.0.2",