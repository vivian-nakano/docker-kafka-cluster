# docker-kafka-cluster
Criação de cluster Kafka com Docker e Docker Compose

# Comandos

Criação do cluster 
```
$ docker compose up
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
