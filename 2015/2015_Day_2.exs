# input = "2x4x3\n1x1x10"

{:ok, input} = File.read('2015_Day_2_input.txt')

defmodule Santa do
  def product(tuple) do
    dimensions_tuple = case tuple do
      [a, b, c] -> [a * b, b * c, a * c]
    end
    Enum.concat(Enum.map(dimensions_tuple, (fn el -> el * 2 end)), [Enum.min(dimensions_tuple)])
  end

  def ribbon_product(tuple) do
    dimensions_tuple = case tuple do
      [_, _, _] -> Enum.sort(tuple, (fn a, b -> a > b end)) |> tl
    end
    Enum.concat(Enum.map(dimensions_tuple, (fn el -> el * 2 end)), [Enum.product(tuple)])
  end

  def parse_to_number(str) do
    Integer.parse(str) |> Tuple.to_list |> hd
  end

  def map_to_number(pack_data) do
    String.split(pack_data, "x") |> Enum.map(&Santa.parse_to_number/1) |> Santa.product |> Enum.sum
  end

  def ribbon_map_to_number(pack_data) do
    String.split(pack_data, "x") |> Enum.map(&Santa.parse_to_number/1) |> Santa.ribbon_product |> Enum.sum
  end
end

total_sum = String.split(String.trim_trailing(input), "\n") |> Enum.map(&Santa.map_to_number/1) |> Enum.sum
total_ribbon = String.split(String.trim_trailing(input), "\n") |> Enum.map(&Santa.ribbon_map_to_number/1) |> Enum.sum

IO.puts("Total wrapping paper in square feet: #{total_ribbon}")
IO.puts("Total ribbons length in feet: #{total_ribbon}")
