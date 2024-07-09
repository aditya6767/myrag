To use the app using docker, run the following command

```
git clone git@github.com:aditya6767/myrag.git
docker-compose -f docker-compose pull
docker-compose -f docker-compose up -d
```

Once the dockers are up, make a curl command to 2121 port to talk to the chatbot

```
curl -X POST http://localhost:2121/post_question/ --data {"question":"How are you?"}
```