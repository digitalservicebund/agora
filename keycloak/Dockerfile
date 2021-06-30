FROM maven:3-openjdk-11 as extension-builder-1
COPY extensions/agora-welcome /home/app
RUN mvn clean install -f /home/app

FROM maven:3-openjdk-11 as extension-builder-2
COPY extensions/survey-required-action /home/app
RUN mvn clean install -f /home/app


FROM jboss/keycloak:13.0.1
LABEL org.opencontainers.image.source https://github.com/zechmeister/agora

COPY agora_theme /opt/jboss/keycloak/themes/agora
COPY profile.properties /opt/jboss/keycloak/standalone/configuration/profile.properties

COPY --from=extension-builder-1 /home/app/target/agora-welcome-listener-0.0.1.jar /opt/jboss/keycloak/standalone/deployments/agora-welcome-listener.jar
COPY --from=extension-builder-2 /home/app/target/survey-required-action-0.0.1.jar /opt/jboss/keycloak/standalone/deployments/survey-required-action.jar
