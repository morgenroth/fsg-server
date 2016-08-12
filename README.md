# Create required bridge network #

```
docker network create \
	-d bridge \
	-o "com.docker.network.bridge.name"="br-manage" \
	--ip-range=10.10.3.128/26 \
	--subnet=10.10.3.0/24 \
	--gateway=10.10.3.1 \
	 manage
```

