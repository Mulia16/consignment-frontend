# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app

# Copy pom.xml and download dependencies (caches this layer)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the lightweight runtime image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the generated WAR file from the builder stage
COPY --from=builder /app/target/consignment-frontend-1.0.0-SNAPSHOT.war app.war

# Expose the frontend port
EXPOSE 8800

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.war"]
