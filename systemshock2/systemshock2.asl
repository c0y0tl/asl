state("Shock2")
{
    // Map name
    string255 mapName: "Shock2.exe", 0x4506C8;
    
    // Loading state
    // Does not work correctly when the game is launched for the first time
    // 0  - Loading
    // >0 - In Game
    int isLoading: "Shock2.exe", 0x54B578;

    // Menu state
    // 0  - In Game
    // >0 - Menu
    int gameState1: "Shock2.exe", 0x6237B0;

    // Is menu
    // 1 - In Game
    // 8 - In Menu
    int gameState2: "Shock2.exe", 0x3C26E8;

    // State
    // 10 - Menu and Loading
    // 42 - Video
    // 46 - In Game
    int gameState3: "Shock2.exe", 0x622254;
}

startup
{
    // Split data
    // Item1 - Split title
    // Item2 - Split id
    // Item3 - Previous map
    // Item4 - Current map
    vars.splitsData = new Tuple<string, string, string, string>[]
    {
        Tuple.Create("Earth",               "earth",               "earth.mis",    "station.mis"),
        Tuple.Create("Space Station",       "space_station",       "___",  "___"), // Has special conditions
        Tuple.Create("MedSci 1",            "medsci1_1",            "MedSci1.mis",  "eng1.mis"), 
        Tuple.Create("Engineering",         "engineering",         "eng1.mis",     "MedSci1.mis"),
        Tuple.Create("MedSci 2",            "medsci1_2",            "MedSci1.mis",  "Hydro2.mis"),
        Tuple.Create("Hydroponics",         "hydroponics",         "Hydro2.mis",   "Rec1.mis"),
        Tuple.Create("Recreational",        "recreational",        "Rec1.mis",     "command1.mis"),
        Tuple.Create("Command",             "command",             "command1.mis", "rick1.mis"),
        Tuple.Create("Rickenbacker Pod 1",  "rickenbacker_pod_1",  "rick1.mis",    "Rick2.mis"),
        Tuple.Create("Rickenbacker Pod 2",  "rickenbacker_pod_2",  "Rick2.mis",    "Rick3.mis"),
        Tuple.Create("Rickenbacker Bridge", "rickenbacker_bridge", "Rick3.mis",    "Many.mis"),
        Tuple.Create("Body Of The Many",    "body_of_the_many",    "Many.mis",     "shodan.mis"),
        Tuple.Create("Where Am I?",         "where_am_i",          "___",          "___") //Has special conditions
    };

    settings.Add("Any", false, "Any%");
    foreach (var d in vars.splitsData)
	{
	    settings.Add(d.Item2 + "_any", false, d.Item1, "Any");
    }

    vars.completedSplits = new HashSet<string>();
}

isLoading
{
    if (current.gameState1 == 0 && current.gameState2 == 8 && current.gameState3 == 10 && current.isLoading == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

onStart
{
    vars.completedSplits.Clear();
}

start
{
    if (current.mapName == "earth.mis" && current.gameState3 == 46 && old.gameState3 == 10)
    {
        return true;
    }
}

split
{
    for (int i = 0; i < vars.splitsData.Length; i++)
    {
        if (settings["space_station" + "_any"] == true
        && current.mapName.ToLower() == "MedSci1.mis".ToLower()
        && current.gameState3 == 46
        && vars.completedSplits.Add("space_station" + "_any"))
        {
            return true;
        }

        if (settings["where_am_i" + "_any"] == true
        && current.mapName.ToLower() == "shodan.mis".ToLower()
        && old.gameState3 == 46
        && current.gameState3 == 42
        && vars.completedSplits.Add("where_am_i" + "_any"))
        {
            return true;
        }

        if (settings[vars.splitsData[i].Item2 + "_any"] == true
        && old.mapName.ToLower() == vars.splitsData[i].Item3.ToLower()
        && current.mapName.ToLower() == vars.splitsData[i].Item4.ToLower()
        && vars.completedSplits.Add(vars.splitsData[i].Item2 + "_any"))
        {
            return true;
        }
    }
}