**Step Build Images and Push Images to Docker Hub:**

1. Command Build Images

```
docker build -t oattoman7522/devops-assignment:<tag_number> .
```

2. Push Image to GitHub registry


- Login Docker Hub
```
docker login -u oattoman7522 -p $PASSWORD
```

- Push Image to Docker Hub
```
docker push ghcr.io/oattoman7522/go:<tag_number>
```

- URL Docker Hub
```
https://hub.docker.com/repository/docker/oattoman7522/devops-assignment/general
```