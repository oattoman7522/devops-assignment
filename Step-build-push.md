**Step Build Images and Push Images to Github Registry:**

1. Command Build Images

```
docker build -t ghcr.io/oattoman7522/go:<tag_number> .
```

2. Push Image to GitHub registry


- Login Github Registry
```
docker login ghcr.io -u $USERNAME -p $PASSWORD
```

- Push Image to Github Registry
```
docker push ghcr.io/oattoman7522/go:<tag_number>
```
