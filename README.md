# Prime Table

A CLI to generate a multiplication table of prime numbers and print them to the console.

```
"
Sift the Two's and Sift the Three's,
The Sieve of Eratosthenes.
When the multiples sublime,
The numbers that remain are Prime.
"
```

Screenshot of first 10 prime numbers:

```
|   |  2|  3|  5|  7| 11| 13| 17| 19| 23| 29|
|  2|  4|  6| 10| 14| 22| 26| 34| 38| 46| 58|
|  3|  6|  9| 15| 21| 33| 39| 51| 57| 69| 87|
|  5| 10| 15| 25| 35| 55| 65| 85| 95|115|145|
|  7| 14| 21| 35| 49| 77| 91|119|133|161|203|
| 11| 22| 33| 55| 77|121|143|187|209|253|319|
| 13| 26| 39| 65| 91|143|169|221|247|299|377|
| 17| 34| 51| 85|119|187|221|289|323|391|493|
| 19| 38| 57| 95|133|209|247|323|361|437|551|
| 23| 46| 69|115|161|253|299|391|437|529|667|
| 29| 58| 87|145|203|319|377|493|551|667|841|
```

## How to run it:

Clone the repo:

```
git clone git@github.com:hoodsuphopeshigh/prime_table.git
```

Fetch the dependencies and compile them:

```
mix deps.get && mix deps.compile
```

Run the test suite with:

```
mix test
```

Run the test coverage with:

```
MIX_ENV=test mix coveralls
```

Generate a binary with:

```
mix escript.build
```

Run the application with:

```
./prime_table <NUMBER>
```

For help run the binary with no arguments:

```
./prime_table
```

To run as an interactive session run:

```
iex -S mix
```

## What I am pleased with:

I am really pleased with the sieve. I spent a lot of time playing with two variations:

* [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
* [Sieve of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin)

before opting to implement the Sieve of Eratosthenes.

I spent time looking at how to optimize it and discovered a lot of cool things that helped performance:

* Every prime number except 2 is odd, this reduces the amount of numbers to iterate over.
* MapSets are the best approach on removing a list of values from another list. This includes the overhead of converting into / out of MapSets.



## What I would do if I had more time:

I would implement other approaches for removing a list of elements from another list for smaller values.
There are more performant approaches for smaller values these would include adding the following:

* `a -- b` for prime numbers < 100
* `` for prime numbers < 1000

Before using the MapSet approach for prime numbers >= 1000.

I would also neaten up the table formatting.
My biggest bug bear is how I am finding the largest value in order to correctly pad each value.

I was torn between two approaches, either:

* Iterate over the list twice to get the last value and use its length
* Take the last value of the first row of the matrix, multiply this, and use the results length.

I opted for option one, it's crude and involves two passes over a list, but the second pass is magnitudes smaller than the first.
