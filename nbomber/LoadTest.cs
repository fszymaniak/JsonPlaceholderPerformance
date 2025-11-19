using NBomber.CSharp;
using NBomber.Http.CSharp;

namespace NBomberTests;

public static class LoadTest
{
    private const string BaseUrl = "https://jsonplaceholder.typicode.com";

    public static void Run()
    {
        using var httpClient = new HttpClient();

        // GET all posts
        var getPosts = Step.Create("GET /posts", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // GET single post (random)
        var getPost = Step.Create("GET /posts/:id", async context =>
        {
            var postId = Random.Shared.Next(1, 101);
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts/{postId}");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // GET post comments
        var getComments = Step.Create("GET /posts/:id/comments", async context =>
        {
            var postId = Random.Shared.Next(1, 101);
            var request = Http.CreateRequest("GET", $"{BaseUrl}/posts/{postId}/comments");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // POST create post
        var createPost = Step.Create("POST /posts", async context =>
        {
            var body = $$$"""
                {
                    "title": "Load test post {{{Random.Shared.Next(1000)}}}",
                    "body": "Testing under load",
                    "userId": {{{Random.Shared.Next(1, 11)}}}
                }
                """;
            var request = Http.CreateRequest("POST", $"{BaseUrl}/posts")
                .WithHeader("Content-Type", "application/json")
                .WithBody(new StringContent(body));
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // PUT update post
        var updatePost = Step.Create("PUT /posts/:id", async context =>
        {
            var postId = Random.Shared.Next(1, 101);
            var body = $$$"""
                {
                    "id": {{{postId}}},
                    "title": "Updated title",
                    "body": "Updated body",
                    "userId": 1
                }
                """;
            var request = Http.CreateRequest("PUT", $"{BaseUrl}/posts/{postId}")
                .WithHeader("Content-Type", "application/json")
                .WithBody(new StringContent(body));
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // DELETE post
        var deletePost = Step.Create("DELETE /posts/:id", async context =>
        {
            var postId = Random.Shared.Next(1, 101);
            var request = Http.CreateRequest("DELETE", $"{BaseUrl}/posts/{postId}");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // GET users
        var getUsers = Step.Create("GET /users", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/users");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        // GET todos
        var getTodos = Step.Create("GET /todos", async context =>
        {
            var request = Http.CreateRequest("GET", $"{BaseUrl}/todos");
            var response = await Http.Send(httpClient, request);
            return response;
        });

        var scenario = ScenarioBuilder
            .CreateScenario("Load Test", getPosts, getPost, getComments, createPost, updatePost, deletePost, getUsers, getTodos)
            .WithWarmUpDuration(TimeSpan.FromSeconds(10))
            .WithLoadSimulations(
                Simulation.RampingInject(rate: 10, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(2)),
                Simulation.Inject(rate: 20, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(3)),
                Simulation.RampingInject(rate: 50, interval: TimeSpan.FromSeconds(1), during: TimeSpan.FromMinutes(2))
            );

        NBomberRunner
            .RegisterScenarios(scenario)
            .Run();
    }
}
