state("Tunguska")
{}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  
  vars.Helper.LoadSceneManager = true;

  // Editor's Office - EditorOffice
  // Zernaskaya Village - Village
  // Old Mill - Mill
  // Barn and Church - BarnChurch
  // Army Cordon - RoadBlock
  // Zernaskaya Station - TrainStation
  // Railroad Worker Camp - RailroadCamp
  // Water Treatment Plant - WaterTreatment
  // Lake Cheko - Swamp
  // Luxury House - LuxuryHouse
  // Station-11 - Station11Proper
  // Sanatorium - Sanatorium
  // Oblenska Army Camp - Oblenska  

  // Item1 - ID
  // Item2 - old level
  // Item3 - current level
  // Item4 - Split name
  
  vars.splitData = new Tuple<int, string, string, string>[]
  {
    Tuple.Create(1,  "EditorOffice", "Village", "Editor's Office"),
    Tuple.Create(2,  "Village", "Mill", "Zernaskaya Village 1"),
    Tuple.Create(3,  "Mill", "Village", "Old Mill"),
    Tuple.Create(4,  "BarnChurch", "Village", "Barn and Church"),
    Tuple.Create(5,  "Village", "RoadBlock", "Zernaskaya Village 2"),
    Tuple.Create(6,  "RoadBlock", "TrainStation", "Army Cordon 1"),
    Tuple.Create(7,  "TrainStation", "RoadBlock", "Zernaskaya Station"),
    Tuple.Create(8,  "RoadBlock", "Village", "Army Cordon 2"),
    Tuple.Create(9,  "Village", "RailroadCamp", "Zernaskaya Village 3"),
    Tuple.Create(10, "RailroadCamp", "WaterTreatment", "Railroad Worker Camp 1"),
    Tuple.Create(11, "WaterTreatment", "Swamp", "Water Treatment Plant"),
    Tuple.Create(12, "Swamp", "RailroadCamp", "Lake Cheko"),
    Tuple.Create(13, "Station11Proper", "Sanatorium", "Station-11"),
    Tuple.Create(14, "Oblenska", "Sanatorium", "Oblenska"),
    Tuple.Create(15, "Sanatorium", "Station11Proper", "Sanatorium"),
    Tuple.Create(16, "RailroadCamp", "Village", "Railroad Worker Camp 2")
  };

  settings.Add("l", false, "Locations");

  foreach (var d in vars.splitData)
	{
		settings.Add(d.Item1.ToString(), false, d.Item4, "l");
  }

  settings.Add("ns", false, "News Split");

  vars.Completed = new HashSet<string>();
}

init
{
  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    vars.Helper["loadingScreenText"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "FadingPanel", "LoadingScreenText", 0x140);
    vars.Helper["currentSlide"] = mono.Make<int>("GameManager", "Inst", "UIManager", "IntroPanel", "_currentSlide");
    vars.Helper["slideActive"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "IntroPanel", 0x18);
    vars.Helper["levelName"] = mono.MakeString("GameManager", "Inst", "LevelName");
    vars.Helper["subLevelName"] = mono.MakeString("GameManager", "Inst", "SubLevelName");
    vars.Helper["newsStories"] = mono.Make<int>("GameManager", "Inst", "PlayerProgress", "NewsStories", 0x18);
    vars.Helper["messageLabel"] = mono.MakeString("GameManager", "Inst", "UIManager", "ConfirmPanel", "MessageLabel", 0x198);
    vars.Helper["confirmPanelActive"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "ConfirmPanel", 0x18);

    vars.Helper["currentEnvironment"] = mono.MakeString("GameManager", "Inst", "WorldManager", "CurrentEnvironment", "Name");
    return true;
  });
}

update
{
  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
}

start
{
  if (current.currentEnvironment == "Room"
      && old.currentEnvironment == "Wilderness")
  {
    return true;
  }
}

onStart
{
  vars.Completed.Clear();
}

split
{
  if ((settings["ns"] == true) &&(current.Scene != "MainMenu" || current.Scene != "NewYork") && (current.newsStories > old.newsStories))
  {
    return true;
  }

  if (current.messageLabel.Equals("Are you ready to leave\nTunguska?") && current.confirmPanelActive == false && old.confirmPanelActive == true)
  {
    return true;
  }

  for (int i = 0; i < vars.splitData.Length; i++)
  {
    if (settings[vars.splitData[i].Item1.ToString()] == true
        && old.subLevelName.Equals(vars.splitData[i].Item2)
        && current.subLevelName.Equals(vars.splitData[i].Item3)
        && vars.Completed.Add(vars.splitData[i].Item1.ToString()))
    {
      return true;
    }
  }
}

isLoading
{
    if (current.loadingScreenText == true) 
    {
      return true;
    }
    else
    {
        return false;
    }
}