FROM debian:bullseye-slim 

#Labels
LABEL version=0.0.0.1

#Env variables
ENV ENV_FILE=.env

ARG CREATED_USER=kbrousse

#Directory
WORKDIR /env

#Install requirements and create non-root user
RUN apt update &&\
	apt upgrade &&\
	apt install nginx -y &&\
	adduser -D $(CREATED_USER)

#must add apt clean later on-----------------------------------

#Copy files
COPY --chown=$(CREATED_USER) env.txt /env/

#Switching to non-root user
RUN whoami
USER $(CREATED_USER):$(CREATED_USER)
RUN whoami

#Expose
EXPOSE 80

CMD ["sleep", "60"]
