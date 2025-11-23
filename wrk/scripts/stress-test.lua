-- wrk Stress Test Script
-- High load testing with multiple endpoints

wrk.method = "GET"
wrk.headers["User-Agent"] = "wrk Stress Test"

local paths = {
  "/posts",
  "/posts/%d",
  "/users",
  "/todos"
}

request = function()
  local path = paths[math.random(#paths)]

  -- Replace %d with random number for parameterized paths
  if string.find(path, "%%d") then
    path = string.format(path, math.random(1, 100))
  end

  return wrk.format(nil, path)
end

response = function(status, headers, body)
  if status ~= 200 then
    print("Error: HTTP " .. status)
  end
end

done = function(summary, latency, requests)
  io.write("------------------------------\n")
  io.write("Stress Test Summary\n")
  io.write("------------------------------\n")
  io.write(string.format("Total Requests: %d\n", summary.requests))
  io.write(string.format("Total Errors: %d\n", summary.errors.status + summary.errors.connect + summary.errors.read + summary.errors.write + summary.errors.timeout))
  io.write(string.format("Requests/sec: %.2f\n", summary.requests / (summary.duration / 1000000)))
  io.write(string.format("Avg Latency: %.2fms\n", latency.mean / 1000))
  io.write(string.format("95th Percentile: %.2fms\n", latency:percentile(95) / 1000))
  io.write(string.format("99th Percentile: %.2fms\n", latency:percentile(99) / 1000))
end
