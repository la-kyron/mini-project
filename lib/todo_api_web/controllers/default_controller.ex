defmodule TodoApiWeb.DefaultController do
  use TodoApiWeb, :controller

  def index(conn, _params) do
    text conn, "API endpoints are working"
  end
end
