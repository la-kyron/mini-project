defmodule TodoApiWeb.AccountController do
  use TodoApiWeb, :controller

  alias TodoApi.Users
  alias TodoApi.Accounts
  alias TodoApi.Accounts.Account
  alias TodoApi.Users.User
  alias TodoApiWeb.Auth.Guardian
  alias TodoApiWeb.Auth.GuardianErrorHandler

  action_fallback TodoApiWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(account),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params)
        do
      conn
      |> put_status(:created)
      |> render(:account_token, %{token: token, account: account})
    end
  end
  # def sign_in(conn, {"email" => email, "hashed_password" => hashed_password})
  # do
  #   case Guardian.authenticate(email, hashed_password)
  #   do
  #     {:ok, account, token} ->
  #       conn
  #       |> put_status(:ok)
  #       |> render(:account_token, %{account: account, token: token})
  #     {:unauthenticated, :unauthorized} ->
  #       raise
  #       ErrorHandler.Unauthorized, message: 'Invalid credentials'
  #       |> put_status(:unauthorized)
  #       |> render(:unauthenticated, )
  #   end
  # end
  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
