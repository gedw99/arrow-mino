# arrow-mino

Golang project using Arrow, Sqlite, Minio, NATS

URL: https://github.com/gedw99/arrow-mino

## Goal

A clean and simple solution for Data and Multimedia (images and video) to be indexed with SQLite enabling Arrow FlightSQL based data queries and updates.

More info here: https://arrow.apache.org/docs/format/FlightSql.html

The example can all be installed easily with just a make file and be cross platform without any docker to make it very easy to run etc.

It’s also very small amount of code.

What follows is the proposed Architecture Stack...

## Development

All binaries and data is local to this repo and will not be put anywhere else on your system.

The 2 folders are:
.bin
.data

To install everything:

```sh
# All tools and servers are installed into the local .bin directory
make 0-dep

```

To run everything individually:

```sh
# all servers use the local .data directory

# boot minio
make 1-minio

# boot Arrow Sqlite for Flight SQL
make 2-sqlite

# boot caddy
make 10-caddy
```

To serve everything from a ProcFile:

```sh
make all-serve

```

To package for Desktop and Server deployment:

```sh
make all-package

```


## SQLite

We start from the SQLite example here: https://github.com/apache/arrow/tree/main/go/arrow/flight/flightsql/example that we can built on top of.

## SQLite replication

We want:

- Multi master: Sqlite DB able to be scaled and redundant.
- Serverless: Marmot allows snap-shotting to and from Minio.

Use:

- https://github.com/maxpert/marmot
- Uses NATS Jetstream : https://github.com/nats-io/jetstream

## Minio cluster

We want:

- Multi master: Minio is highly redundant and scalable with very little admin required.
- CDC: When anything changes in Minio, we inform Sqlite, so that any other actors that change minio is informed to Sqlite.

Use:

- Admin: https://github.com/minio/madmin-go
- CDC base on : https://github.com/nats-io/demo-minio-nats


## Caddy Proxy

Wa want:

- To make it secure and easy to do so.

Use:

- with Authelia Auth.
- https://caddyserver.com/docs/caddyfile/directives/forward_auth#authelia
- https://www.authelia.com/integration/proxies/caddy/


## Admin GUI

We want:

- Arrow Flight SQL GUI for Admin and Devs / Users

Use:

- Pure Go templates.
- HTMX based updates to Browser, so that any changes stream to all web tabs and to parts within a web page.
- https://github.com/acaloiaro/hugo-htmx-go-template
  - Hugo with Htmx, makes it very easy to build a Web Admin and Docs
  - Can also be run in User Mode, so that Users can add Markdown, and it creates the HTML on the fly.
- https://arrow.apache.org/docs/js/
  - Have not used this, but lets see what it can provide.
- https://github.com/pocketbase/pocketbase/discussions/2898
  - Pocketbaes uses Sqlite and might be a good based

## Deplyoment

Fly.io can run a single docker that has the binaries injected and a ProcFile. This is a very simple way to run.

Replication and HA:

Fly.io also can scale up and down across regions, and Minio and NATS will keep all regions in sync.


