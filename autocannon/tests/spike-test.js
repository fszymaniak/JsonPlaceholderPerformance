const autocannon = require('autocannon');

console.log('Running Autocannon Spike Test...');
console.log('Configuration: 500 connections, 2 minutes, high pipelining');
console.log('==============================');

const instance = autocannon({
  url: 'https://jsonplaceholder.typicode.com/posts',
  connections: 500,
  duration: 120, // 2 minutes
  pipelining: 10,
  workers: 8,
  timeout: 30
}, (err, result) => {
  if (err) {
    console.error('Error:', err);
    process.exit(1);
  }
  console.log('\nSpike test complete!');
  autocannon.printResult(result);
});

autocannon.track(instance, { renderProgressBar: true });
