state("Neon Boost") {}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  vars.Helper.GameName = "Neon Boost";
  vars.Helper.LoadSceneManager = true;
  vars.kphRound = 0;
  vars.lastZero = 0;
  vars.goToMenu = 0;
  vars.timeBetween = 0;

  vars.address = null; // 
  vars.finalPoints = 0; // Shows end gametime on finishing last level

  settings.Add("start_reset", true, "Start/Reset");
  settings.SetToolTip("start_reset", "Use only one of the options");
  settings.Add("01start_reset", true, "Laset City Start/Reset", "start_reset");
  settings.Add("02start_reset", false, "Tesla Factory Start/Reset", "start_reset");
  settings.Add("03start_reset", false, "Cosmic Highway Start/Reset","start_reset");

  // Item1 - ID (Used for Settings)
  // Item2 - Previous level
  // Item3 - Next level
  // Item4 - Level Name (Used for Settings)
  vars.splitData = new Tuple<int, string, string, string>[]
  {
    Tuple.Create(0, "Lvl_01_01", "Lvl_01_02", "Lvl_01_01"),
    Tuple.Create(1, "Lvl_01_02", "Lvl_01_03", "Lvl_01_02"),
    Tuple.Create(2, "Lvl_01_03", "Lvl_01_04", "Lvl_01_03"),
    Tuple.Create(3, "Lvl_01_04", "Lvl_01_05", "Lvl_01_04"),
    Tuple.Create(4, "Lvl_01_05", "Lvl_01_06", "Lvl_01_05"),
    Tuple.Create(5, "Lvl_01_06", "Lvl_01_07", "Lvl_01_06"),
    Tuple.Create(6, "Lvl_01_07", "Lvl_01_08", "Lvl_01_07"),
    Tuple.Create(7, "Lvl_01_08", "Lvl_01_09", "Lvl_01_08"),
    Tuple.Create(8, "Lvl_01_09", "Lvl_01_10", "Lvl_01_09"),
    Tuple.Create(9, "Lvl_01_10", "Lvl_01_11", "Lvl_01_10"),
    Tuple.Create(10, "Lvl_01_11", "Lvl_01_12", "Lvl_01_11"),
    Tuple.Create(11, "Lvl_01_12", "Lvl_00_Menu", "Lvl_01_12"),

    Tuple.Create(12, "Lvl_02_01", "Lvl_02_02", "Lvl_02_01"),
    Tuple.Create(13, "Lvl_02_02", "Lvl_02_03", "Lvl_02_02"),
    Tuple.Create(14, "Lvl_02_03", "Lvl_02_04", "Lvl_02_03"),
    Tuple.Create(15, "Lvl_02_04", "Lvl_02_05", "Lvl_02_04"),
    Tuple.Create(16, "Lvl_02_05", "Lvl_02_06", "Lvl_02_05"),
    Tuple.Create(17, "Lvl_02_06", "Lvl_02_07", "Lvl_02_06"),
    Tuple.Create(18, "Lvl_02_07", "Lvl_02_08", "Lvl_02_07"),
    Tuple.Create(19, "Lvl_02_08", "Lvl_02_10", "Lvl_02_08"),
    Tuple.Create(20, "Lvl_02_10", "Lvl_02_11", "Lvl_02_09"),
    Tuple.Create(21, "Lvl_02_11", "Lvl_02_12", "Lvl_02_10"),
    Tuple.Create(22, "Lvl_02_12", "Lvl_02_09", "Lvl_02_11"),
    Tuple.Create(23, "Lvl_02_09", "Lvl_00_Menu", "Lvl_02_12"),

    Tuple.Create(24, "Lvl_03_06", "Lvl_03_02", "Lvl_03_01"),
    Tuple.Create(25, "Lvl_03_02", "Lvl_03_03", "Lvl_03_02"),
    Tuple.Create(26, "Lvl_03_03", "Lvl_03_01", "Lvl_03_03"),
    Tuple.Create(27, "Lvl_03_01", "Lvl_03_04", "Lvl_03_04"),
    Tuple.Create(28, "Lvl_03_04", "Lvl_03_05", "Lvl_03_05"),
    Tuple.Create(29, "Lvl_03_05", "Lvl_03_08", "Lvl_03_06"),
    Tuple.Create(30, "Lvl_03_08", "Lvl_03_09", "Lvl_03_07"),
    Tuple.Create(31, "Lvl_03_09", "Lvl_03_10", "Lvl_03_08"),
    Tuple.Create(32, "Lvl_03_10", "Lvl_03_07", "Lvl_03_09"),
    Tuple.Create(33, "Lvl_03_07", "Lvl_03_12", "Lvl_03_10"),
    Tuple.Create(34, "Lvl_03_12", "Lvl_03_11", "Lvl_03_11")
  };

  foreach (var sd in vars.splitData)
  {
    settings.Add(sd.Item1.ToString(), true, sd.Item4);
  }

  settings.SetToolTip("11", "Split by exit in menu");
  settings.SetToolTip("23", "Split by exit in menu");

  settings.Add("35", true, "[Crutch] Lvl_03_12");
  settings.SetToolTip("35", "[Crutch] Split by exit in menu. IGT - (TimeWhenGoToMenu - TimeWhenSpeed​​WasZeroLastTime)");

  vars.completedSplits = new HashSet<string>();
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
  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
  vars.kphRound = Math.Round(current.kph, 0);
  // Old Coyotl method
  /* 
  if (current.Scene == "Lvl_03_11" && old.kph > 0 && current.kph == 0)
  {
    vars.lastZero = timer.CurrentTime.GameTime;
    print("lastZero = " + vars.lastZero);
  }

  if (old.Scene == "Lvl_03_11" && current.Scene == "Lvl_00_Menu")
  {
    vars.goToMenu = timer.CurrentTime.GameTime;
    print("goToMenu = " + vars.goToMenu);
  }
  */

  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;

  // New Nikvel method
  if (current.Scene == "Lvl_03_11")
  {
    IntPtr startAddress = new DeepPointer("UnityPlayer.dll", 0x01536F08, 0x8, 0x8, 0x30, 0x30, 0x28, 0x88, 0xB8, 0x60, 0x18).Deref<IntPtr>(game);

    // Checks if the pointer is correct by looking at the level medals
    int currentLevel = new DeepPointer(startAddress + 0x94).Deref<int>(game);
    float gold = new DeepPointer(startAddress + 0x9c).Deref<float>(game);
    float silver = new DeepPointer(startAddress + 0xa0).Deref<float>(game);
    float bronze = new DeepPointer(startAddress + 0xa4).Deref<float>(game);
    float dev = new DeepPointer(startAddress + 0xa8).Deref<float>(game);

    if (currentLevel == 36 && gold == 60 && silver == 65 && bronze == 70 && dev == 55)
    {
      // Writes correct address to vars.address
      if (vars.address != startAddress)
      {
        vars.address = startAddress;
      }
    }
    vars.finalPoints = new DeepPointer(vars.address + 0x58, 0x40).Deref<float>(game);
  }
}

