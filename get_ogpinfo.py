import argparse
import json
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlparse
from urllib.request import urlopen


class OGPParser(HTMLParser, json.JSONEncoder):
    def __init__(self, url, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._url = url
        self._og = {}

    def parse(self):
        with urlopen(self._url) as f:
            encoding = f.headers.get_content_charset()
            body = f.read()
        self.feed(body.decode(encoding or 'utf8'))
        self.close()

    def handle_starttag(self, tag, attrs):
        if tag != 'meta':
            return
        a = dict(attrs)
        prop = a.get('property', '')
        if not prop.startswith('og:'):
            return
        name = prop[3:]
        content = a.get('content')
        self._og[name] = content


class OGPJSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, OGPParser):
            return o._og
        return super().default(o)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('url', type=str, nargs=1)
    args = parser.parse_args()
    u = urlparse(args.url[0])
    ogp = OGPParser(u.geturl())
    ogp.parse()
    data_path = Path('data') / u.hostname / u.path[1:]
    data_path.mkdir(parents=True, exist_ok=True)
    with open(data_path / 'og.json', 'w') as f:
        json.dump(ogp, f, cls=OGPJSONEncoder)


if __name__ == '__main__':
    main()
