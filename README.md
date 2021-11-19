# Cluster Kafka com Docker e Docker Compose
Este repositório contém informações mais práticas sobre a criação de um cluster Kafka com Docker, producer, consumer, conectores e criação de mensagens personalizadas. 

## Pré-requisitos
- Docker + Docker compose

## Passos

Criação do cluster 
```
$ docker-compose up
```

Criação de tópico

Criação do cluster 
```
$ docker exec -it broker bash
```
Comando para entrarmos no servidor do broker. Observar que possui com valor único específico de appuser para o broker. 

```
$ cd /bin
```

Obs: aqui pode executar no usuário principal, não precisa realizar o comando na pasta onde está o arquivo YAML (docker-compose.yaml).

Criação do cluster 
```
$ ./kafka-topics --create --topic nometopico --bootstrap-server localhost:9092
```
Podemos trocar o create por describe para analisar o que tem no tópico (partição, réplicas)

Criação do producer
Repetir o comando 'docker exec -it broker bash' e dar um 'cd /bin'

```
$ ./kafka-console-producer --bootstrap-server localhost:9092 --topic nometopico
```
A partir deste momento já podemos enviar mensagens, porém para ver o conteúdo da mensagem é necessário criar o consumer.

Criação do consumer
Repetir o comando 'docker exec -it broker bash' e dar um 'cd/bin'
```
$ ./kafka-console-consumer --bootstrap-server localhost:9092 --topic nometopico
```

A partir de agora é possível enviar mensagens do producer e recebê-las no consumer. Uma dica é utilizar prompts diferentes para analisar o comportamente e melhorar a organização. 

----------------
Após producer e consumer estarem configurados podemos dar início na criação do Kafka Connector e suas configurações.

```
$ docker exec -it kafka-connect bash
```
Aqui entramos no "servidor" do Kafka Connect.
Obs: valores do appuser mudam naturalmente pois consiste em outro local. 

Consulta no servidor Kafka Connect

```
curl -s http://localhost:8083
curl -s http://localhost:8083/connectors
curl -s http://localhost:8083/connectors/file_sink_01_status
```

```
curl -X http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
    "name": "file_sink_01",
    "config": {
        "batch.size":"1",
        "batch.max.rows":"1",
        "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
        "topics":"nometopico",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": false, 
        "key.converter": "org.apache.kafka.connect.json.JsonConverter",
        "key.converter.schemas.enable": false,
        "file": "/home/appuser/data/sile_sink_01.txt",
        "transforms": "addMetadata",
        "transforms.addMetadata.type": "...",
        "transforms.addMetadata.offset.field": "...",
        "transforms.addMetadata.partition.field": "...",
        "errors.tolerance": "all"
        }
   }'
```   
-----

Após conector criado, é possível rodar alguns comandos para verificar se a mensagem chega no arquivo ("file_sink_01.txt")

```
$ docker exec -it kafka-connect bash
```

```
$ cd data
```

```
$ cat file_sink_01.txt
```
Comando que lista mensagens dentro do arquivo especificado uma única vez.
```
$ tail -f file_sink_01.txt
```
Comando lista os arquivos e mantém o mesmo aberto, mostrando mensagens que chegam instantaneamente.

<hr>
