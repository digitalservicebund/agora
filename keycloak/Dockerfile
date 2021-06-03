From maven:3-openjdk-11 as extension-builder
COPY extensions/agora-welcome /home/app
RUN mvn clean install -f /home/app

FROM jboss/keycloak:13.0.1

COPY agora_theme /opt/jboss/keycloak/themes/agora
COPY profile.properties /opt/jboss/keycloak/standalone/configuration/profile.properties

COPY --from=extension-builder /home/app/target/agora-welcome-listener-0.0.1.jar /opt/jboss/keycloak/standalone/deployments/agora-welcome-listener.jar
