# Etapa de build
FROM maven:3.8-openjdk-21 AS base
WORKDIR /app

# Copia o arquivo de configuração Maven e instala as dependências
COPY pom.xml .
RUN mvn dependency:go-offline

# Copia o código e executa o build
COPY . .
RUN mvn clean install

# Etapa final
FROM openjdk:21-slim
WORKDIR /app
EXPOSE 8080

# Copia o JAR gerado na etapa anterior
COPY --from=base /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

# Comando de execução
ENTRYPOINT ["java", "-jar", "demo.jar"]
