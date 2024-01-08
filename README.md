## About
This project consists of solutions to the 2 problems of tax calculation and domain utilities mentioned in the challenge.

Original code has been refactored into `DomainUtil` and `TaxUtil` modules for the sake of convenience.
Correspondingly, all improved code exists in v2 versions of these modules: `DomainUtilv2` and `TaxUtilv2`.

## Usage
To benchmark the problem solutions (both original and improved), run the corresponding code using the following commands:
- Change to the project directory.
- For problem - 1: `crystal run --release --no-debug ./src/mk_prob_1.cr`
- For problem - 2: `crystal run --release --no-debug ./src/mk_prob_2.cr`

## Comments (Problem - 1 - Tax calculation)
### Some obvious improvements
- Modify `BRACKETS` to use tuple instead of array and use symbols instead of strings. Tuples are present on stack instead of heap, so less expensive to access. Symbols make up for better keys compared to strings.
- Instead of zip -> reverse -> each. we can simply use a numbered loop. This will avoid intermediate data structures creation.
- Binary search instead of normal search also seemed an improvement, but it is not effective for small array/tuple sizes like in this case.

These changes give us a 7.4x improvement.

### Optimizing further
Since the goal is 100x or more, we need to be agressive. We can pre-compute taxes for all boundary values of a given bracket. So, to calculate tax of any income, we need to find its bracket, calculate the tax for the difference between the income and the boundary value. After this, we just have to calculate the tax on the boundary value, which we have already pre-computed. We just converted income tax calculation step from O(n) to a O(1) algorithm.

We have approached 30.3x improvement. Still far from 100x.

### Thinking further
The only problem that remains is that the index search is an O(n) algorithm. We tried binary search already, which is unfortunately not good enough for our use case. Upon closer inspection, we can observe that given an income value, we already know the answer regarding which index it falls in. So, we cheat. We write a function (some simple if-else statements) to calculate index for a given income value in O(1). There is a downside of course from a code maintainability perspective: if we modify the brackets in the future, we'll have to change these functions as well.

Finally 120x improvement!

## Comments (Problem - 2 - Domain name utilities)
While things work fine with `DomainUtil` on an older Linux machine, my Mac machine simply seems to hate it. Here are some problems I encountered:
- `myhtml` dependency didn't compile at all on my Mac.
- `HTTP::Client.get` works on Linux, but errors out on macOS, complaining about domain ceritificate verification failure.
