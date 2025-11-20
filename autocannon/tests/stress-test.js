const autocannon = require('autocannon');

console.log('Running Autocannon Stress Test...');
console.log('Configuration: 200 connections, 10 minutes, pipelining');
console.log('==============================');

const instance = autocannon({
  url: 'https://jsonplaceholder.typicode.com/posts',
  connections: 200,
  duration: 600, // 10 minutes
  pipelining: 5,
  workers: 8
}, (err, result) => {
  if (err) {
    console.error('Error:', err);
    process.exit(1);
  }
  console.log('\nStress test complete!');
  autocannon.printResult(result);
});

autocannon.track(instance, { renderProgressBar: true });
