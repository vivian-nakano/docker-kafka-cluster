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