# Egcovac

Registration System for COVID-19 Vaccine

## Quick Guide for local development setup

### Upping your services which you composed with docker-compose

  Go to the directory where docker-compose.yml is located, i.e. ($ cd $USER/workspace/egcovac)

  ```sh

  docker-compose build
  docker-compose up
  ```

* If you git this error `[error] Postgrex.Protocol (#PID<0.3932.0>) failed to connect: ** (Postgrex.Error) FATAL 3D000 (invalid_catalog_name) database "myapp_dev" does not exist`
* Stop container `CTRL+C`
* Run `docker-compose run web mix ecto.create`
* Then `docker-compose up`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
