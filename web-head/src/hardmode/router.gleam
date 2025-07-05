import gleam/http
import gleam/json
import gleam/time/timestamp
import hardmode/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    // meta
    ["health"] -> health(req)

    // accounts
    // ["api", "v1", "accounts"] -> accounts(req)
    // ["api", "v1", "accounts", id] -> accounts_id(req, id)
    // auth
    // ["api", "v1", "auth", "login"] -> login(req)
    // ["api", "v1", "auth", "logout"] -> logout(req)
    // ["api", "v1", "auth", "refresh"] -> refresh(req)
    // ["api", "v1", "auth", "forgot-password"] -> forgot_password(req)
    // ["api", "v1", "auth", "reset-password"] -> reset_password(req)
    _ -> wisp.not_found()
  }
}

pub fn health(req: Request) -> Response {
  use <- wisp.require_method(req, http.Get)

  json.object([
    #("status", json.string("healthy")),
    #(
      "timestamp",
      json.int(
        timestamp.to_unix_seconds_and_nanoseconds(timestamp.system_time()).0,
      ),
    ),
  ])
  |> json.to_string_tree()
  |> wisp.json_response(200)
}
