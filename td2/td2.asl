state("DarknessII")
{
    int level: "DarknessII.exe", 0xD0A8CC;
}

update
{
	print("TD2" + " " + "Current Level: " + current.level + " " + "Old Level: " + old.level);
}

startup
{
    vars.levels = new Tuple<string, int, int>[]
    {
        Tuple.Create("dinnerout", 742, 1080),
        Tuple.Create("payback", 362, 4),
        Tuple.Create("thefamily", 1350, 3),
        Tuple.Create("qanda", 896, 4),
        Tuple.Create("morequestionsthananswers", 1388, 3),
        Tuple.Create("strongsilenttype", 1344, 471),
        Tuple.Create("dealwiththedevil", 1855, 2),
        Tuple.Create("homeinvasion", 726, 1130),
        Tuple.Create("theawakening", 1130, 3),
        Tuple.Create("endofanera", 1107, 2),
        Tuple.Create("sayinggoodbye", 1568, 4),
        Tuple.Create("onthehunt", 1357, 3),
        Tuple.Create("funandgames", 901, 3),
        Tuple.Create("strangepeople", 1131, 358),
        Tuple.Create("ratinamaze", 1092, 1176),
        Tuple.Create("homecoming", 1176, 333),
        Tuple.Create("laststand", 333, 1120),
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
            // Sometimes when changing a level, the current level is zero (loading)
            // for a very short moment, it probably depends on the loading speed
            // for this added || (or)
        	if (settings[vars.levels[i].Item1] == true && old.level == vars.levels[i].Item2 && (current.level == vars.levels[i].Item3 || current.level == 0))
			{
				return true;
			}
        }
    }

}