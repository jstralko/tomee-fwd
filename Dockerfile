 FROM azul/zulu-openjdk-alpine:8u202

 RUN apk update
 RUN apk add --no-cache gnupg
 RUN apk add curl

 #Ref: https://github.com/tomitribe/docker-tomee/blob/345cfefbfe4ef0956f0ea2caf1af2595111f5a85/8-jre-1.7.5-plume/Dockerfile
 #--------Start of TomEE base install------------

 ENV PATH /usr/local/tomee/bin:$PATH
 RUN mkdir -p /usr/local/tomee

 WORKDIR /usr/local/tomee

 RUN curl -fSL https://dist.apache.org/repos/dist/release/tomee/tomee-8.0.0-M2/apache-tomee-8.0.0-M2-plume.tar.gz -o tomee.tar.gz \
 	&& tar -zxf tomee.tar.gz \
 	&& mv apache-tomee-plume-8.0.0-M2/* /usr/local/tomee \
 	&& rm -Rf apache-tomee-plume-8.0.0-M2 \
 	&& rm tomee.tar.gz*

 #-----end of TomEE Base install----------------

COPY tomee.xml /usr/local/tomee/conf
COPY context.xml /usr/local/tomee/conf

RUN mkdir /usr/local/tomee/apps
COPY app/ear/target/*.ear /usr/local/tomee/apps

 #Debug
 ENV JPDA_ADDRESS="8000"
 ENV JPDA_TRANSPORT="dt_socket"

 ENTRYPOINT ["catalina.sh", "jpda", "run"]
