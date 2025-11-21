package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import scala.util.Random

class SoakTest extends Simulation {

  val httpProtocol = http
    .baseUrl("https://jsonplaceholder.typicode.com")
    .acceptHeader("application/json")
    .userAgentHeader("Gatling Soak Test")

  val soakScenario = scenario("Soak Test Scenario")
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
        .body(StringBody("""{"title":"Soak test post ${Random.nextInt(1000)}","body":"Testing for extended duration","userId":${Random.nextInt(10) + 1}}"""))
        .check(status.is(201))
    )

  setUp(
    soakScenario.inject(
      // Sustained moderate load for 30 minutes
      constantUsersPerSec(20).during(30.minutes)
    )
  ).protocols(httpProtocol)
    .assertions(
      global.responseTime.percentile3.lt(2000),
      global.successfulRequests.percent.gt(95)
    )
}
