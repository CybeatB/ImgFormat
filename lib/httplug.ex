defmodule ImgFormat.HTTPlug do
  use Plug.Router

  plug :match

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart],
    pass: ["text/*"]

  plug :dispatch

  get "/images" do
    send_file(conn, 200, System.get_env("WEB_ROOT") <> "/upload.html")
  end

  get "/images/:img" do
    send_resp(conn, 200, "#{img}\r\n")
  end

  post "/images" do
    IO.inspect conn.body_params
    send_file(conn, 200, System.get_env("WEB_ROOT") <> "/upload.html")
  end

  match _ do
    send_resp(conn, 404, "nothing here\r\n")
  end
end
