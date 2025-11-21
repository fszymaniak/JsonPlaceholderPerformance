package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class SmokeTest extends Simulation {

  val httpProtocol = http
    .baseUrl("https://jsonplaceholder.typicode.com")
    .acceptHeader("application/json")
    .userAgentHeader("Gatling Smoke Test")

  val smokeScenario = scenario("Smoke Test Scenario")
    .exec(
      http("GET /posts")
        .get("/posts")
        .check(status.is(200))
        .check(jsonPath("$[*]").count.gt(0))
    )
    .pause(500.milliseconds)
    .exec(
      http("GET /posts/1")
        .get("/posts/1")
        .check(status.is(200))
        .check(jsonPath("$.title").exists)
    )
    .pause(500.milliseconds)
    .exec(
      http("POST /posts")
        .post("/posts")
        .header("Content-Type", "application/json")
        .body(StringBody("""{"title":"Gatling smoke test","body":"Testing create endpoint","userId":1}"""))
        .check(status.is(201))
        .check(jsonPath("$.id").exists)
    )
    .pause(500.milliseconds)
    .exec(
      http("GET /users")
        .get("/users")
        .check(status.is(200))
    )
    .pause(500.milliseconds)
    .exec(
      http("GET /todos")
        .get("/todos")
        .check(status.is(200))
    )

  setUp(
    smokeScenario.inject(
      constantUsersPerSec(1).during(30.seconds)
    )
  ).protocols(httpProtocol)
    .assertions(
      global.responseTime.percentile3.lt(1000),
      global.failedRequests.percent.lt(1)
    )
}
