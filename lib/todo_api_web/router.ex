defmodule TodoApiWeb.Router do
  # alias TodoApiWeb.AccountController
  use TodoApiWeb, :router
  # use Plug.ErrorHandler

  # defp handle_errors(conn, %{reason: %  Phoenix.Router.NoRouteError{message: message}})
  # do
  #   conn
  #   |> json(%{errors: message})
  #   |> halt()
  # end
  # defp handle_errors(conn, %{reason: %{message: message}})
  # do
  #   conn
  #   |> json(%{errors: message})
  #   |> halt()
  # end
  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.Pipeline, module: TodoApiWeb.Auth.Guardian, error_handler: TodoApiWeb.Auth.GuardianErrorHandler
  end

  scope "/api", TodoApiWeb do
    pipe_through :api

    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create   #register
    # post "/login", AccountController, :sign_in
    resources "/todos", TodoController, except: [:new, :edit]
  end
end
