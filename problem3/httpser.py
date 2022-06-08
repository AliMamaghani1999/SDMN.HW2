import sys
import json
import os
from http.server import HTTPServer, SimpleHTTPRequestHandler


HOST_NAME = "localhost"
PORT = 8000

class PythonServer(SimpleHTTPRequestHandler):
    
    def do_GET(self):
        if self.path == '/api/v1/status':
            print("get")
            self.send_response(200)
            self.end_headers()
            f = open('api/v1/status/default.json')
            data = json.load(f)
            f.close()
            self.wfile.write(json.dumps(data, indent=2).encode())


    def do_POST(self):
        if self.path == '/api/v1/status':
            print("post")
            post_body = self.rfile.read(int(self.headers['Content-Length']))
            data=json.loads(post_body)
            print(data)
            with open('api/v1/status/default.json', 'w') as outfile: 
                outfile.write(json.dumps(data, indent = 4))
            self.send_response(201)
            self.end_headers()
ddirectory = "api/v1/status"
try :
    os.makedirs(ddirectory)
except :
    pass

with open('api/v1/status/default.json', 'w') as outfile: 
    outfile.write(json.dumps({'status': 'OK'}, indent = 4))
if __name__ == "__main__":
    server = HTTPServer((HOST_NAME, PORT), PythonServer)
    print(f"Server started http://{HOST_NAME}:{PORT}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.server_close()
        print("Server stopped successfully")
        sys.exit(0)
