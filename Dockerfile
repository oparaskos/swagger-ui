# The purpose of this image is to help version control API design contracts 
#  as they are being produced by allowing a person to make changes on their
#  local computer and using version control.
#
# To create a self sustained swagger spec as its own project:
#  * Create a project folder with a /app/swagger.yml
#  * (Create a start script or) run the docker image with 'docker run -p 8080:8080 -v "${PWD}/app:/app" paraskos/swagger-ui:latest'
#  * Changes are reflected when the page is refreshed.
#  * Files can be seperated using JSON Reference (supported by Swagger) to facilitate easier merging etc.

FROM nginx:1.15-alpine

RUN apk add nodejs

ENV API_KEY "**None**"
ENV URL "/app/swagger.yml"
ENV PORT 8080
ENV BASE_URL ""

COPY ./docker/nginx.conf /etc/nginx/

# copy swagger files to the `/js` folder
COPY ./dist/* /usr/share/nginx/html/
COPY ./docker/run.sh /usr/share/nginx/
COPY ./docker/configurator /usr/share/nginx/configurator

RUN chmod +x /usr/share/nginx/run.sh

EXPOSE 8080

CMD ["sh", "/usr/share/nginx/run.sh"]
