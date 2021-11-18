# Cluster Kafka com Docker e Docker Compose
Este repositório contém informações mais práticas sobre a criação de um cluster Kafka com Docker, producer, consumer, conectores e criação de mensagens personalizadas. 

## Pré-requisitos
<hr>
- Docker + Docker compose

# Passos
<hr>

Criação do cluster 
```
$ docker-compose up
```

Criação de tópico

Criação do cluster 
```
$ docker exec -it broker bash
```
```
$ cd /bin
```

Obs: aqui pode executar no usuário principal, não precisa dar o bash na pasta onde está o arquivo YAML (docker-compose)
Criação do cluster 
```
$ ./kafka-topics --create --topic nometopico --boostrap-server localhost:9092
```
Podemos trocar o create por describe para analisar o que tem no tópico (partição, réplicas)

Criação do producer
Repetir o comando 'docker exec -it broker bash' e dar um 'cd /bin'

```
$ ./kafka-console-producer --bootstrap-server localhost:9092 --topic nometopico
```
A partir daí já podemos enviar alguma mensagem, porém para ver o conteúdo da mensagem é necessário criar o consumer.

Criação do consumer
Repetir o comando 'docker exec -it broker bash' e dar um 'cd/bin'
```
$ ./kafka-console-consumer --bootstrap-server localhost:9092 --topic nometopico
```

A partir de agora é possível enviar mensagens do producer e recebê-las no consumer. Uma dica é utilizar prompts diferentes para analisar o comportamente e melhorar a organização. 

----------------
Producer e consumer configurado podemos dar início a criação do Kafka Connector e suas configurações.

```
$ docker exec -it kafka-connect bash
```
Aqui entramos no "servidor" do kafka connect. No anterior a gente estava entrando no broker. Por isso os valores do appuser mudam, pois é outro local. 

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

Após connector criado, é possível rodar alguns comandos para verificar se a mensagem chega no arquivo ("file_sink_01.txt")

```
$ docker exec -it kafka-connect bash
```

```
$ cd data
```

```
$ cat file_sink_01.txt
```
Esse lista as mensagens dentro do arquivo.
```
$ tail -f file_sink_01.txt
```
Esse comando deixa o arquivo aberto e mostra a mensagem chegando na hora.
