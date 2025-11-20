package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import scala.util.Random

class SpikeTest extends Simulation {

  val httpProtocol = http
    .baseUrl("https://jsonplaceholder.typicode.com")
    .acceptHeader("application/json")
    .userAgentHeader("Gatling Spike Test")

  val spikeScenario = scenario("Spike Test Scenario")
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

  setUp(
    spikeScenario.inject(
      // Normal load
      constantUsersPerSec(5).during(2.minutes),
      // Sudden spike
      constantUsersPerSec(150).during(1.minute),
      // Recovery
      constantUsersPerSec(5).during(2.minutes),
      // Another spike
      constantUsersPerSec(150).during(1.minute),
      // Final recovery
      constantUsersPerSec(5).during(2.minutes)
    )
  ).protocols(httpProtocol)
    .assertions(
      global.successfulRequests.percent.gt(85)
    )
}
