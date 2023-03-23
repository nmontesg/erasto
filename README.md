# Erastothenes

Agent-based implementation of the sieve of Erastothenes algorithm to find all
the prime numbers below an input threshold.

In this algorithm, the sequence of number between 2 and some threshold $th$ are
sequentially filtered out if they are found to be divisible by the smallest
number remaining in the sequence.

In this agent-based implementation, every agent is responsible for filtering the
sequence of integers, received from a ``parent agent'', according to its
filter parameter. The first time an agent receives an integer that is not
divisible by its filter, it announces that the input integer is prime and
creates its child agent to filter subsequent numbers by this new prime. When an
agent has processed the last integer, it terminates itself to liberate
resources. This example illustrates in particular the use of custom KQML
performatives.

## References

[Sieve of Erastothenes on Wikipedia](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
