package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import scala.util.Random

class StressTest extends Simulation {

  val httpProtocol = http
    .baseUrl("https://jsonplaceholder.typicode.com")
    .acceptHeader("application/json")
    .userAgentHeader("Gatling Stress Test")

  val stressScenario = scenario("Stress Test Scenario")
    .exec(
      http("GET /posts")
        .get("/posts")
        .check(status.is(200))
    )
    .pause(200.milliseconds)
    .exec(
      http("GET /posts/:id")
        .get("/posts/${Random.nextInt(100) + 1}")
        .check(status.is(200))
    )
    .pause(200.milliseconds)
    .exec(
      http("POST /posts")
        .post("/posts")
        .header("Content-Type", "application/json")
        .body(StringBody("""{"title":"Stress test post ${Random.nextInt(1000)}","body":"Testing under high stress","userId":${Random.nextInt(10) + 1}}"""))
        .check(status.is(201))
    )

  setUp(
    stressScenario.inject(
      rampUsersPerSec(50).to(100).during(2.minutes),
      constantUsersPerSec(100).during(5.minutes),
      rampUsersPerSec(100).to(150).during(2.minutes),
      constantUsersPerSec(150).during(3.minutes),
      rampUsersPerSec(150).to(10).during(2.minutes)
    )
  ).protocols(httpProtocol)
    .assertions(
      global.successfulRequests.percent.gt(90)
    )
}
