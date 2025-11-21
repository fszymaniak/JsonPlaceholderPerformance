"""
Common utilities and base classes for Locust tests
"""

from locust import HttpUser, task, between
import random


class JSONPlaceholderUser(HttpUser):
    """Base user class for JSONPlaceholder API tests"""

    host = "https://jsonplaceholder.typicode.com"

    def get_random_post_id(self):
        """Get a random post ID between 1 and 100"""
        return random.randint(1, 100)

    def get_random_user_id(self):
        """Get a random user ID between 1 and 10"""
        return random.randint(1, 10)

    def get_random_number(self):
        """Get a random number for unique data"""
        return random.randint(1, 1000)
