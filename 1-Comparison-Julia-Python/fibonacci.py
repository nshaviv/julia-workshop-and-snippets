import time
from functools import cache

def fib(n):
    if n <= 1:
        return n
    return fib(n - 1) + fib(n - 2)


def main(test_times=50):
    start = time.time()
    for _ in range(test_times):
        fib(30)
    print(f"Total time spent: {time.time() - start} s")

main()
