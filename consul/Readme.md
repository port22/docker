

```
export DOMAIN=example.com
docker stack deploy -c ./docker-compose.yml consul
```

acl.json:
```
{
  "acl": {
    "enabled": true,
    "default_policy": "allow",
    "down_policy": "extend-cache",
    "enable_token_persistence": true
  }
}
```
