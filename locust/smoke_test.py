"""
Smoke Test - Quick validation with minimal load
Target: 1 user, 30 seconds
"""

from locust import task, between
from common import JSONPlaceholderUser


class SmokeTestUser(JSONPlaceholderUser):
    """Smoke test user behavior"""

    wait_time = between(0.5, 1.0)  # Wait 0.5-1.0 seconds between tasks

    @task(3)
    def get_all_posts(self):
        """GET all posts"""
        with self.client.get("/posts", catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")

    @task(2)
    def get_single_post(self):
        """GET a single post"""
        with self.client.get("/posts/1", catch_response=True) as response:
            if response.status_code == 200 and "title" in response.json():
                response.success()
            else:
                response.failure("Missing required fields")

    @task(1)
    def create_post(self):
        """POST create a new post"""
        payload = {
            "title": "Locust smoke test",
            "body": "Testing create endpoint",
            "userId": 1
        }
        with self.client.post("/posts", json=payload, catch_response=True) as response:
            if response.status_code == 201 and "id" in response.json():
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")

    @task(2)
    def get_users(self):
        """GET all users"""
        self.client.get("/users")

    @task(2)
    def get_todos(self):
        """GET all todos"""
        self.client.get("/todos")
