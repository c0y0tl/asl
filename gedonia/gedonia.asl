state("Gedonia")
{
  // loadingScreen
  // 0 - loading screen
  // 1 - in game
  byte loadingScreen: "UnityPlayer.dll", 0x017A5548, 0xD0, 0x8, 0x148, 0x6C0, 0x0, 0x998, 0x28, 0x18, 0x160;
}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");

  // Levels settings
  settings.Add("Levels", false, "Levels");
  for (int i = 2; i <= 70; i++)
  {
    settings.Add(i.ToString() + "L", false, i.ToString(), "Levels");
  }

  // Data for Mounts settings
  // Item1 - index in array
  // Item2 - mount name
  vars.mountsData = new Tuple<int, string>[]
  {
    Tuple.Create(1, "Royal Knight's Horse"),
    Tuple.Create(2, "Battle Boar"),
    Tuple.Create(3, "Enchanted  mystical deer"),
    Tuple.Create(4, "Zebuar"),
    Tuple.Create(5, "Armalak"),
    Tuple.Create(6, "Innoroth"),
    Tuple.Create(7, "Az'gor")
  };

  // Mounts settings
  settings.Add("Mounts", false, "Mounts");
  foreach (var md in vars.mountsData)
	{
		settings.Add(md.Item1.ToString() + "M", false, md.Item2, "Mounts");
  }
}

init
{
  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    // level
    // Сhanges to 1 on loading screen
    vars.Helper["level"] = mono.Make<int>("PlayerScript", "instance", "level");

    // mounts
    // [0] - Spirit (true by default)
    // [1] - Royal Knight's Horse
    // [2] - Battle Boar
    // [3] - Enchanted  mystical deer
    // [4] - Zebuar
    // [5] - Armalak
    // [6] - Innoroth
    // [7] - Az'gor
    vars.Helper["mounts"] = mono.MakeArray<bool>("GameManager", "instance", "availableMounts");
    return true;
  });

  vars.Helper.Load();
}

update
{
  if (!vars.Helper.Loaded) return false;
  vars.Helper.MapPointers();
}

isLoading
{
  if (current.loadingScreen != 1)
  {
    return true;
  }
  else
  {
    return false;
  }
}

split
{
  for (int i = 2; i <= 70; i++)
  {
    if (settings[i.ToString() + "L"] == true && current.level == i)
    {
      if (current.level > old.level && current.loadingScreen == 1)
      {
        return true;
      }
    }
  }

  for (int i = 1; i <= 7; i++)
  {
    if (settings[i.ToString() + "M"] == true && vars.mountsData[i-1].Item1 == i)
    {
      if (current.mounts[i] == true && old.mounts[i] == false && current.loadingScreen == 1)
      {
        return true;
      }
    }
  }
}

shutdown
{
  vars.Helper.Dispose();
}
