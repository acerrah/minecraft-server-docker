### **Dockerfile Installation**

#### **1. Create the Minecraft Directory**
Run the following command to create a `minecraft` directory under `/opt/stacks`:

```bash
mkdir -p /opt/stacks/minecraft
cd /opt/stacks/minecraft
```

#### **2. Configure the Server**
Set up the server configuration:

```bash
mkdir -p /opt/stacks/minecraft/server
vim server/server.properties
```

Paste the following configuration into `server.properties`:

```
#Minecraft server properties
accepts-transfers=false
allow-flight=false
allow-nether=true
broadcast-console-to-ops=true
broadcast-rcon-to-ops=true
bug-report-link=
debug=false
difficulty=hard
enable-command-block=false
enable-jmx-monitoring=false
enable-query=false
enable-rcon=true
enable-status=true
enforce-secure-profile=true
enforce-whitelist=false
entity-broadcast-range-percentage=100
force-gamemode=false
function-permission-level=2
gamemode=survival
generate-structures=true
generator-settings={}
hardcore=false
hide-online-players=false
initial-disabled-packs=
initial-enabled-packs=vanilla
level-name=world
level-seed=
level-type=minecraft\:normal
log-ips=true
max-chained-neighbor-updates=1000000
max-players=20
max-tick-time=60000
max-world-size=29999984
motd=My Minecraft Server
network-compression-threshold=256
online-mode=false
op-permission-level=4
pause-when-empty-seconds=60
player-idle-timeout=0
prevent-proxy-connections=false
pvp=true
query.port=25565
rate-limit=0
rcon.password=xxxxxxxxxxxxxxx
rcon.port=25575
region-file-compression=deflate
require-resource-pack=false
resource-pack=
resource-pack-id=
resource-pack-prompt=
resource-pack-sha1=
server-ip=
server-port=25565
simulation-distance=10
spawn-monsters=true
spawn-protection=16
sync-chunk-writes=true
text-filtering-config=
text-filtering-version=0
use-native-transport=true
view-distance=10
white-list=false
```

#### **3. Download or Copy the Dockerfile and Spigot Jar**
Run the following command to download or copy the Spigot JAR file and create a `Dockerfile`:

```bash
scp -r root@xxxxxxx:/opt/stacks/minecraft/spigot-1.21.4.jar .
vim Dockerfile
```

Paste the following content into `Dockerfile`:

```Dockerfile
FROM openjdk:23-jdk-slim

WORKDIR /server

# Copy the server jar file
COPY spigot-1.21.4.jar spigot.jar

# Accept EULA, create necessary directories and options file
RUN echo "eula=true" > eula.txt

VOLUME ["/server"]

EXPOSE 25565

CMD ["java", "-Xms2G", "-Xmx2G", "-jar", "spigot.jar", "nogui"]
```

#### **4. Create a Volume**
Create a **Docker volume** to persist server data:

```bash
docker volume create --opt type=none --opt device=/opt/stacks/minecraft/server --opt o=bind minecraft_data
```

#### **5. Start the Docker Container with the Volume**
Run the Minecraft server container with volume binding:

```bash
docker run -d -p 25565:25565 -p 25575:25575 -v minecraft_data:/server --name minecraft-server minecraft-spigot
```

---

## **Monitoring and Maintenance**
#### **1. Install Mcrcon**
Mcrcon allows remote administration of the Minecraft server. Install it with:

```bash
git clone https://github.com/Tiiffi/mcrcon.git
cd mcrcon
make
sudo make install
```

#### **2. Example Command to Connect to the Panel**
Use the following command to connect to the Minecraft RCON panel:

```bash
mcrcon -H 0.0.0.0 -P 25575 -p Systemadmin123
```

#### **3. View Server Logs**
To check the logs of the running Minecraft server:

```bash
docker logs minecraft-server
```

Now your **Minecraft server is set up and running inside a Docker container** with **persistent storage, remote management, and logging support**! 🚀🎮
