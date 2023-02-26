state("Gedonia")
{
  // Level
  // 1 - on the loading screen
  int level: "UnityPlayer.dll", 0x0187EB70, 0x430, 0x850, 0x10, 0xE0, 0x60, 0x504;

  // Loading
  // 1 - in game 
  // 0 - loading
  byte isLoading: "UnityPlayer.dll", 0x0177ED40, 0x1D0, 0x48, 0x68, 0xC8, 0x968;
}

startup
{
  // Level settings
  settings.Add("Levels", false, "Levels");
  for (int i = 1; i <= 70; i++)
  {
    settings.Add(i.ToString(), false, i.ToString(), "Levels");
  }
}

isLoading
{
  if (current.isLoading != 1)
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
  for (int i = 1; i <= 70; i++)
  {
    if (settings[i.ToString()] == true && current.level == i)
    {
      if (current.level == 2 && old.level == 1)
      {
        return true;
      }
      if (current.level > old.level && old.level != 1)
      {
        return true;
      }
    }
  }
}