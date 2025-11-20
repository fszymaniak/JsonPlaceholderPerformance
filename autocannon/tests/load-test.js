const autocannon = require('autocannon');

console.log('Running Autocannon Load Test...');
console.log('Configuration: 50 connections, 5 minutes');
console.log('==============================');

const instance = autocannon({
  url: 'https://jsonplaceholder.typicode.com/posts',
  connections: 50,
  duration: 300, // 5 minutes
  pipelining: 1,
  workers: 4
}, (err, result) => {
  if (err) {
    console.error('Error:', err);
    process.exit(1);
  }
  console.log('\nLoad test complete!');
  autocannon.printResult(result);
});

autocannon.track(instance, { renderProgressBar: true });
