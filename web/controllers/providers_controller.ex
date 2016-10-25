defmodule FiberFinder.ProvidersController do
  require Logger
  use FiberFinder.Web, :controller
  alias FiberFinder.ZayoProvider


  def show(conn, params) do
    IO.inspect(params)
    # Logger.debug "Logging this text!"

    # Move logic out of controller? Where does it go?
    if Map.has_key?(params, "address") do
      # handle the other responses!
      {:ok, result} = ArcgisGeocode.geocode(params["address"])
      params = Map.put_new(params, "latitude", result.lat)
      params = Map.put_new(params, "longitude", result.lon)
      IO.inspect(params)
    end

    query = ZayoProvider.retrieve(params["longitude"], params["latitude"], params["distance"])
    IO.inspect(query)
    handle_query(conn, query)
    # json conn, %{params: "" <> Ecto.Adapters.SQL.query(FiberFinder.Repo, "SELECT 1", [])}
  end

  # schemay handler
  def handle_query(conn, result) do
      json conn, %{providers: result}
  end

  # handles all atoms
  # def handle_query(conn, {_, result}), do: json conn, result

  # handle by specific atom
  # def handle_query(conn, {:ok, result}) do
  #   json conn, result
  # end
  #
  # def handle_query(conn, {:error, result}), do: json conn, %{message: "you broke it!"}
end
