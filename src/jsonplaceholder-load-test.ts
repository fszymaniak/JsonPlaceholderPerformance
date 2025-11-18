import http from 'k6/http';
import { check, group, sleep } from 'k6';
import { Rate } from 'k6/metrics';
import { Options } from 'k6/options';
import { RefinedResponse, ResponseType } from 'k6/http';

// Custom metrics
const errorRate = new Rate('errors');

// Test configuration
export const options: Options = {
  stages: [
    { duration: '20s', target: 10 },  // Ramp-up to 10 users
    { duration: '40s', target: 10 },  // Stay at 10 users
    { duration: '20s', target: 20 },  // Ramp-up to 20 users
    { duration: '40s', target: 20 },  // Stay at 20 users
    { duration: '20s', target: 0 },   // Ramp-down to 0 users
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests should be below 500ms
    http_req_failed: ['rate<0.1'],    // Error rate should be less than 10%
    errors: ['rate<0.1'],              // Custom error rate threshold
  },
};

const BASE_URL = 'https://jsonplaceholder.typicode.com';

interface Post {
  id?: number;
  title: string;
  body: string;
  userId: number;
}

interface Comment {
  id?: number;
  postId: number;
  name: string;
  email: string;
  body: string;
}

interface User {
  id?: number;
  name: string;
  username: string;
  email: string;
}

interface Todo {
  id?: number;
  userId: number;
  title: string;
  completed: boolean;
}

interface Album {
  id?: number;
  userId: number;
  title: string;
}

// Helper function to generate random data
function getRandomInt(min: number, max: number): number {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Test 1: GET all posts
export function testGetAllPosts(): void {
  const response: RefinedResponse<ResponseType> = http.get(`${BASE_URL}/posts`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response has posts': (r) => Array.isArray(r.json()) && (r.json() as Post[]).length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
}

// Test 2: GET single post
export function testGetSinglePost(): void {
  const postId: number = getRandomInt(1, 100);
  const response: RefinedResponse<ResponseType> = http.get(`${BASE_URL}/posts/${postId}`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'post has id': (r) => (r.json() as Post).id !== undefined,
    'post has title': (r) => (r.json() as Post).title !== undefined,
    'response time < 300ms': (r) => r.timings.duration < 300,
  });

  errorRate.add(!success);
}

// Test 3: GET comments for a post
export function testGetPostComments(): void {
  const postId: number = getRandomInt(1, 100);
  const response: RefinedResponse<ResponseType> = http.get(`${BASE_URL}/posts/${postId}/comments`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has comments': (r) => Array.isArray(r.json()) && (r.json() as Comment[]).length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
}

// Test 4: POST create new post
export function testCreatePost(): void {
  const payload: Post = {
    title: `Test Post ${Date.now()}`,
    body: 'This is a test post created by k6 performance testing',
    userId: getRandomInt(1, 10),
  };

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const response: RefinedResponse<ResponseType> = http.post(
    `${BASE_URL}/posts`,
    JSON.stringify(payload),
    params
  );

  const success = check(response, {
    'status is 201': (r) => r.status === 201,
    'response has id': (r) => (r.json() as Post).id !== undefined,
    'response time < 600ms': (r) => r.timings.duration < 600,
  });

  errorRate.add(!success);
}

// Test 5: PUT update post
export function testUpdatePost(): void {
  const postId: number = getRandomInt(1, 100);
  const payload: Post = {
    id: postId,
    title: `Updated Post ${Date.now()}`,
    body: 'This post has been updated by k6',
    userId: 1,
  };

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const response: RefinedResponse<ResponseType> = http.put(
    `${BASE_URL}/posts/${postId}`,
    JSON.stringify(payload),
    params
  );

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'id matches': (r) => (r.json() as Post).id === postId,
    'response time < 600ms': (r) => r.timings.duration < 600,
  });

  errorRate.add(!success);
}

// Test 6: PATCH partial update
export function testPatchPost(): void {
  const postId: number = getRandomInt(1, 100);
  const payload = {
    title: `Patched Title ${Date.now()}`,
  };

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const response: RefinedResponse<ResponseType> = http.patch(
    `${BASE_URL}/posts/${postId}`,
    JSON.stringify(payload),
    params
  );

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 600ms': (r) => r.timings.duration < 600,
  });

  errorRate.add(!success);
}

// Test 7: DELETE post
export function testDeletePost(): void {
  const postId: number = getRandomInt(1, 100);
  const response: RefinedResponse<ResponseType> = http.del(`${BASE_URL}/posts/${postId}`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
}

// Test 8: GET users
export function testGetUsers(): void {
  const response: RefinedResponse<ResponseType> = http.get(`${BASE_URL}/users`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has users': (r) => Array.isArray(r.json()) && (r.json() as User[]).length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
}

// Test 9: GET todos
export function testGetTodos(): void {
  const response: RefinedResponse<ResponseType> = http.get(`${BASE_URL}/todos`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has todos': (r) => Array.isArray(r.json()) && (r.json() as Todo[]).length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
}

// Test 10: GET albums
export function testGetAlbums(): void {
  const response: RefinedResponse<ResponseType> = http.get(`${BASE_URL}/albums`);

  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has albums': (r) => Array.isArray(r.json()) && (r.json() as Album[]).length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
}

// Main test function - executes all test scenarios
export default function (): void {
  group('Posts API Tests', () => {
    testGetAllPosts();
    sleep(0.3);

    testGetSinglePost();
    sleep(0.3);

    testGetPostComments();
    sleep(0.3);

    testCreatePost();
    sleep(0.3);

    testUpdatePost();
    sleep(0.3);

    testPatchPost();
    sleep(0.3);

    testDeletePost();
    sleep(0.3);
  });

  group('Other Resources Tests', () => {
    testGetUsers();
    sleep(0.3);

    testGetTodos();
    sleep(0.3);

    testGetAlbums();
    sleep(0.3);
  });
}
