FROM openjdk:23-jdk-slim

WORKDIR /server

# Sunucu jar dosyasını kopyala
COPY spigot-1.21.4.jar spigot.jar

# EULA'yı kabul et, gerekli dizinleri oluştur ve options dosyasını oluştur
RUN echo "eula=true" > eula.txt

VOLUME ["/server"]

EXPOSE 25565

CMD ["java", "-Xms2G", "-Xmx2G", "-jar", "spigot.jar", "nogui"]
