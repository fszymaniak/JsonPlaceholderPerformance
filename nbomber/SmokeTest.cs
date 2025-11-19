using NBomber.CSharp;
using NBomber.Http.CSharp;

namespace NBomberTests;

public static class SmokeTest
{
    private const string BaseUrl = "https://jsonplaceholder.typicode.com";

    public static void Run()
    {
        using var httpClient = new HttpClient();

        // Test 1: GET all posts
        var getPosts = Step.Create("GET /posts", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // Test 2: GET single post
        var getPost = Step.Create("GET /posts/1", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts/1");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // Test 3: POST create
        var createPost = Step.Create("POST /posts", async context =>
        {
            var body = """
                {
                    "title": "NBomber smoke test",
                    "body": "Testing create endpoint",
                    "userId": 1
                }
                """;
            var request = Http.CreateRequest("POST", $"{BaseUrl}/posts")
                .WithHeader("Content-Type", "application/json")
                .WithBody(new StringContent(body));
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // Test 4: GET users
        var getUsers = Step.Create("GET /users", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/users");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // Test 5: GET todos
        var getTodos = Step.Create("GET /todos", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/todos");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        var scenario = ScenarioBuilder
            .CreateScenario("Smoke Test", getPosts, getPost, createPost, getUsers, getTodos)
            .WithWarmUpDuration(TimeSpan.FromSeconds(5))
            .WithLoadSimulations(
                Simulation.Inject(rate: 1, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromSeconds(30))
            );

        NBomberRunner
            .RegisterScenarios(scenario)
            .Run();
    }
}
