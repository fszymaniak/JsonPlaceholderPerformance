import http from 'k6/http';
import { check, sleep } from 'k6';
import { Options } from 'k6/options';

// Soak Test Configuration - Extended duration to find memory leaks, degradation
export const options: Options = {
  stages: [
    { duration: '2m', target: 20 },   // Ramp up to moderate load
    { duration: '30m', target: 20 },  // Maintain for 30 minutes (extended test)
    { duration: '2m', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<1000'],  // Should stay consistent
    http_req_failed: ['rate<0.05'],     // Low error tolerance
  },
};

const BASE_URL = 'https://jsonplaceholder.typicode.com';

interface Post {
  title: string;
  body: string;
  userId: number;
}

export default function (): void {
  // Simulate realistic user behavior over extended period

  // User browses posts
  let response = http.get(`${BASE_URL}/posts`);
  check(response, {
    'browse posts - status 200': (r) => r.status === 200,
  });
  sleep(2);

  // User reads a specific post
  const postId: number = Math.floor(Math.random() * 100) + 1;
  response = http.get(`${BASE_URL}/posts/${postId}`);
  check(response, {
    'read post - status 200': (r) => r.status === 200,
  });
  sleep(3);

  // User checks comments
  response = http.get(`${BASE_URL}/posts/${postId}/comments`);
  check(response, {
    'read comments - status 200': (r) => r.status === 200,
  });
  sleep(2);

  // User creates a new post (less common action)
  if (Math.random() < 0.3) { // 30% of users create content
    const payload: Post = {
      title: `Soak test post ${Date.now()}`,
      body: 'Long running test content',
      userId: Math.floor(Math.random() * 10) + 1,
    };

    response = http.post(`${BASE_URL}/posts`, JSON.stringify(payload), {
      headers: { 'Content-Type': 'application/json' },
    });

    check(response, {
      'create post - status 201': (r) => r.status === 201,
    });
    sleep(2);
  }

  // User browses other content
  response = http.get(`${BASE_URL}/users`);
  check(response, {
    'browse users - status 200': (r) => r.status === 200,
  });
  sleep(3);
}
