## Multi-stage Docker File
# VM > Docker image (java)
# jar
# mvn package > target/*.jar
#  docker > vm > mvn


#Base image consisting of mvn and java
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests


#====================================

# Stage 2: Build the final image
FROM eclipse-temurin:17-alpine
WORKDIR /app
COPY --from=builder /app/target/*jar app.jar
EXPOSE 8081
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]