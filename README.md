To use the app using docker, run the following command

```
git clone git@github.com:aditya6767/myrag.git
docker-compose -f docker-compose.yml pull
docker-compose -f docker-compose.yml up -d
```

Once the dockers are up, make a curl command to 2121 port to talk to the chatbot

```
curl --location 'http://0.0.0.0:2121/post_question/' \
--header 'Content-Type: application/json' \
--data '{
    "question": "What is open5gs?"
}'
```