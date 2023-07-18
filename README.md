# arrow-mino

Golang with Arrow, Sqlite, Minio

## Goal

A clean and simple solution for Data and Multimedia (images and video) to be indexed with SQLite enabling Arrow FlightSQL based data queries and updates.

The example can all be installed easily with just a make file and be cross platform without any docker to make it very easy to run etc.

It’s also very small amount of code.

What follows is the proposed Architecture Stack

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


