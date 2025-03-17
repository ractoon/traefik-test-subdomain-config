# Traefik Config

This configuration spins up a Traefik container to auto-discover services from Docker labels and manages SSL certificates.

Currently configured to manage "*.test" domains.

## Pre-Requisites

- [mkcert](https://github.com/FiloSottile/mkcert)
- A service like `dnsmasq` to route requests to "*.test" domains to your localhost (127.0.0.1)

## Usage

`mv domains.txt.example domains.txt`

Edit `domains.txt` to contain the domains you would like to use, e.g. `foo.test`

Automatically generate certs and start up the container:

```bash
chmod +x generate-certs.sh start-stack.sh
./start-stack.sh
```

### Update Application `docker-compose.yml`

Add the following labels to your application's `docker-compose.yml` file:

```docker
        labels:
            - "traefik.enable=true"
            - "traefik.http.services.my-app.loadbalancer.server.port=80"
            - "traefik.http.routers.my-app-wildcard.rule=HostRegexp(`{subdomain:[a-z0-9-]+}.${APP_HOST}`) || Host(`${APP_HOST}`)"
            - "traefik.http.routers.my-app-wildcard.entrypoints=websecure"
            - "traefik.http.routers.my-app-wildcard.tls=true"
            - "traefik.http.routers.my-app-wildcard.service=my-app"
```

This assumes there is an environment variable defined named `APP_HOST` with a value like `my-app`, or whatever your hostname is.
