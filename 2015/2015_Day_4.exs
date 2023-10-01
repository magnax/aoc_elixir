natural_numbers = Stream.iterate(1, &(&1 + 1))

defmodule Santa do
  def hash(string) do
   Base.encode16(:crypto.hash(:md5, string))
    
  end

  def iterate(numbers, seed, expected) do
    numbers
    |> Enum.reduce_while(0, (fn x, _acc ->
      hash = Santa.hash("#{seed}#{x}")
      if String.starts_with?(hash, expected) do
        {:halt, "Number: #{x}, hash: #{hash}"}
      else
        {:cont, x}
      end
    end)
    )
  end
end

IO.puts Santa.iterate(natural_numbers, "ckczppom", "00000")
