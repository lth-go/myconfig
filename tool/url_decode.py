#!python3

import sys
from urllib import parse
from pprint import pprint


def main():
    url = sys.argv[1]
    result = dict(parse.parse_qsl(url))

    pprint(result)


if __name__ == '__main__':
    main()
