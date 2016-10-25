defmodule FiberFinder.FiberLinesProvider do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  alias FiberFinder.Repo


  @primary_key {:ogc_fid, :integer, []}

  schema "zayo" do
    field :providerName, :string, virtual: true
    field :name, :string
    field :line, :string, virtual: true
  end

  @required_fields ~w(name, distance, longitude, latitude)
  @optional_fields ~w()

  @doc """
  Searches for geometries that are within a certain distance of
  a given latitude and longitude.

  todo: consider what to do about grouping provider results to one row w/ zayo and distance
  """
  def retrieve(longitude, latitude, distance, name) do
    __MODULE__
    |> where([z], z.name==^name and fragment("ST_DWithin(wkb_geometry :: GEOGRAPHY, ST_SetSRID(ST_MakePoint(?, ?), 4326), ?)",
     type(^longitude, :float), type(^latitude, :float), type(^distance, :float)))
    |> select([z], %{"id" => z.ogc_fid, "providerName" => "zayo", "name" => z.name,
    "line" => fragment("'{\"type\": \"FeatureCollection\", \"features\": [{\"type\": \"Feature\", \"geometry\": ' || st_asgeojson(ST_Intersection(st_buffer(geography(ST_ClosestPoint(wkb_geometry, ST_SetSRID(ST_MakePoint(?, ?),4326))), ?),wkb_geometry)) || '}]}' AS line",
     type(^longitude, :float), type(^latitude, :float), type(^distance, :float))})
    |> Repo.all

    # |> where(fragment("ST_DWithin(wkb_geometry :: GEOGRAPHY, ST_SetSRID(ST_MakePoint(?, ?), 4326), ?)",
    #  type(^longitude, :float), type(^latitude, :float), type(^distance, :float)))
    # |> select([z], %{"id" => z.ogc_fid, "providerName" => "zayo", "name" => z.name, "distance" => fragment("ST_Distance(wkb_geometry :: GEOGRAPHY, ST_SetSRID(ST_MakePoint(?, ?), 4326)) AS distance",
    #  type(^longitude, :float), type(^latitude, :float))})
    # |> order_by(asc: fragment("distance"))
    # |> Repo.all
  end
end
