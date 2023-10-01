IO.puts "Advent of Code 2015, Day 3"

#input = "^v"
#input = "^>v<"
#input = "^>v<v<^>^<v>"
#input = "^v^v^v^v^v"

{ :ok, input } = File.read("2015_Day_3_input.txt")

defmodule Santa do
  def letter_to_coords(letter) do
    case letter do
      ">" -> [1, 0]
      "<" -> [-1, 0]
      "^" -> [0, 1]
      "v" -> [0, -1]
      _ -> [0, 0]
    end
  end

  def directions_to_coords(enum) do
    Enum.scan(
      enum, 
      (fn el, acc ->
        [a, b] = el
        [aa, bb] = acc
        [a + aa, b + bb]
      end)
    )
  end

  def filter(enum) do
    Enum.filter(enum, fn el -> el != nil end)
  end

  def string_to_directions(string, par) do
    Enum.with_index(
      String.graphemes(string),
      (fn el, i ->
        if rem(i, 2) == par do Santa.letter_to_coords(el) else nil end
      end)
    )
  end

  def string_to_directions(string) do
    Enum.map(String.graphemes(string), &Santa.letter_to_coords/1)
  end
end

new_santa_enum = Enum.concat([[0, 0]], Santa.string_to_directions(input, 0)) |> Santa.filter |> Santa.directions_to_coords
new_robo_enum = Enum.concat([[0, 0]], Santa.string_to_directions(input, 1)) |> Santa.filter |> Santa.directions_to_coords

new_enum = Enum.concat([[0, 0]], Santa.string_to_directions(input)) |> Santa.directions_to_coords

unique = Enum.uniq(new_enum)

IO.puts "Number of steps in instructions: #{Enum.count(new_enum)}"
IO.puts "Number of houses visited: #{Enum.count(unique)}"
IO.puts "Number of houses visited by Santa and RoboSanta: #{Enum.count(Enum.uniq(Enum.concat(new_santa_enum, new_robo_enum)))}"
