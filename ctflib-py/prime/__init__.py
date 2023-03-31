import random


def is_prime(q, k=50):
    q = abs(q)

    if q == 2:
        return True
    if q < 2 or q & 1 == 0:
        return False

    d = (q-1) >> 1
    while d & 1 == 0:
        d >>= 1

    for _ in range(k):
        a = random.randint(1, q-1)
        t = d
        y = pow(a, t, q)

        while t != q-1 and y != 1 and y != q-1:
            y = pow(y, 2, q)
            t <<= 1

        if y != q-1 and t & 1 == 0:
            return False
    return True


def gen_prime(bits=128):
    while True:
        prime = random.getrandbits(bits) | 1 << (bits-1) | 1
        if is_prime(prime):
            return prime
