# -*- coding: utf-8 -*-
import BaseHTTPServer
import urllib2
import cookielib

class ProxyHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        self.cookie_jar = cookielib.CookieJar()
        self.opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(self.cookie_jar))
        BaseHTTPServer.BaseHTTPRequestHandler.__init__(self, *args, **kwargs)

    def do_GET(self):
        try:
            target_url = 'http://localhost:21000' + self.path
            req = urllib2.Request(target_url)
            
            for header_name, header_value in self.headers.items():
                if header_name.lower() not in ['host', 'connection']:
                    req.add_header(header_name, header_value)
            
            response = self.opener.open(req)
            content = response.read()
            
            self.send_response(response.getcode())
            
            for header, value in response.info().items():
                if header.lower() not in ['x-frame-options', 'content-security-policy', 'transfer-encoding']:
                    self.send_header(header, value)
            
            self.end_headers()
            self.wfile.write(content)
            
        except urllib2.HTTPError as e:
            self.send_response(e.code)
            for header, value in e.info().items():
                if header.lower() not in ['x-frame-options', 'content-security-policy', 'transfer-encoding']:
                    self.send_header(header, value)
            self.end_headers()
            content = e.read()
            if content:
                self.wfile.write(content)
                
        except Exception as e:
            self.send_response(500)
            self.send_header('Content-Type', 'text/plain')
            self.end_headers()
            self.wfile.write(str(e))

    def do_POST(self):
        try:
            content_length = int(self.headers.get('Content-Length', 0))
            post_data = self.rfile.read(content_length)
            
            target_url = 'http://localhost:21000' + self.path
            req = urllib2.Request(target_url, data=post_data)
            
            for header_name, header_value in self.headers.items():
                if header_name.lower() not in ['host', 'connection']:
                    req.add_header(header_name, header_value)
            
            response = self.opener.open(req)
            content = response.read()
            
            self.send_response(response.getcode())
            for header, value in response.info().items():
                if header.lower() not in ['x-frame-options', 'content-security-policy', 'transfer-encoding']:
                    self.send_header(header, value)
            self.end_headers()
            self.wfile.write(content)
            
        except urllib2.HTTPError as e:
            self.send_response(e.code)
            for header, value in e.info().items():
                if header.lower() not in ['x-frame-options', 'content-security-policy', 'transfer-encoding']:
                    self.send_header(header, value)
            self.end_headers()
            content = e.read()
            if content:
                self.wfile.write(content)

server = BaseHTTPServer.HTTPServer(('0.0.0.0', 8502), ProxyHandler)
print "Atlas proxy running on port 8502"
print "Access at: http://localhost:8502"
server.serve_forever()
