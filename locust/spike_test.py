"""
Spike Test - Test sudden traffic surges
Custom load shape: normal (5 users) -> spike (150 users) -> recovery -> spike -> recovery
"""

from locust import task, between, LoadTestShape
from common import JSONPlaceholderUser


class SpikeTestUser(JSONPlaceholderUser):
    """Spike test user behavior"""

    wait_time = between(0.2, 0.4)

    @task(10)
    def get_all_posts(self):
        """GET all posts"""
        self.client.get("/posts")

    @task(15)
    def get_single_post(self):
        """GET a random single post"""
        post_id = self.get_random_post_id()
        self.client.get(f"/posts/{post_id}")


class SpikeLoadShape(LoadTestShape):
    """
    Custom load shape for spike testing
    Stages: normal -> spike -> recovery -> spike -> recovery
    """

    stages = [
        {"duration": 120, "users": 5, "spawn_rate": 1},    # 2 min: normal load (5 users)
        {"duration": 180, "users": 150, "spawn_rate": 30}, # 1 min: sudden spike (150 users)
        {"duration": 300, "users": 5, "spawn_rate": 10},   # 2 min: recovery (5 users)
        {"duration": 360, "users": 150, "spawn_rate": 30}, # 1 min: another spike (150 users)
        {"duration": 480, "users": 5, "spawn_rate": 10},   # 2 min: final recovery (5 users)
    ]

    def tick(self):
        """
        Returns a tuple (user_count, spawn_rate) or None to stop
        """
        run_time = self.get_run_time()

        for stage in self.stages:
            if run_time < stage["duration"]:
                return (stage["users"], stage["spawn_rate"])

        return None  # Stop test after all stages
