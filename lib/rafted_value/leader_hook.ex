defmodule RaftedValue.LeaderHook do
  @moduledoc """
  TODO: Write something
  """

  alias RaftedValue.DataOps
  @type neglected :: any

  @callback on_command_committed(
    data_before_command :: DataOps.data,
    command_arg         :: DataOps.command_arg,
    command_return      :: DataOps.ret,
    data_after_command  :: DataOps.data) :: neglected
  @callback on_follower_added(pid)       :: neglected
  @callback on_follower_removed(pid)     :: neglected
  @callback on_elected                   :: neglected
end

defmodule RaftedValue.LeaderHook.NoOp do
  @behaviour RaftedValue.LeaderHook
  def on_command_committed(_, _, _, _), do: nil
  def on_follower_added(_), do: nil
  def on_follower_removed(_), do: nil
  def on_elected, do: nil
end