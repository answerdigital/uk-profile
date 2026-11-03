FROM swaggerapi/swagger-ui:v5.31.0

COPY schema/ /usr/share/nginx/html/schema/

RUN sed -i 's|https://raw.githubusercontent.com/openreferral/uk-profile/main/schema/|/schema/|g' \
    /usr/share/nginx/html/schema/*.json

ENV URL=/schema/openapi.json \
    VALIDATOR_URL=none \
    SUPPORTED_SUBMIT_METHODS=[]

EXPOSE 8080
