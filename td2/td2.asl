state("DarknessII")
{
    // Current level id
    int level: "DarknessII.exe", 0xD0A8CC;
    // Counter, increases when new level loaded
    int levelLoaded: "DarknessII.exe", 0xCDE0E0;
    // Loading
    // 0 - loading
    // 1 - in game
    int loading: "DarknessII.exe", 0xD02454;
    // Menu
    // 4 - menu, pause
    // 0 - loading
    int menu: "DarknessII.exe", 0xCD863C;

}

update
{
	print("TD2" + " " + "Current level: " + current.level + " " + "Old level: " + old.level);
	print("TD2" + " " + "Current levelLoaded: " + current.levelLoaded + " " + "Old levelLoaded: " + old.levelLoaded);
    if (current.loading == 0 && current.menu == 0) {
        print("LOADING...");
    }
}

startup
{
    // levels
    // Item1 - mission name, use to check the settings 
    // Item2 - level id for last level for the current mission
    vars.levels = new Tuple<string, int>[]
    {
        Tuple.Create("dinnerout", 742),
        Tuple.Create("payback", 362),
        Tuple.Create("thefamily", 1350),
        Tuple.Create("qanda", 896),
        Tuple.Create("morequestionsthananswers", 1388),
        Tuple.Create("strongsilenttype", 1344),
        Tuple.Create("dealwiththedevil", 1855),
        Tuple.Create("homeinvasion", 726),
        Tuple.Create("theawakening", 1130),
        Tuple.Create("endofanera", 1107),
        Tuple.Create("sayinggoodbye", 1568),
        Tuple.Create("onthehunt", 1357),
        Tuple.Create("funandgames", 901),
        Tuple.Create("strangepeople", 1131),
        Tuple.Create("ratinamaze", 1092),
        Tuple.Create("homecoming", 1176),
        Tuple.Create("laststand", 333),
    };

    settings.Add("td2", true, "The Darkness II");
    settings.Add("dinnerout", true, "Dinner Out", "td2");
    settings.Add("payback", true, "Payback", "td2");
    settings.Add("thefamily", true, "The Family", "td2");
    settings.Add("qanda", true, "Q and A", "td2");
    settings.Add("morequestionsthananswers", true, "More Questions than Answers", "td2");
    settings.Add("strongsilenttype", true, "Strong Silent Type", "td2");
    settings.Add("dealwiththedevil", true, "Deal with the Devil", "td2");
    settings.Add("homeinvasion", true, "Home Invasion", "td2");
    settings.Add("theawakening", true, "The Awakening", "td2");
    settings.Add("endofanera", true, "End of an Era", "td2");
    settings.Add("sayinggoodbye", true, "Saying Goodbye", "td2");
    settings.Add("onthehunt", true, "On the Hunt", "td2");
    settings.Add("funandgames", true, "Fun and Games", "td2");
    settings.Add("strangepeople", true, "Strange People", "td2");
    settings.Add("ratinamaze", true, "Rat in a Maze", "td2");
    settings.Add("homecoming", true, "Homecoming", "td2");
    settings.Add("laststand", true, "Last Stand", "td2");
    //settings.Add("revelations", true, "Revelations", "td2");
}

split 
{
    if (settings["td2"])
    {
        for (int i = 0; i < vars.levels.Length; i++)
        {
        	if (settings[vars.levels[i].Item1] == true && old.level == vars.levels[i].Item2 && current.levelLoaded != old.levelLoaded)
			{
				return true;
			}
        }
    }

}

isLoading
{
    return current.loading == 0 && current.menu == 0;
}