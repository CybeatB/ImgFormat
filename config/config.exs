import Config

config :img_format,
  ecto_repos: [ImgFormat.Repo]

config :img_format, ImgFormat.Repo,
  database: :memory
