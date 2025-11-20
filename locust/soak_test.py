"""
Soak Test - Extended duration test for memory leaks and degradation
Target: 20 users, 30 minutes
"""

from locust import task, between
from common import JSONPlaceholderUser


class SoakTestUser(JSONPlaceholderUser):
    """Soak test user behavior"""

    wait_time = between(0.3, 0.5)  # Wait 0.3-0.5 seconds between tasks

    @task(5)
    def get_all_posts(self):
        """GET all posts"""
        self.client.get("/posts")

    @task(10)
    def get_single_post(self):
        """GET a random single post"""
        post_id = self.get_random_post_id()
        self.client.get(f"/posts/{post_id}")

    @task(5)
    def get_post_comments(self):
        """GET comments for a random post"""
        post_id = self.get_random_post_id()
        self.client.get(f"/posts/{post_id}/comments")

    @task(3)
    def create_post(self):
        """POST create a new post"""
        payload = {
            "title": f"Soak test post {self.get_random_number()}",
            "body": "Testing for extended duration",
            "userId": self.get_random_user_id()
        }
        self.client.post("/posts", json=payload)
