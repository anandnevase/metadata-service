FROM maven:3.5.2-jdk-8 AS build  
COPY ./src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:alpine
COPY --from=build /usr/src/app/target/metadata-service.jar /usr/app/metadata-service.jar
EXPOSE 8080 9009
ENTRYPOINT ["java","-jar","/usr/app/metadata-service.jar"] 
