# csdev.github.io

## Commands

Serve docs locally:

```sh
docker-compose run --rm --service-ports jekyll-serve
```

Rebuild container:

```sh
docker-compose build --progress=plain jekyll
```

Update gems (inside dev container):
```sh
bundle update
```
