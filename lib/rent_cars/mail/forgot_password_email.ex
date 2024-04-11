defmodule RentCars.Mail.ForgotPasswordEmail do
  # use RentCarsWeb, :html
  require Logger
  alias RentCars.Mailer

  import Phoenix.Component

  defp email_layout(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <style>
          body {
            font-family: system-ui, sans-serif;
            margin: 3em auto;
            overflow-wrap: break-word;
            word-break: break-all;
            max-width: 1024px;
            padding: 0 1em;
          }
        </style>
      </head>
      
      <body>
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end

  def login_content(assigns) do
    ~H"""
    <.email_layout>
      <h1>Hey there <%= @first_name %>!</h1>
      
      <p>Please use this link to sign in to MyApp:</p>
       <a href={@url}><%= @url %></a>
      <p>If you didn't request this email, feel free to ignore this.</p>
    </.email_layout>
    """
  end

  def create_email(user, token) do
    url = "/sessions/reset_password?token=#{token}"

    template = login_content(%{first_name: user.first_name, url: url})
    html = heex_to_html(template)
    text = html_to_text(html)

    Swoosh.Email.new(
      to: {"Livebook Teams", user.email},
      from: {"Livebook Teams", "teams@livebook.dev"},
      subject: "reset password",
      html_body: html,
      text_body: text
    )

    # with {:ok, _metadata} <- Mailer.deliver(email) do
    #   {:ok, email}
    # end
  end

  def deliver(user, token) do
    Task.async(fn ->
      case Mailer.deliver(create_email(user, token)) do
        {:ok, _} ->
          {:ok, "email"}

        {:error, reason} ->
          Logger.warning("Sending email failed: #{inspect(reason)}")
          {:error, reason}
      end
    end)
  end

  defp heex_to_html(template) do
    template
    |> Phoenix.HTML.Safe.to_iodata()
    |> IO.iodata_to_binary()
  end

  defp html_to_text(html) do
    html
    |> Floki.parse_document!()
    |> Floki.find("body")
    |> Floki.text(sep: "\n\n")
  end
end
