def ex_gcd(a, b):
    x, y, u, v = 0, 1, 1, 0
    while a != 0:
        q, r = b // a, b % a
        m, n = x - u * q, y - v * q
        b, a, x, y, u, v = a, r, u, v, m, n
    return x, y, b


def inv(a, m):
    x, y, q = ex_gcd(a, m)
    if q != 1:
        return None
    else:
        return x % m
