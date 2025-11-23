"""
Load Test - Comprehensive API testing with gradual ramp-up
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
test5 = Test(5, "PUT /posts/:id")
test6 = Test(6, "DELETE /posts/:id")
test7 = Test(7, "GET /users")
test8 = Test(8, "GET /todos")

# Base URL
BASE_URL = "https://jsonplaceholder.typicode.com"

# HTTP client setup
request = HTTPRequest()

class TestRunner:
    """Test runner class for load test"""

    def __call__(self):
        """Run load test scenario"""

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
        body = '{"title":"Load test ' + str(random.randint(1, 1000)) + '","body":"Testing under load","userId":' + str(user_id) + '}'
        request.POST(BASE_URL + "/posts", body, headers)
        grinder.sleep(300)

        # Test 5: PUT update post
        test5.record(request)
        post_id = random.randint(1, 100)
        body = '{"id":' + str(post_id) + ',"title":"Updated title","body":"Updated body","userId":1}'
        request.PUT(BASE_URL + "/posts/" + str(post_id), body, headers)
        grinder.sleep(300)

        # Test 6: DELETE post
        test6.record(request)
        post_id = random.randint(1, 100)
        request.DELETE(BASE_URL + "/posts/" + str(post_id))
        grinder.sleep(300)

        # Test 7: GET users
        test7.record(request)
        request.GET(BASE_URL + "/users")
        grinder.sleep(300)

        # Test 8: GET todos
        test8.record(request)
        request.GET(BASE_URL + "/todos")
        grinder.sleep(300)
