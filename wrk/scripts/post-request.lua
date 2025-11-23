-- wrk POST Request Example
-- Demonstrates POST requests with JSON body

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.headers["User-Agent"] = "wrk POST Test"

-- JSON body template
local body = [[
{
  "title": "wrk test post %d",
  "body": "Testing POST requests with wrk",
  "userId": %d
}
]]

request = function()
  local random_id = math.random(1, 1000)
  local user_id = math.random(1, 10)
  local formatted_body = string.format(body, random_id, user_id)

  return wrk.format("POST", "/posts", nil, formatted_body)
end

response = function(status, headers, body)
  if status ~= 201 and status ~= 200 then
    print("Error: HTTP " .. status)
  end
end

done = function(summary, latency, requests)
  io.write("------------------------------\n")
  io.write("POST Request Test Summary\n")
  io.write("------------------------------\n")
  io.write(string.format("Total POST Requests: %d\n", summary.requests))
  io.write(string.format("Successful: %d\n", summary.requests - summary.errors.status))
  io.write(string.format("Requests/sec: %.2f\n", summary.requests / (summary.duration / 1000000)))
end
