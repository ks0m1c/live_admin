defmodule LiveAdmin.View do
  use Phoenix.Component
  use Phoenix.HTML

  alias LiveAdmin.Components.Nav

  js_path = Path.join(__DIR__, "../../dist/js/app.js")
  css_path = Path.join(__DIR__, "../../dist/css/app.css")
  default_css_overrides_path = Path.join(__DIR__, "../../dist/css/default_overrides.css")

  @external_resource js_path
  @external_resource css_path
  @external_resource default_css_overrides_path

  @app_js File.read!(js_path)
  @app_css File.read!(css_path)
  @default_css_overrides File.read!(default_css_overrides_path)

  @env Mix.env()

  embed_templates("components/layout/*")

  def render("app.html", assigns), do: app(assigns)
  def render("layout.html", assigns), do: layout(assigns)

  def render("nav.html", assigns) do
    assigns = assign(assigns, mod: Keyword.get(assigns.components, :nav, Nav))

    ~H"""
    <.live_component
      id="nav"
      module={@mod}
      socket={@socket}
      resources={@resources}
      base_path={@base_path}
    />
    """
  end

  def render_js, do: "var ENV = \"#{@env}\";" <> @app_js

  def render_css,
    do: @app_css <> Application.get_env(:live_admin, :css_overrides, @default_css_overrides)

  def render_field(record, field, _) do
    record
    |> Map.fetch!(field)
    |> case do
      val when is_binary(val) -> val
      val -> inspect(val)
    end
  end
end
