use Croma

defmodule RaftedValue.Snapshot do
  alias RaftedValue.{Members, TermNumber, LogEntry, Config, CommandResults}
  alias RaftedValue.RPC.InstallSnapshot

  use Croma.Struct, fields: [
    members:              Members,
    term:                 TermNumber,
    last_committed_entry: LogEntry,
    config:               Config,
    data:                 Croma.Any,
    command_results:      CommandResults,
  ]

  defun from_install_snapshot(is :: InstallSnapshot.t) :: t do
    Map.put(is, :__struct__, __MODULE__)
  end

  defun encode(snapshot :: Snapshot.t) :: binary do
    :erlang.term_to_binary(snapshot) |> :zlib.gzip()
  end

  defun decode(bin :: binary) :: Snapshot.t do
    :zlib.gunzip(bin) |> :erlang.binary_to_term()
  end
end
