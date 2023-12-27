state("COLDWAR.EX")
{
    // missionId
    // Change valude on loading screen
    // 1...23
    // 0 = main menu
    int missionId: "COLDWAR.EX", 0xB19C400;

    // loadingScreen
    // 1 - loading (at the end Loading Screen)
    // 0 - any
    byte loadingScreen: "COLDWAR.EX", 0x17DFA57;

    // loadingScreenEnter
    // 1 - press enter
    // 0 - any
    byte loadingScreenEnter: "COLDWAR.EX", 0x18BAA35;

    // engineVideo
    // 1 - engine video
    // 0 - any
    byte engineVideo: "COLDWAR.EX", 0x15B0C6C;

    // loading
    // 1 - game
    // 0 - loading
    byte loading: "COLDWAR.EX", 0x1798EC7;
}

startup
{
    vars.Completed = new HashSet<string>();

    vars.missionData = new Tuple<string, string, int>[]
    {
        Tuple.Create("1", "Pulitzer, here I come!", 2),
        Tuple.Create("2", "On the Run", 3),
        Tuple.Create("3", "Jail Break", 4),
        Tuple.Create("4", "Sneaking Around", 5),
        Tuple.Create("5", "Investigative Journalism", 6),
        Tuple.Create("6", "Guerllia in the Mist", 7),
        Tuple.Create("7", "Twins", 8),
        Tuple.Create("8", "Getting Out", 9),
        Tuple.Create("9", "An Uninvited Guest", 10),
        Tuple.Create("10", "Stalking the Prey", 11),
        Tuple.Create("11", "Destination Sonya", 12),
        Tuple.Create("12", "Never Ask a Girl her Weight", 13),
        Tuple.Create("13", "Blackout", 14),
        Tuple.Create("14", "Synchronized Watches", 15),
        Tuple.Create("15", "Follow the Leader", 16),
        Tuple.Create("16", "Thanks, Mr Geiger", 17),
        Tuple.Create("17", "Exposed", 18),
        Tuple.Create("18", "Meltdown", 19),
        Tuple.Create("19", "The Halls of Hell", 20),
        Tuple.Create("20", "Hello, Mr President", 21),
        Tuple.Create("21", "Escort Service", 22),
        Tuple.Create("22", "Power Play", 23),
        //Tuple.Create("23", "The Curtain Falls"),
    };

    foreach (var d in vars.missionData)
	{
	    settings.Add(d.Item1, false, d.Item2);
    }
}

start
{
    if (current.missionId == 0 && old.missionId == 0)
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
    for (int i = 0; i < vars.missionData.Length; i++)
    {
        if (settings[vars.missionData[i].Item1] == true
            && current.missionId == (old.missionId + 1)
            && current.missionId == vars.missionData[i].Item3
            && vars.Completed.Add(vars.missionData[i].Item1))
        {
            return true;
        }
    }
}

isLoading
{
    if (((current.loadingScreen == 1 || current.loadingScreenEnter == 1) && current.engineVideo == 0)
        || current.loading == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}
