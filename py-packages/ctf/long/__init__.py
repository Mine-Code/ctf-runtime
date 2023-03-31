import math


def long_to_bytes(n: int) -> bytes:
    length = math.ceil(n.bit_length() / 8)
    return n.to_bytes(length, 'big')


def bytes_to_long(b: bytes) -> int:
    return int.from_bytes(b, 'big')
