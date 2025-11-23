-- wrk Soak Test Script
-- Extended duration test for memory leaks and performance degradation

wrk.method = "GET"
wrk.headers["User-Agent"] = "wrk Soak Test"

local paths = {
  "/posts",
  "/posts/%d",
  "/posts/%d/comments",
  "/users",
  "/todos"
}

local counter = 0

request = function()
  counter = counter + 1
  local path = paths[math.random(#paths)]

  if string.find(path, "%%d") then
    path = string.format(path, math.random(1, 100))
  end

  return wrk.format(nil, path)
end

done = function(summary, latency, requests)
  io.write("==============================\n")
  io.write("Soak Test Summary\n")
  io.write("==============================\n")
  io.write(string.format("Duration: %.2f minutes\n", summary.duration / 1000000 / 60))
  io.write(string.format("Total Requests: %d\n", summary.requests))
  io.write(string.format("Requests/sec: %.2f\n", summary.requests / (summary.duration / 1000000)))
  io.write(string.format("Total Errors: %d\n", summary.errors.status + summary.errors.connect + summary.errors.read + summary.errors.write + summary.errors.timeout))
  io.write(string.format("Error Rate: %.2f%%\n", (summary.errors.status + summary.errors.connect + summary.errors.read + summary.errors.write + summary.errors.timeout) / summary.requests * 100))
  io.write(string.format("Avg Latency: %.2fms\n", latency.mean / 1000))
  io.write(string.format("Min Latency: %.2fms\n", latency.min / 1000))
  io.write(string.format("Max Latency: %.2fms\n", latency.max / 1000))
end
