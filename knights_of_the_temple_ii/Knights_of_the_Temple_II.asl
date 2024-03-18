state("KOTT2", "Playlogic")
{
    string255 map: "KOTT2.exe", 0x002C5220, 0xAC;
    int loading: "KOTT2.exe", 0x2A98D8;
    int video: "KOTT2.exe", 0x2C6CE4;
    float boss: "KOTT2.exe", 0x0022EEB4, 0x554, 0x118;
}

state("KOTT2", "Akella")
{
    string255 map: "KOTT2.exe", 0x002C51E0, 0xAC;
    int loading: "KOTT2.exe", 0x2A9898;
    int video: "KOTT2.exe", 0x2C6CA4;
    float boss: "KOTT2.exe", 0x0022EEB4, 0x554, 0x118;
}

init
{
    switch (modules.First().ModuleMemorySize)
    {
        case 3616768:
            version = "Playlogic";
            break;
        case 3502080:
            version = "Akella";
            break;
        default:
            print("Unknown version.");
            break;
    }
}

startup
{
    // Item1 - Map you leave (old)
    // Item2 - Map you enter (current)
    // Item3 - Split Name
    // Item4 - ID for settings
    vars.splitsData = new Tuple<string, string, string, string>[]
    {
        Tuple.Create("100fight", "110slums", "Siege of Ylgar", "100fight"),
        Tuple.Create("110slums", "111slums", "The city under fire", "110slums"),
        Tuple.Create("111slums", "140gladi", "The city under fire... (Boss)", "111slums"),
        Tuple.Create("140gladi", "170djafr", "At the Sea Serpent", "140gladi"),
        Tuple.Create("170djafr", "180port", "City of Ylgar", "170djafr"),
        // Harbor of Ylgar > Island of the Dead
        Tuple.Create("180port", "300islan", "Harbor of Ylgar", "180port"),
        Tuple.Create("300islan", "340manua", "Island of the Dead (Arrival)", "300islan_a"),
        Tuple.Create("340manua", "360crab", "Reviving chambers", "340manua"),
        Tuple.Create("360crab", "370astro", "The Guardian", "360crab"),
        Tuple.Create("370astro", "390quint", "The Great Portal", "370astro"),
        Tuple.Create("390quint", "300islan", "Bone Guard", "390quint"),
        // Island of the Dead > Yusra
        Tuple.Create("300islan", "200retur", "Island of the Dead (Departure)", "300islan_d"),
        Tuple.Create("200retur", "190agra", "Yusra - port", "200retur"),
        Tuple.Create("190agra", "210prisn", "Yusra - downtown", "190agra"),
        Tuple.Create("210prisn", "220catac", "Cells 1", "210prisn_1"),
        Tuple.Create("220catac", "210prisn", "Abandoned part", "220catac"),
        Tuple.Create("210prisn", "211lift", "Cells 2", "210prisn_2"),
        Tuple.Create("211lift", "230boss", "Dark way down", "211lift"),
        Tuple.Create("230boss", "270roof", "Chamber of the Shepherd", "230boss"),
        Tuple.Create("270roof", "280escap", "Escape on the roofs", "270roof"),
        // Yusra > Sirmium
        Tuple.Create("280escap", "021sir", "They are coming", "280escap"),
        Tuple.Create("021sir", "040stret", "The harbor of Sirmium (Arrival)", "021sir_1"),
        Tuple.Create("040stret", "021sir", "The streets of Sirmium (Taking quest)", "040stret_1"),
        Tuple.Create("021sir", "040stret", "The harbor of Sirmium (Necklace)", "021sir_2"),
        Tuple.Create("032sirc", "020floa", "The streets of Sirmium (Key)", "032sirc_k"),
        Tuple.Create("020floa", "020floor", "Desecrated temple - floor (The Eye)", "020floa"),
        Tuple.Create("020floor", "030floor", "Desecrated temple - floor", "020floor"),
        Tuple.Create("030floor", "040stret", "Desecrated temple - basement", "030floor"),
        Tuple.Create("040stret", "021sir", "The streets of Sirmium", "040stret_2"),
        // Sirmium > Gate
        Tuple.Create("021sir", "440gate", "The harbor of Sirmium (Departure)", "021sir_g")
    };

    settings.Add("Any", false, "Any%");
    foreach (var d in vars.splitsData)
	{
	    settings.Add(d.Item4, false, d.Item3, "Any");
    }

    settings.Add("440gate", false, "Gate", "Any");

    settings.Add("Tutorial", false, "Tutorial%");
    settings.Add("860hall", false, "Trainings halls", "Tutorial");

    vars.completedSplits = new HashSet<string>();
    vars.bossPhase = false;
}

onStart
{
    vars.completedSplits.Clear();
    vars.bossPhase = false;
}

start
{
    if (current.map == "100fight" && current.loading > 0 && old.loading == 0
        || current.map == "860hall" && current.loading > 0 && old.loading == 0
        || current.map == "200retur" && current.loading > 0 && old.loading == 0
        || current.map == "021sir" && current.loading > 0 && old.loading == 0)
    {
        return true;
    }
}

reset
{
    if (current.map == "890birka")
    {
        return true;
    }
}

update
{
    // Boss in second phase
    if (current.map == "440gate"
        && current.boss > 65f
        && current.boss < 67f)
    {
        vars.bossPhase = true;
    }
}

split
{
    if (settings["860hall"] == true
        && current.map == "020menu"
        && old.map == "860hall"
        && vars.completedSplits.Add("860hall"))
    {
        return true;
    }

    if (settings["440gate"] == true
        && current.map == "440gate"
        && current.boss < 40f
        && current.video == 1
        && old.video == 0
        && vars.bossPhase == true
        && vars.completedSplits.Add("440gate"))
    {
        return true;
    }

    for (int i = 0; i < vars.splitsData.Length; i++)
    {
        if (settings[vars.splitsData[i].Item4] == true
            && old.map == vars.splitsData[i].Item1
            && current.map == vars.splitsData[i].Item2
            && vars.completedSplits.Add(vars.splitsData[i].Item4))
        {
            return true;
        }
    }
}

isLoading
{
    if(current.loading == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}