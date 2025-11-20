"""
Load Test - Comprehensive API testing with gradual ramp-up
Target: 10-50 users, 7 minutes
"""

from locust import task, between
from common import JSONPlaceholderUser


class LoadTestUser(JSONPlaceholderUser):
    """Load test user behavior"""

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
            "title": f"Load test post {self.get_random_number()}",
            "body": "Testing under load",
            "userId": self.get_random_user_id()
        }
        self.client.post("/posts", json=payload)

    @task(2)
    def update_post(self):
        """PUT update a post"""
        post_id = self.get_random_post_id()
        payload = {
            "id": post_id,
            "title": "Updated title",
            "body": "Updated body",
            "userId": 1
        }
        self.client.put(f"/posts/{post_id}", json=payload)

    @task(2)
    def delete_post(self):
        """DELETE a post"""
        post_id = self.get_random_post_id()
        self.client.delete(f"/posts/{post_id}")

    @task(3)
    def get_users(self):
        """GET all users"""
        self.client.get("/users")

    @task(3)
    def get_todos(self):
        """GET all todos"""
        self.client.get("/todos")
