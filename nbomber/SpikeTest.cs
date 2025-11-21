using NBomber.CSharp;
using NBomber.Http.CSharp;

namespace NBomberTests;

public static class SpikeTest
{
    private const string BaseUrl = "https://jsonplaceholder.typicode.com";

    public static void Run()
    {
        using var httpClient = new HttpClient();

        var getPosts = Step.Create("GET /posts", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        var getPost = Step.Create("GET /posts/:id", async context =>
        {
            var postId = Random.Shared.Next(1, 101);
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts/{postId}");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        var scenario = ScenarioBuilder
            .CreateScenario("Spike Test", getPosts, getPost)
            .WithWarmUpDuration(TimeSpan.FromSeconds(10))
            .WithLoadSimulations(
                // Normal load
                Simulation.Inject(rate: 5, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(2)),
                // Sudden spike
                Simulation.Inject(rate: 150, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(1)),
                // Recovery
                Simulation.Inject(rate: 5, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(2)),
                // Another spike
                Simulation.Inject(rate: 150, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(1)),
                // Final recovery
                Simulation.Inject(rate: 5, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(2))
            );

        NBomberRunner
            .RegisterScenarios(scenario)
            .Run();
    }
}
