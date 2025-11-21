const autocannon = require('autocannon');

console.log('Running Autocannon Soak Test...');
console.log('Configuration: 20 connections, 30 minutes');
console.log('==============================');
console.log('This test will run for 30 minutes...\n');

const instance = autocannon({
  url: 'https://jsonplaceholder.typicode.com/posts',
  connections: 20,
  duration: 1800, // 30 minutes
  pipelining: 1,
  workers: 2
}, (err, result) => {
  if (err) {
    console.error('Error:', err);
    process.exit(1);
  }
  console.log('\nSoak test complete!');
  autocannon.printResult(result);
});

autocannon.track(instance, { renderProgressBar: true });