onStart
{
  vars.completedSplits.Clear();
}

isLoading
{
  return false;
}

start
{
  if (settings["01start_reset"])
  {
    if (((current.Scene == "Lvl_01_01") || (current.Scene == "Lvl_01_01b"))  && old.Scene == "Lvl_00_Menu")
    {
      return true;
    }
  }
  if (settings["02start_reset"])
  {
    if (((current.Scene == "Lvl_02_01") || (current.Scene == "Lvl_02_01b"))  && old.Scene == "Lvl_00_Menu")
    {
      return true;
    }
  }
  if (settings["03start_reset"])
  {
    if (((current.Scene == "Lvl_03_06") || (current.Scene == "Lvl_03_06b"))  && old.Scene == "Lvl_00_Menu")
    {
      return true;
    }
  }
}

reset
{
  if (settings["01start_reset"])
  {
    if (((current.Scene == "Lvl_01_01") || (current.Scene == "Lvl_01_01b"))  && old.Scene == "Lvl_00_Menu")
    {
      return true;
    }
  }
  if (settings["02start_reset"])
  {
    if (((current.Scene == "Lvl_02_01") || (current.Scene == "Lvl_02_01b"))  && old.Scene == "Lvl_00_Menu")
    {
      return true;
    }
  }
  if (settings["03start_reset"])
  {
    if (((current.Scene == "Lvl_03_06") || (current.Scene == "Lvl_03_06b"))  && old.Scene == "Lvl_00_Menu")
    {
      return true;
    }
  }
}

split
{
  // Old last level split
  /*
  if (settings["35"] && old.Scene == "Lvl_03_11" && current.Scene == "Lvl_00_Menu")
  {
    vars.timeBetween = vars.goToMenu - vars.lastZero;
    timer.SetGameTime(timer.CurrentTime.GameTime - vars.timeBetween);
    return true;
  }
  */

  for (int i = 0; i < vars.splitData.Length; i++)
  {
    if (settings[vars.splitData[i].Item1.ToString()] == true
        && ((vars.splitData[i].Item2 == old.Scene) || (vars.splitData[i].Item2 + "b" == old.Scene))
        && ((vars.splitData[i].Item3 == current.Scene) || (vars.splitData[i].Item3 + "b" == current.Scene))
        && vars.completedSplits.Add(i.ToString()))
    {
      return true;
    }
  }

  // Last level split
  if (current.Scene == "Lvl_03_11" && vars.finalPoints != 0)
  {
    return true;
  }
}
