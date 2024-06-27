defmodule ImgFormat do
  @moduledoc """
  Documentation for `ImgFormat`.
  """

  def start(_type, _args) do
    port = String.to_integer(System.get_env("IMGFORMAT_PORT"))
    children = [
      # ImgFormat.HTTP is a hand-crafted server for educational purposes only.
      #{Task.Supervisor, name: ImgFormat.TaskSupervisor},
      #Supervisor.child_spec(
      #  {Task, fn -> ImgFormat.HTTP.accept(port) end},
      #  restart: :permanent
      #)
      {Bandit, plug: ImgFormat.HTTPlug, port: port},
      ImgFormat.Repo
    ]

    opts = [
      strategy: :one_for_one,
      name: ImgFormat.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end

  def hello do
    :world
  end
end
