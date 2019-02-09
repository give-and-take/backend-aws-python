FROM gradle:jdk8-alpine as builder
RUN echo 'org.gradle.daemon=false' > ./.gradle/gradle.properties
COPY backend .
RUN gradle test
RUN gradle bootJar

FROM openjdk:8-jre-alpine
RUN mkdir /app
WORKDIR /app
COPY --from=builder /home/gradle/build/libs/backend-*.jar .
RUN mv backend-*.jar backend.jar
CMD ["java", "-jar", "backend.jar"]

# TODO - expose port
# TODO - install nginx
# TODO - add https
