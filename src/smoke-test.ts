import http from 'k6/http';
import { check, sleep } from 'k6';
import { Options } from 'k6/options';

// Smoke Test Configuration - Quick validation with minimal load
export const options: Options = {
  vus: 1,              // 1 virtual user
  duration: '30s',     // Run for 30 seconds
  thresholds: {
    http_req_duration: ['p(95)<1000'], // 95% should be under 1s
    http_req_failed: ['rate<0.01'],    // Less than 1% errors
  },
};

const BASE_URL = 'https://jsonplaceholder.typicode.com';

interface Post {
  id?: number;
  title: string;
  body: string;
  userId: number;
}

export default function (): void {
  // Test 1: GET all posts
  let response = http.get(`${BASE_URL}/posts`);
  check(response, {
    'GET /posts - status 200': (r) => r.status === 200,
    'GET /posts - has data': (r) => r.json() && Array.isArray(r.json()) && (r.json() as Post[]).length > 0,
  });
  sleep(1);

  // Test 2: GET single post
  response = http.get(`${BASE_URL}/posts/1`);
  check(response, {
    'GET /posts/1 - status 200': (r) => r.status === 200,
    'GET /posts/1 - has title': (r) => (r.json() as Post).title !== undefined,
  });
  sleep(1);

  // Test 3: POST create
  const createPayload: Post = {
    title: 'Smoke test post',
    body: 'Testing create endpoint',
    userId: 1,
  };

  response = http.post(`${BASE_URL}/posts`, JSON.stringify(createPayload), {
    headers: { 'Content-Type': 'application/json' },
  });
  check(response, {
    'POST /posts - status 201': (r) => r.status === 201,
    'POST /posts - returns id': (r) => (r.json() as Post).id !== undefined,
  });
  sleep(1);

  // Test 4: GET users
  response = http.get(`${BASE_URL}/users`);
  check(response, {
    'GET /users - status 200': (r) => r.status === 200,
  });
  sleep(1);

  // Test 5: GET todos
  response = http.get(`${BASE_URL}/todos`);
  check(response, {
    'GET /todos - status 200': (r) => r.status === 200,
  });
  sleep(1);
}
