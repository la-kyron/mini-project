defmodule TodoApiWeb.AccountJSON do
  alias TodoApi.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hashed_password: account.hashed_password
    }
  end

  def account_token(%{token: token, account: account}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end