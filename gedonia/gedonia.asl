state("Gedonia")
{}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  
  // Scene manager to get a scene name
  vars.Helper.LoadSceneManager = true;

  // Max level for current patch
  vars.maxLvl = 80;

  // Levels settings
  settings.Add("Levels", false, "Levels");
  for (int i = 2; i <= vars.maxLvl; i++)
  {
    settings.Add(i.ToString() + "lvl", false, i.ToString(), "Levels");
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
		settings.Add(md.Item1.ToString() + "mnt", false, md.Item2, "Mounts");
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
    // Сhanges to 1 (few seconds) on loading screen
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

    // loading
    // after a few seconds of loading, the value changes to false, a listPanels is used to fix it
    // true  - loading
    // false - game
    vars.Helper["loading"] = mono.Make<bool>("InterfaceManager", "instance", "panels", 0x70, 0x10, 0x57);

    // listPanels
    // contains a list of open panels
    // 0 - loading (few seconds)
    vars.Helper["listPanels"] = mono.MakeArray<bool>("UIPanel", "list");
    return true;
  });
}

update
{
  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
}

start
{
  return old.Scene == "StartCutscene" && current.Scene == "Game";  
}

onStart
{
  vars.completedSplits.Clear();
}

split
{
  for (int i = 2; i <= vars.maxLvl; i++)
  {
    if (settings[i.ToString() + "lvl"] == true
        && current.level == i
        && old.level != current.level
        && current.loading == false
        && current.listPanels.Length != 0
        && vars.completedSplits.Add(i.ToString() + "lvl"))
    {
      return true;
    }
  }

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

  for (int i = 1; i <= vars.mountsData.Length; i++)
  {
    if (settings[i.ToString() + "mnt"] == true
        && vars.mountsData[i-1].Item1 == i
        && current.mounts[i] == true
        && old.mounts[i] == false
        && vars.completedSplits.Add(i.ToString() + "mnt"))
    {
      return true;
    }
  }
}

isLoading
{
  return current.loading == true || current.listPanels.Length == 0;
}