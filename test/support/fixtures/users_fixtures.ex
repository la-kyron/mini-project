defmodule TodoApi.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApi.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        full_name: "some full_name",
        gender: "some gender"
      })
      |> TodoApi.Users.create_user()

    user
  end
end
