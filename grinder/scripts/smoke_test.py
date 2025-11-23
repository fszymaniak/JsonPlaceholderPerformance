"""
Smoke Test - Quick validation with minimal load
The Grinder Jython script
"""

from net.grinder.script.Grinder import grinder
from net.grinder.script import Test
from net.grinder.plugin.http import HTTPRequest, HTTPPluginControl
from HTTPClient import NVPair
import random

# Test configuration
test1 = Test(1, "GET /posts")
test2 = Test(2, "GET /posts/1")
test3 = Test(3, "POST /posts")
test4 = Test(4, "GET /users")
test5 = Test(5, "GET /todos")

# Base URL
BASE_URL = "https://jsonplaceholder.typicode.com"

# HTTP client setup
request = HTTPRequest()
test1.record(request)

class TestRunner:
    """Test runner class"""

    def __call__(self):
        """Run smoke test scenario"""

        # Test 1: GET all posts
        test1.record(request)
        response = request.GET(BASE_URL + "/posts")
        if response.getStatusCode() == 200:
            grinder.logger.info("GET /posts: OK")
        grinder.sleep(500)

        # Test 2: GET single post
        test2.record(request)
        response = request.GET(BASE_URL + "/posts/1")
        if response.getStatusCode() == 200:
            grinder.logger.info("GET /posts/1: OK")
        grinder.sleep(500)

        # Test 3: POST create post
        test3.record(request)
        headers = [NVPair("Content-Type", "application/json")]
        body = '{"title":"Grinder smoke test","body":"Testing create endpoint","userId":1}'
        response = request.POST(BASE_URL + "/posts", body, headers)
        if response.getStatusCode() == 201:
            grinder.logger.info("POST /posts: OK")
        grinder.sleep(500)

        # Test 4: GET users
        test4.record(request)
        response = request.GET(BASE_URL + "/users")
        if response.getStatusCode() == 200:
            grinder.logger.info("GET /users: OK")
        grinder.sleep(500)

        # Test 5: GET todos
        test5.record(request)
        response = request.GET(BASE_URL + "/todos")
        if response.getStatusCode() == 200:
            grinder.logger.info("GET /todos: OK")
        grinder.sleep(500)
