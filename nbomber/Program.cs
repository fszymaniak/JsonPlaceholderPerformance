using NBomber.CSharp;

namespace NBomberTests;

class Program
{
    static void Main(string[] args)
    {
        var scenario = args.Length > 0 && args[0] == "--scenario" && args.Length > 1
            ? args[1].ToLower()
            : "smoke";

        Console.WriteLine($"Running {scenario} test scenario...");

        switch (scenario)
        {
            case "smoke":
                SmokeTest.Run();
                break;
            case "load":
                LoadTest.Run();
                break;
            case "stress":
                StressTest.Run();
                break;
            case "spike":
                SpikeTest.Run();
                break;
            case "soak":
                SoakTest.Run();
                break;
            default:
                Console.WriteLine($"Unknown scenario: {scenario}");
                Console.WriteLine("Available scenarios: smoke, load, stress, spike, soak");
                Environment.Exit(1);
                break;
        }
    }
}
