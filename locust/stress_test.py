"""
Stress Test - Push the system to its limits
Target: 50-150 users, 14 minutes
"""

from locust import task, between
from common import JSONPlaceholderUser


class StressTestUser(JSONPlaceholderUser):
    """Stress test user behavior"""

    wait_time = between(0.1, 0.3)  # Wait 0.1-0.3 seconds between tasks

    @task(10)
    def get_all_posts(self):
        """GET all posts"""
        self.client.get("/posts")

    @task(15)
    def get_single_post(self):
        """GET a random single post"""
        post_id = self.get_random_post_id()
        self.client.get(f"/posts/{post_id}")

    @task(5)
    def create_post(self):
        """POST create a new post"""
        payload = {
            "title": f"Stress test post {self.get_random_number()}",
            "body": "Testing under high stress",
            "userId": self.get_random_user_id()
        }
        self.client.post("/posts", json=payload)
