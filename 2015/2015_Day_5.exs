IO.puts "2015 Day 15, part 1"

#input = "ugknbfddgicrmopn\naaa\njchzalrnumimnmhp\nhaegwjzuvuyypxyu\ndvszwmarrgswjxmb"
{:ok, input} = File.read("2015_Day_5_input.txt")

defmodule Santa do
  def has_3_vowels?(string) do
    (string
    |> String.graphemes
    |> Enum.filter(fn el -> String.contains?("aeiou", el) end)
    |> Enum.count)
      >= 3
  end

  def does_not_contains_bad_things?(string) do
    (["ab", "cd", "pq", "xy"]
    |> Enum.filter(fn el -> String.contains?(string, el) end)
    |> Enum.count) == 0
  end

  def has_double_letters?(string) do
    (string
    |> String.graphemes
    |> Enum.scan(false, (fn el, acc -> if el === acc do true else el end end))
    |> Enum.filter(fn el -> el == true end)
    |> Enum.count) > 0
  end

  def has_two_pairs?(string) do
    string
    |> String.match?(~r/(.{2}).*\1/)
  end

  def has_one_letter_repeating?(string) do
    string
    |> String.match?(~r/(.).\1/)
  end

  def nice?(string) do
    Santa.has_3_vowels?(string) 
    && Santa.does_not_contains_bad_things?(string)
    && Santa.has_double_letters?(string)
  end

  def nice_2?(string) do
    Santa.has_two_pairs?(string)
    && Santa.has_one_letter_repeating?(string)
  end

  def nice_count(string, nice_fn) do
    string
    |> String.split("\n")
    |> Enum.map(nice_fn)
    |> Enum.filter(fn el -> el == true end)
    |> Enum.count
  end
end

Santa.nice_count(input, &Santa.nice?/1) |> IO.puts

Santa.nice_count(input, &Santa.nice_2?/1) |> IO.puts
