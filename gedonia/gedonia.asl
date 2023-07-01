state("Gedonia")
{}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");

  // Levels settings
  settings.Add("Levels", false, "Levels");
  for (int i = 2; i <= 80; i++)
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

  // Story settings
  settings.Add("Story", false, "Story");
  settings.Add("DarkGod", false, "Defeated Dark god", "Story");
  settings.Add("LightGod", false, "Defeated God of light", "Story");
  settings.Add("End", false, "Ending - Return to your village", "Story");

  vars.completedSplits = new HashSet<string>();
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

    // mainStory
    // -1 - On cutscenes
    // 34 - Defeated Dark god
    // 36 - Defeated God of light (change after cutscene)
    vars.Helper["mainStory"] = mono.Make<int>("GameManager", "instance", "mainStoryProgress");

    vars.Helper["testVar"] = mono.MakeArray<int>("UIPanel", "list");
    return true;
  });
}

update
{
  print("GDN " + current.testVar[current.testVar.Length - 1]);
}

onStart
{
  vars.completedSplits.Clear();
}

split
{
  if (settings["DarkGod"] == true
   && current.mainStory == 34
   && old.mainStory != current.mainStory
   && vars.completedSplits.Add("DarkGod"))
  {
    return true;
  }

  if (settings["LightGod"] == true
   && current.mainStory == 36
   && old.mainStory == 35
   && vars.completedSplits.Add("LightGod"))
  {
    return true;
  }

  if (settings["End"] == true
   && current.mainStory == -1
   && old.mainStory == 36
   && vars.completedSplits.Add("End"))
  {
    return true;
  }

  for (int i = 2; i <= 70; i++)
  {
    if (settings[i.ToString() + "L"] == true
     && current.level == i
     && current.level != old.level
     && vars.completedSplits.Add(i.ToString() + "L"))
    {
      return true;
    }
  }

  for (int i = 1; i <= 7; i++)
  {
    if (settings[i.ToString() + "M"] == true
     && vars.mountsData[i-1].Item1 == i
     && current.mounts[i] == true
     && old.mounts[i] == false
     && vars.completedSplits.Add(i.ToString() + "M"))
    {
      return true;
    }
  }
}
