#!/usr/bin/env python3
"""mock-registry.py -- a static registry host with the behaviors a real
server adds over `python3 -m http.server` (registry-p3-protocol.md §2).

What it simulates, so the P3 client can be exercised end to end before a
real registry exists (point mcc at http://127.0.0.1:<port>; when the real
server lands, only the URL changes):

  * ETag on every 200 (sha1 of the bytes) and If-None-Match -> 304 --
    the client's conditional metadata arm, untestable against
    python3 -m http.server (which never sends ETags);
  * --fail-500 PREFIX  -> any path under PREFIX answers 500 (the named
    transport-error face: the client must fail loudly, never hang);
  * --truncate-at N    -> /dl/ bodies are cut to N bytes (checksum-verify
    face: a truncated artifact must never land under its real name).

Every request is appended to the access log as "GET <path> <status>"
(--log FILE, else stdout), so a driver can assert e.g. that a 304 was
actually served. Prints "MOCK port <N>" on stdout once listening.

Usage:
  mock-registry.py --root DIR [--bind ADDR] [--port N] [--log FILE]
                   [--fail-500 PREFIX] [--truncate-at N]
"""

import argparse
import hashlib
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

ARGS = None  # wired in main()


class Handler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def log_message(self, fmt, *args):  # default stderr chatter off; the access log is the record
        pass

    def clean_path(self):
        return self.path.split("?", 1)[0].split("#", 1)[0].lstrip("/")

    def access(self, status):
        line = "%s %s %s" % (self.command, self.clean_path(), status)
        if ARGS.log:
            with open(ARGS.log, "a") as f:
                f.write(line + "\n")
        else:
            print(line, flush=True)

    def do_GET(self):
        p = self.clean_path()
        if ARGS.fail_500 and p.startswith(ARGS.fail_500):
            self.access(500)
            self.send_error(500, "injected fault")
            return
        fpath = os.path.join(ARGS.root, p)
        if not os.path.isfile(fpath):
            self.access(404)
            self.send_error(404, "not found")
            return
        with open(fpath, "rb") as f:
            body = f.read()
        etag = '"%s"' % hashlib.sha1(body).hexdigest()
        if self.headers.get("If-None-Match") == etag:
            # 304 carries no body; the client falls back to its cached copy.
            self.access(304)
            self.send_response(304)
            self.send_header("ETag", etag)
            self.end_headers()
            return
        if ARGS.truncate_at and p.startswith("dl/"):
            body = body[: ARGS.truncate_at]
        self.access(200)
        self.send_response(200)
        self.send_header("ETag", etag)
        self.send_header(
            "Content-Type",
            "application/json" if p.endswith(".json") else "application/octet-stream",
        )
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def main():
    global ARGS
    ap = argparse.ArgumentParser(description="static registry mock with ETag/304 and fault injection")
    ap.add_argument("--root", required=True, help="registry tree directory (mkregistry.sh output)")
    ap.add_argument("--bind", default="127.0.0.1")
    ap.add_argument("--port", type=int, default=0)
    ap.add_argument("--log", help="access log file (default: stdout)")
    ap.add_argument("--fail-500", help="answer 500 for paths under this prefix")
    ap.add_argument("--truncate-at", type=int, help="truncate /dl/ bodies to N bytes")
    ARGS = ap.parse_args()
    srv = ThreadingHTTPServer((ARGS.bind, ARGS.port), Handler)
    print("MOCK port %d" % srv.server_address[1], flush=True)
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
