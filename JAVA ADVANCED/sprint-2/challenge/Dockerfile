# Etapa de build
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app

# Copia o arquivo de configuração Maven e instala as dependências
COPY pom.xml .
RUN mvn dependency:go-offline

# Copia o código e executa o build
COPY . .
RUN mvn clean install -DskipTests

# Etapa final - Imagem otimizada com JRE 21
FROM eclipse-temurin:21-jre
WORKDIR /app
EXPOSE 8080

# Copia o JAR gerado na etapa de build
COPY --from=build /app/target/challenge-0.0.1-SNAPSHOT.jar app.jar

# Comando de execução
ENTRYPOINT ["java", "-jar", "app.jar"]
