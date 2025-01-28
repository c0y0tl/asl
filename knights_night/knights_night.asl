state("Knight's Night!") {}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  vars.Helper.GameName = "Knight's Night!";
  vars.Helper.LoadSceneManager = true;
}

update
{
  current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
}

start
{
  if (current.Scene == "1" && old.Scene == "MainMenu")
  {
    return true;
  }
}

split
{
  if ((current.Scene != "MainMenu" && old.Scene != "MainMenu") 
    && (Int32.Parse(current.Scene) > Int32.Parse(old.Scene)))
  {
    return true;
  }

  if (current.Scene == "MainMenu" && old.Scene == "25")
  {
    return true;
  }
}