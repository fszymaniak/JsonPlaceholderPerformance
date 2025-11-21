package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import scala.util.Random

class LoadTest extends Simulation {

  val httpProtocol = http
    .baseUrl("https://jsonplaceholder.typicode.com")
    .acceptHeader("application/json")
    .userAgentHeader("Gatling Load Test")

  val loadScenario = scenario("Load Test Scenario")
    .exec(
      http("GET /posts")
        .get("/posts")
        .check(status.is(200))
    )
    .pause(300.milliseconds)
    .exec(
      http("GET /posts/:id")
        .get("/posts/${Random.nextInt(100) + 1}")
        .check(status.is(200))
    )
    .pause(300.milliseconds)
    .exec(
      http("GET /posts/:id/comments")
        .get("/posts/${Random.nextInt(100) + 1}/comments")
        .check(status.is(200))
    )
    .pause(300.milliseconds)
    .exec(
      http("POST /posts")
        .post("/posts")
        .header("Content-Type", "application/json")
        .body(StringBody("""{"title":"Load test post ${Random.nextInt(1000)}","body":"Testing under load","userId":${Random.nextInt(10) + 1}}"""))
        .check(status.is(201))
    )
    .pause(300.milliseconds)
    .exec(
      http("PUT /posts/:id")
        .put("/posts/${Random.nextInt(100) + 1}")
        .header("Content-Type", "application/json")
        .body(StringBody("""{"id":${Random.nextInt(100) + 1},"title":"Updated title","body":"Updated body","userId":1}"""))
        .check(status.is(200))
    )
    .pause(300.milliseconds)
    .exec(
      http("DELETE /posts/:id")
        .delete("/posts/${Random.nextInt(100) + 1}")
        .check(status.is(200))
    )
    .pause(300.milliseconds)
    .exec(
      http("GET /users")
        .get("/users")
        .check(status.is(200))
    )
    .pause(300.milliseconds)
    .exec(
      http("GET /todos")
        .get("/todos")
        .check(status.is(200))
    )

  setUp(
    loadScenario.inject(
      rampUsersPerSec(10).to(20).during(2.minutes),
      constantUsersPerSec(20).during(3.minutes),
      rampUsersPerSec(20).to(50).during(2.minutes)
    )
  ).protocols(httpProtocol)
    .assertions(
      global.responseTime.percentile3.lt(2000),
      global.successfulRequests.percent.gt(95)
    )
}
