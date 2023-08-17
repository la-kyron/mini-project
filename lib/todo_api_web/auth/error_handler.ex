defmodule TodoApiWeb.Auth.GuardianErrorHandler do
  import Plug.Conn

  def unauthenticated(conn, _reason) do
    conn
    |> put_status(401)
  end
  defexception [message: "Unauthorized", plug_status: 401]
end
