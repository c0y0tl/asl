state("Tunguska")
{}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  
  vars.Helper.LoadSceneManager = true;
  
  // Sublevels list:
  // Editor's Office - EditorOffice
  // Zernaskaya Village - Village
  // Old Mill - Mill
  // Barn and Church - BarnChurch
  // Army Cordon - RoadBlock
  // Zernaskaya Station - TrainStation
  // Railroad Worker Camp - RailroadCamp
  // Water Treatment Plant - WaterTreatment
  // Lake Cheko - Swamp
  // Koshevoy Estate - LuxuryHouse
  // Station-11 - Station11Proper
  // Ashinaka - Sanatorium
  // Oblenska Army Camp - Oblenska  
  // Ashinaka (Forest) - Sanatorium

  // splitData
  // Item1 - ID
  // Item2 - Sublevel name
  // Item3 - Title
  vars.splitData = new Tuple<int, string, string>[]
  {
    Tuple.Create(1,  "EditorOffice", "Editor's Office"),
    Tuple.Create(2,  "Village", "Zernaskaya Village"),
    Tuple.Create(3,  "Mill", "Old Mill"),
    Tuple.Create(4,  "BarnChurch", "Barn and Church"),
    Tuple.Create(5,  "RoadBlock", "Army Cordon"),
    Tuple.Create(6,  "TrainStation", "Zernaskaya Station"),
    Tuple.Create(7,  "RailroadCamp", "Railroad Worker Camp"),
    Tuple.Create(8,  "Station11Proper", "Station-11"),
    Tuple.Create(9,  "LuxuryHouse", "Koshevoy Estate"),
    Tuple.Create(10, "WaterTreatment", "Water Treatment Plant"),
    Tuple.Create(11, "Swamp", "Lake Cheko"),
    Tuple.Create(12, "Sanatorium", "Ashinaka"),
    Tuple.Create(13, "Oblenska", "Oblenska Army Camp")
  };

  settings.Add("so", false, "Split Once");

  settings.Add("l_en", false, "Entering the SubLevel");
  foreach (var d in vars.splitData)
	{
		settings.Add(d.Item1.ToString() + "l_en", false, d.Item3, "l_en");
  }

  settings.Add("lt", false, "Leave Tunguska");

  settings.Add("ns", false, "Split on 'Discovered a news story'");

  vars.Completed = new HashSet<string>();
  vars.lastLevel = "";
}

init
{
  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    // loadingScreenText
    // true - Text on loading screen activated
    // false - Text on loading screen deactivated
    vars.Helper["loadingScreenText"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "FadingPanel", "LoadingScreenText", 0x140);
    vars.Helper["fade"] = mono.Make<float>("GameManager", "Inst", "UIManager", "FadingPanel", 0x20, 0x78);
    
    //current time
    vars.Helper["currentTime"] = mono.Make<float>("GameManager", "Inst", "WorldManager", "CurrentTime");


    // levelName
    // string - Current level
    vars.Helper["levelName"] = mono.MakeString("GameManager", "Inst", "LevelName");
    // subLevelName
    // string - Current sublevel
    vars.Helper["subLevelName"] = mono.MakeString("GameManager", "Inst", "SubLevelName");
    // currentEnvironment
    // string - Current environment
    // string (Wilderness) - In normal world
    vars.Helper["currentEnvironment"] = mono.MakeString("GameManager", "Inst", "WorldManager", "CurrentEnvironment", "Name");
    
    // newsStories
    // int (0 default) - increases by one when the player receives a new news stories
    vars.Helper["newsStories"] = mono.Make<int>("GameManager", "Inst", "PlayerProgress", "NewsStories", 0x18);
    
    // messageLabel
    // string - text on confirm panel
    vars.Helper["messageLabel"] = mono.MakeString("GameManager", "Inst", "UIManager", "ConfirmPanel", "MessageLabel", 0x198);
    // confirmPanelActive
    // true - When panel is visible
    // false - When panel is hidden
    vars.Helper["confirmPanelActive"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "ConfirmPanel", 0x18);
    
    return true;
  });
}

onStart
{
  vars.lastLevel = "";
  vars.Completed.Clear();
}

start
{
  if (current.currentEnvironment == "Room" && 
      old.fade == 1 &&
      current.fade < 1)
  {
    return true;
  }
}

split
{
  if (settings["ns"])
  {
    if (current.newsStories == old.newsStories - 1)
    {
      return true;
    }
  }

  if (settings["lt"])
  {
    if ((current.messageLabel.Equals("Are you ready to leave\nTunguska?") ||
         current.messageLabel.Equals("Готовы покинуть Тунгуску?")
        )
      && current.confirmPanelActive == false 
      && old.confirmPanelActive == true
      && old.fade == 0
      && current.fade > 0)
    {
      return true;
    }
  }

  if (settings["l_en"])
  {
    for (int i = 0; i < vars.splitData.Length; i++)
    {
      if (settings[vars.splitData[i].Item1.ToString() + "l_en"] == true &&
          current.subLevelName.Equals(vars.splitData[i].Item2) &&
          old.currentTime == 410 &&
          current.currentTime != 410 &&
          vars.lastLevel != current.subLevelName)
      {
        if (settings["so"] == true && vars.Completed.Add(vars.splitData[i].Item1.ToString() + "l_en"))
        {
          return true;
        }

        if (settings["so"] == false)
        {
          return true;
        }
      }
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

update
{
  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
  
  if (old.fade == 0 && current.fade > 0)
  {
    vars.lastLevel = current.subLevelName;
  }

  //print("CURRENT SL " + current.subLevelName + " LL " + vars.lastLevel + " TIME " + current.currentTime);
  //print("CURRENT fade " + current.fade);
}