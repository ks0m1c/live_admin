<!-- This README was generated with docout (https://github.com/tfwright/docout). Edits should be made to the formatter instead of this file, other changes will be overridden on compile. -->

# LiveAdmin

[![hex package](https://img.shields.io/hexpm/v/live_admin.svg)](https://hex.pm/packages/live_admin)
[![CI status](https://github.com/tfwright/live_admin/workflows/CI/badge.svg)](https://github.com/tfwright/live_admin/actions)

An admin UI for Phoenix applications built on [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) and [Ecto](https://github.com/elixir-ecto/ecto/).

Significant features:

* First class support for multi tenant applications via Ecto's `prefix` option
* Overridable views and API
* Easily add custom actions at the schema and record level
* Ability to edit (nested) embedded schemas

## Installation

First, ensure your Phoenix app has been configured to use [LiveView](https://hexdocs.pm/phoenix_live_view/installation.html).

Add to your app's `deps`:

```
{:live_admin, "~> 0.9.2"}
```

To use LiveAdmin in a Phoenix router, first `import LiveAdmin.Router`

Then configure a group of resources to serve at desired path:

```
live_admin "/my_admin" do
  admin_resource "/my_schemas", MyApp.MyResource
end
```

In this example, a single resource will be accessible at `/my_admin/my_schemas`.

`LiveAdmin.Router.live_admin/2` may also be used to set configuration that applies to all resources in the group.

The module passed as the second argument to `LiveAdmin.Router.admin_resource/2` must use the `LiveAdmin.Resource` API.
See that module's docs for a full list of options that can be used to configure the behavior of the resource.

* Note: It is possible to run multiple UIs each with their own prefix and independent configuration. Only global (app)
config will be shared.

## App config

The following is an example of minimal runtime configuration:

```
config :live_admin, ecto_repo: MyApp.Repo
```

Full list of supported options:

* `ecto_repo` (required) - the Ecto repo to use for db operations
* `prefix_options` - a list or MFA specifying `prefix` options to be passed to Ecto functions
* `css_overrides` - a binary or MFA identifying a function that returns CSS to be appended to app css
* `session_store` - a module implementing the `LiveAdmin.Session.Store` behavior, used to persist session data


Note: Resource configuration options can also be set here in order to define a global default to apply to all resources unless overridden in their individual config.

See [development app](/dev.exs) for more example configuration.

## Development environment

This repo has been configured to run the application in Docker. Simply run `docker compose up` and navigate to http://localhost:4000

The Phoenix app is running the `app` service, so all mix command should be run there. Examples:

* `docker compose run web mix test`

---

README generated with [docout](https://github.com/tfwright/docout)
