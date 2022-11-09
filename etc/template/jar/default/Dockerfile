# Compile
FROM openjdk:17-alpine as compilation

WORKDIR /usr/src/app

COPY . .

RUN chmod 777 mvnw
RUN ./mvnw  install -DskipTests


# RUN mvnw clean install -DSkipTests=true

# Run
# TODO: check if any jre version of jdk17 exist?
FROM openjdk:17.0.2-slim-buster
WORKDIR /app/${{appName}}
COPY --from=compilation /usr/src/app/target/*.jar /app/${{appName}}/app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

