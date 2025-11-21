using NBomber.CSharp;
using NBomber.Http.CSharp;

namespace NBomberTests;

public static class SoakTest
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

        var getComments = Step.Create("GET /posts/:id/comments", async context =>
        {
            var postId = Random.Shared.Next(1, 101);
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts/{postId}/comments");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        var createPost = Step.Create("POST /posts", async context =>
        {
            var body = $$$"""
                {
                    "title": "Soak test post {{{Random.Shared.Next(1000)}}}",
                    "body": "Testing for extended duration",
                    "userId": {{{Random.Shared.Next(1, 11)}}}
                }
                """;
            var request = Http.CreateRequest("POST", $"{BaseUrl}/posts")
                .WithHeader("Content-Type", "application/json")
                .WithBody(new StringContent(body));
            var response = await Http.Send(httpClient, request);
            return response;
        });

        var scenario = ScenarioBuilder
            .CreateScenario("Soak Test", getPosts, getPost, getComments, createPost)
            .WithWarmUpDuration(TimeSpan.FromSeconds(10))
            .WithLoadSimulations(
                // Sustained moderate load for 30 minutes
                Simulation.Inject(rate: 20, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(30))
            );

        NBomberRunner
            .RegisterScenarios(scenario)
            .Run();
    }
}
