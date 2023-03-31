def detect_flag():
    try:
        with open('flag.txt') as f:
            return f.read().strip()
    except IOError:
        pass

    import os
    if 'FLAG' in os.environ:
        return os.environ['FLAG']

    return None


flag = detect_flag()
