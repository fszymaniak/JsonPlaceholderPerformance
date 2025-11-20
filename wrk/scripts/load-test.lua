-- wrk Load Test Script
-- Tests multiple JSONPlaceholder endpoints with random selection

wrk.method = "GET"
wrk.headers["User-Agent"] = "wrk Load Test"

-- Array of endpoints to test
local paths = {
  "/posts",
  "/posts/1",
  "/posts/50",
  "/users",
  "/todos",
  "/comments"
}

-- Request function - called for each request
request = function()
  -- Select random endpoint
  local path = paths[math.random(#paths)]
  return wrk.format(nil, path)
end

-- Response function - called for each response
response = function(status, headers, body)
  -- Log errors
  if status ~= 200 then
    print("Error: HTTP " .. status .. " received")
  end
end

-- Done function - called when test completes
done = function(summary, latency, requests)
  io.write("------------------------------\n")
  io.write("Load Test Summary\n")
  io.write("------------------------------\n")
  io.write(string.format("Total Requests: %d\n", summary.requests))
  io.write(string.format("Total Errors: %d\n", summary.errors.status + summary.errors.connect + summary.errors.read + summary.errors.write + summary.errors.timeout))
  io.write(string.format("Requests/sec: %.2f\n", summary.requests / (summary.duration / 1000000)))
  io.write(string.format("Avg Latency: %.2fms\n", latency.mean / 1000))
  io.write(string.format("Max Latency: %.2fms\n", latency.max / 1000))
end
