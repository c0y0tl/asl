state("Tunguska")
{}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
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

  settings.Add("anc", false, "Check 25 news");

  vars.Completed = new HashSet<string>();
  vars.lastLevel = "";
  vars.credits = false;

  vars.ENG = "Are you ready to leave\nTunguska?";
  vars.RUS = "Готовы покинуть Тунгуску?";
  vars.ITA = "Sei pronto a lasciare Tunguska?";
  vars.DEU = "Bist du bereit Tunguska zu\nverlassen?";
  vars.CHI = "你做好了准备，确定要离开通古斯了?";
  vars.UKR = "Чи готові залишити Тунгуску?";
  vars.SPA = "¿Estás listo para dejar Tunguska?";
  vars.FRM = "Êtes-vous prêt à quitter Tunguska\n?";
}

init
{
   var Instance = vars.Uhara.CreateTool("Unity", "DotNet", "Instance");

   // LoadingLabel
   // true - LoadingLabel visible
   // false - LoadingLabel hidden
   Instance.Watch<bool>("LoadingLabel", "Assembly-CSharp::MainMenuPanel", "LoadingLabel", "mIsVisibleByAlpha");

  // fade
  // float(0...1) - Black = 1, nothing = 0
  Instance.Watch<float>("fade", "GameManager", "UIManager", "FadingPanel", "Background", "finalAlpha");

  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    // loadingScreenText
    // true - Text on loading screen activated
    // false - Text on loading screen deactivated
    vars.Helper["loadingScreenText"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "FadingPanel", "LoadingScreenText", 0x140);
    // fade
    // float(0...1) - Black = 1, nothing = 0
    //vars.Helper["fade"] = mono.Make<float>("GameManager", "Inst", "UIManager", "FadingPanel", 0x20, 0x78);
    
    // currentTime
    // float
    // 410 - Magic number that appears during loading
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
    
    vars.Helper["confirmPanelIsActive"] = mono.Make<bool>("GameManager", "Inst", "UIManager", "ConfirmPanel", 0x18);
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
    if (old.newsStories == (current.newsStories - 1) )
    {
      return true;
    }
  }

  if (settings["lt"])
  {
    if ((current.messageLabel.Equals(vars.ENG) ||
         current.messageLabel.Equals(vars.RUS) ||
         current.messageLabel.Equals(vars.ITA) ||
         current.messageLabel.Equals(vars.DEU) ||
         current.messageLabel.Equals(vars.CHI) ||
         current.messageLabel.Equals(vars.UKR) ||
         current.messageLabel.Equals(vars.SPA) ||
         current.messageLabel.Equals(vars.FRM)) && 
        vars.credits == true &&
        current.fade > 0)
    {
      if (settings["anc"])
      {
        if (current.newsStories == 25)
        {
          vars.credits = false;
          return true;
        }
        else
        {
          return false;
        }
      }

      vars.credits = false;
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
        if (settings["so"] == true &&
            vars.Completed.Add(vars.splitData[i].Item1.ToString() + "l_en"))
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
  if (current.loadingScreenText == true || (current.LoadingLabel == true && current.Scene == "MainMenu")) 
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
  vars.Uhara.Update();
  vars.Helper.Update();

  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
  
  if (current.fade < 1 && current.fade > 0)
  {
    vars.lastLevel = current.subLevelName;
  }

  if (current.confirmPanelIsActive == false && old.confirmPanelIsActive == true)
  {
    vars.credits = true;
  }
}