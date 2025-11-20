"""
Stress Test - Push the system to its limits
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
test3 = Test(3, "POST /posts")

# Base URL
BASE_URL = "https://jsonplaceholder.typicode.com"

# HTTP client setup
request = HTTPRequest()

class TestRunner:
    """Test runner class for stress test"""

    def __call__(self):
        """Run stress test scenario"""

        # Test 1: GET all posts
        test1.record(request)
        request.GET(BASE_URL + "/posts")
        grinder.sleep(200)

        # Test 2: GET random post
        test2.record(request)
        post_id = random.randint(1, 100)
        request.GET(BASE_URL + "/posts/" + str(post_id))
        grinder.sleep(200)

        # Test 3: POST create post
        test3.record(request)
        headers = [NVPair("Content-Type", "application/json")]
        user_id = random.randint(1, 10)
        body = '{"title":"Stress test ' + str(random.randint(1, 1000)) + '","body":"Testing under high stress","userId":' + str(user_id) + '}'
        request.POST(BASE_URL + "/posts", body, headers)
        grinder.sleep(200)
