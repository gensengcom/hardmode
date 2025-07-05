import gleam/erlang/process
import hardmode/router
import mist
import wisp
import wisp/wisp_mist

pub fn main() {
  wisp.configure_logger()

  // TODO: load this from somewhere so that it is not regenerated on every restart.
  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    wisp_mist.handler(router.handle_request, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start

  process.sleep_forever()
}
