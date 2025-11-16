import http from 'k6/http';
import { check, group, sleep } from 'k6';
import { Rate } from 'k6/metrics';

// Custom metrics
const errorRate = new Rate('errors');

// Test configuration
export const options = {
  stages: [
    { duration: '30s', target: 10 },  // Ramp-up to 10 users
    { duration: '1m', target: 10 },   // Stay at 10 users
    { duration: '30s', target: 20 },  // Ramp-up to 20 users
    { duration: '1m', target: 20 },   // Stay at 20 users
    { duration: '30s', target: 0 },   // Ramp-down to 0 users
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests should be below 500ms
    http_req_failed: ['rate<0.1'],    // Error rate should be less than 10%
    errors: ['rate<0.1'],              // Custom error rate threshold
  },
};

const BASE_URL = 'https://jsonplaceholder.typicode.com';

// Helper function to generate random data
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Test 1: GET all posts
export function testGetAllPosts() {
  const response = http.get(`${BASE_URL}/posts`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response has posts': (r) => r.json().length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  errorRate.add(!success);
}

// Test 2: GET single post
export function testGetSinglePost() {
  const postId = getRandomInt(1, 100);
  const response = http.get(`${BASE_URL}/posts/${postId}`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'post has id': (r) => r.json().id !== undefined,
    'post has title': (r) => r.json().title !== undefined,
    'response time < 300ms': (r) => r.timings.duration < 300,
  });
  
  errorRate.add(!success);
}

// Test 3: GET comments for a post
export function testGetPostComments() {
  const postId = getRandomInt(1, 100);
  const response = http.get(`${BASE_URL}/posts/${postId}/comments`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has comments': (r) => r.json().length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  errorRate.add(!success);
}

// Test 4: POST create new post
export function testCreatePost() {
  const payload = JSON.stringify({
    title: `Test Post ${Date.now()}`,
    body: 'This is a test post created by k6 performance testing',
    userId: getRandomInt(1, 10),
  });
  
  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  
  const response = http.post(`${BASE_URL}/posts`, payload, params);
  
  const success = check(response, {
    'status is 201': (r) => r.status === 201,
    'response has id': (r) => r.json().id !== undefined,
    'response time < 600ms': (r) => r.timings.duration < 600,
  });
  
  errorRate.add(!success);
}

// Test 5: PUT update post
export function testUpdatePost() {
  const postId = getRandomInt(1, 100);
  const payload = JSON.stringify({
    id: postId,
    title: `Updated Post ${Date.now()}`,
    body: 'This post has been updated by k6',
    userId: 1,
  });
  
  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  
  const response = http.put(`${BASE_URL}/posts/${postId}`, payload, params);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'id matches': (r) => r.json().id === postId,
    'response time < 600ms': (r) => r.timings.duration < 600,
  });
  
  errorRate.add(!success);
}

// Test 6: PATCH partial update
export function testPatchPost() {
  const postId = getRandomInt(1, 100);
  const payload = JSON.stringify({
    title: `Patched Title ${Date.now()}`,
  });
  
  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  
  const response = http.patch(`${BASE_URL}/posts/${postId}`, payload, params);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 600ms': (r) => r.timings.duration < 600,
  });
  
  errorRate.add(!success);
}

// Test 7: DELETE post
export function testDeletePost() {
  const postId = getRandomInt(1, 100);
  const response = http.del(`${BASE_URL}/posts/${postId}`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  errorRate.add(!success);
}

// Test 8: GET users
export function testGetUsers() {
  const response = http.get(`${BASE_URL}/users`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has users': (r) => r.json().length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  errorRate.add(!success);
}

// Test 9: GET todos
export function testGetTodos() {
  const response = http.get(`${BASE_URL}/todos`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has todos': (r) => r.json().length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  errorRate.add(!success);
}

// Test 10: GET albums
export function testGetAlbums() {
  const response = http.get(`${BASE_URL}/albums`);
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'has albums': (r) => r.json().length > 0,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  errorRate.add(!success);
}

// Main test function - executes all test scenarios
export default function () {
  group('Posts API Tests', () => {
    testGetAllPosts();
    sleep(1);
    
    testGetSinglePost();
    sleep(1);
    
    testGetPostComments();
    sleep(1);
    
    testCreatePost();
    sleep(1);
    
    testUpdatePost();
    sleep(1);
    
    testPatchPost();
    sleep(1);
    
    testDeletePost();
    sleep(1);
  });
  
  group('Other Resources Tests', () => {
    testGetUsers();
    sleep(1);
    
    testGetTodos();
    sleep(1);
    
    testGetAlbums();
    sleep(1);
  });
}
