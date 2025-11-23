-- wrk Spike Test Script
-- Simulates traffic spike with GET requests

wrk.method = "GET"
wrk.headers["User-Agent"] = "wrk Spike Test"

local paths = {
  "/posts",
  "/posts/%d"
}

request = function()
  local path = paths[math.random(#paths)]

  if string.find(path, "%%d") then
    path = string.format(path, math.random(1, 100))
  end

  return wrk.format(nil, path)
end

done = function(summary, latency, requests)
  io.write("------------------------------\n")
  io.write("Spike Test Summary\n")
  io.write("------------------------------\n")
  io.write(string.format("Duration: %.2fs\n", summary.duration / 1000000))
  io.write(string.format("Total Requests: %d\n", summary.requests))
  io.write(string.format("Requests/sec: %.2f\n", summary.requests / (summary.duration / 1000000)))
  io.write(string.format("Avg Latency: %.2fms\n", latency.mean / 1000))
end
