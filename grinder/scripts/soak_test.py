"""
Soak Test - Extended duration test for memory leaks and degradation
The Grinder Jython script
"""

from net.grinder.script.Grinder import grinder
from net.grinder.script import Test
from net.grinder.plugin.http import HTTPRequest
from HTTPClient import NVPair
import random

# Test configuration
test1 = Test(1, "GET /posts")
test2 = Test(2, "GET /posts/:id")
test3 = Test(3, "GET /posts/:id/comments")
test4 = Test(4, "POST /posts")

# Base URL
BASE_URL = "https://jsonplaceholder.typicode.com"

# HTTP client setup
request = HTTPRequest()

class TestRunner:
    """Test runner class for soak test"""

    def __call__(self):
        """Run soak test scenario"""

        # Test 1: GET all posts
        test1.record(request)
        request.GET(BASE_URL + "/posts")
        grinder.sleep(300)

        # Test 2: GET random post
        test2.record(request)
        post_id = random.randint(1, 100)
        request.GET(BASE_URL + "/posts/" + str(post_id))
        grinder.sleep(300)

        # Test 3: GET post comments
        test3.record(request)
        post_id = random.randint(1, 100)
        request.GET(BASE_URL + "/posts/" + str(post_id) + "/comments")
        grinder.sleep(300)

        # Test 4: POST create post
        test4.record(request)
        headers = [NVPair("Content-Type", "application/json")]
        user_id = random.randint(1, 10)
        body = '{"title":"Soak test ' + str(random.randint(1, 1000)) + '","body":"Testing for extended duration","userId":' + str(user_id) + '}'
        request.POST(BASE_URL + "/posts", body, headers)
        grinder.sleep(300)
