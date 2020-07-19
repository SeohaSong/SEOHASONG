import http.server
import ssl

httpd = http.server.HTTPServer(('0.0.0.0', 5443), http.server.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket, certfile='mycert.pem', keyfile='mycert.key')
httpd.serve_forever()

# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mycert.key -out mycert.pem
