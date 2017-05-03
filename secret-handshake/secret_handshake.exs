defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    _commands(code, [])
  end

  use Bitwise

  defp _commands(code, out) when (code &&& 0b1000) == 0b1000 do
    _commands(code - 0b1000, ["jump" | out])
  end

  defp _commands(code, out) when (code &&& 0b100) == 0b100 do
    _commands(code - 0b100, ["close your eyes" | out])
  end

  defp _commands(code, out) when (code &&& 0b10) == 0b10 do
    _commands(code - 0b10, ["double blink" | out])
  end

  defp _commands(code, out) when (code &&& 0b1) == 0b1 do
    _commands(code - 0b1, ["wink" | out])
  end

  defp _commands(code, out) when (code &&& 0b10000) == 0b10000 do
    _commands(code - 0b10000, Enum.reverse(out))
  end
  
  defp _commands(code, out) when code <= 0 do
    out
  end
end
