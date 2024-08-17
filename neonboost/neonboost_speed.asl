state("Neon Boost") {}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  vars.Helper.GameName = "Neon Boost";
  vars.kphRound = 0;
}

init
{
  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    // Thanks to Seifer
    vars.Helper["kph"] = mono.Make<double>("MusicSystem", "instance", "_FPSV", "kph");
    return true;
  });
}

update
{
  vars.kphRound = Math.Round(current.kph, 0);
}