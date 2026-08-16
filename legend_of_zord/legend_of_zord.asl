state("rsvcrt.dll")
{
    // Current level name
    string15 level: "PowerRender.dll", 0x189244;

    // Devil1 hp
    // 0 - 200
    int devil1: "Rsvcrt.dll", 0x000B00B8, 0x0, 0x10, 0x2C, 0x74, 0x8, 0x28, 0x20;

    // Loading resources
    string255 resources: "PowerRender.dll", 0x1A70CC;

    // Loading
    // 1 - loading resources
    // 0 - resources loaded
    byte resourcesLoading: "PowerRender.dll", 0x1A70C8;
}

startup
{
    vars.Completed = new HashSet<string>();

    vars.levelData = new Tuple<int, string, string, string>[]
    {
        Tuple.Create(1, "PALACE.DAT", "CITY.DAT", "Palace"), 
        Tuple.Create(2, "CITY.DAT", "DUMPS.DAT", "City"),
        Tuple.Create(3, "DUMPS.DAT", "SEVERS.DAT", "Dumps"),
        Tuple.Create(4, "SEVERS.DAT", "CAMP.DAT", "Severs"),
        Tuple.Create(5, "CAMP.DAT", "OASIS.DAT", "Camp"),
        Tuple.Create(6, "OASIS.DAT", "MOUNTAIN.DAT", "Oasis"),
        Tuple.Create(7, "MOUNTAIN.DAT", "PETRA.DAT", "Mountain"),
        Tuple.Create(8, "PETRA.DAT", "CAVES.DAT", "Petra 1"),
        Tuple.Create(9, "CAVES.DAT", "FOREST.DAT", "Caves"),
        Tuple.Create(10, "FOREST.DAT", "PETRA.DAT", "Forest"),
        Tuple.Create(11, "PETRA.DAT", "SWAMPS.DAT", "Petra 2"),
        Tuple.Create(12, "SWAMPS.DAT", "BATTLEFIELD.DAT", "Swamps"),
        Tuple.Create(13, "Devil1", "Devil1", "Devil")
    };

    foreach (var i in vars.levelData)
    {
        settings.Add(i.Item1.ToString(), false, i.Item4);
    }
}

start
{
    if (old.resources != "PSWORD.chr" && current.resources == "PSWORD.chr")
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
    if (current.resourcesLoading == 1)
    {
        return true;
    }
    else
    {
        return false;
    }
}

exit
{
    vars.IsGameTimePaused = true;
}