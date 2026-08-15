state("rsvcrt.dll")
{
    // Current level name
    string15 level: "PowerRender.dll", 0x189244;

    // Devil1 hp
    int devil1: "Rsvcrt.dll", 0x000B00B8, 0x0, 0x10, 0x2C, 0x74, 0x8, 0x28, 0x20;

    // Loading resources
    string255 resources: "PowerRender.dll", 0x1A70CC;

}

startup
{
    vars.Completed = new HashSet<string>();

    vars.levelData = new Tuple<int, string, string>[]
    {
        Tuple.Create(1, "PALACE.DAT", "CITY.DAT"), 
        Tuple.Create(2, "CITY.DAT", "DUMPS.DAT"),
        Tuple.Create(3, "DUMPS.DAT", "SEVERS.DAT"),
        Tuple.Create(4, "SEVERS.DAT", "CAMP.DAT"),
        Tuple.Create(5, "CAMP.DAT", "OASIS.DAT"),
        Tuple.Create(6, "OASIS.DAT", "MOUNTAIN.DAT"),
        Tuple.Create(7, "MOUNTAIN.DAT", "PETRA.DAT"),
        Tuple.Create(8, "PETRA.DAT", "CAVES.DAT"),
        Tuple.Create(9, "CAVES.DAT", "FOREST.DAT"),
        Tuple.Create(10, "FOREST.DAT", "PETRA.DAT"),
        Tuple.Create(11, "PETRA.DAT", "SWAMPS.DAT"),
        Tuple.Create(12, "SWAMPS.DAT", "BATTLEFIELD.DAT"),
        Tuple.Create(13, "Devil1", "Devil1")
    };

    foreach (var i in vars.levelData)
    {
        settings.Add(i.Item1.ToString(), false, i.Item2);
    }
}

start
{
    if (old.resources != "PSWORD.chr" && current.resources == "PSWORD.chr")
    {
        return true;
    }
}

reset
{
    // if (old.resources != "PSWORD.chr" && current.resources == "PSWORD.chr")
    // {
    //     return true;
    // }
}

onStart
{
    vars.Completed.Clear();
}

split 
{
    if (current.level == "BATTLEFIELD.DAT" && current.devil1 == 0 && old.devil1 > 0)
    {
        return true;
    }

    for (int i = 0; i < vars.levelData.Length; i++)
    {
        if (settings[vars.levelData[i].Item1.ToString()] == true
            && current.level == vars.levelData[i].Item3
            && old.level == vars.levelData[i].Item2
            && vars.Completed.Add(vars.levelData[i].Item1.ToString()))
        {
            return true;
        }
    }
}

isLoading
{
    // if (current.resources != "PSWORD.chr")
    // {
    //     return true;
    // }
    // else
    // {
    //     return false;
    // }
}

exit
{
    vars.IsGameTimePaused = true;
}