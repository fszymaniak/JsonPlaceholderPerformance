"""
Spike Test - Test sudden traffic surges
The Grinder Jython script
Note: Spike pattern is controlled by ramping threads in properties file
"""

from net.grinder.script.Grinder import grinder
from net.grinder.script import Test
from net.grinder.plugin.http import HTTPRequest
import random

# Test configuration
test1 = Test(1, "GET /posts")
test2 = Test(2, "GET /posts/:id")

# Base URL
BASE_URL = "https://jsonplaceholder.typicode.com"

# HTTP client setup
request = HTTPRequest()

class TestRunner:
    """Test runner class for spike test"""

    def __call__(self):
        """Run spike test scenario"""

        # Test 1: GET all posts
        test1.record(request)
        request.GET(BASE_URL + "/posts")
        grinder.sleep(200)

        # Test 2: GET random post
        test2.record(request)
        post_id = random.randint(1, 100)
        request.GET(BASE_URL + "/posts/" + str(post_id))
        grinder.sleep(200)
