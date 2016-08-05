# Create required bridge network #

```
docker network create \
	-d bridge \
	-o "com.docker.network.bridge.name"="br-manage" \
	--ip-range=10.10.3.0/24 \
	--subnet=10.10.0.0/16 \
	--gateway=10.10.1.1 \
	 manage
```

