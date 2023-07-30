state("SystemReShock-Win64-Shipping"){}

startup
{
    /*
    old - current - settings
    */
    vars.anyData = new Tuple<string, string, string>[]
    {
        Tuple.Create("None", "01_Medical", "Introduction"),
        Tuple.Create("01_Medical", "02_Research", "Medical"),
        Tuple.Create("02_Research", "00_Reactor", "Research 1"),
        Tuple.Create("00_Reactor", "02_Research", "Reactor"),
        Tuple.Create("02_Research", "03_Maintenance", "Research 2"),
        Tuple.Create("03_Maintenance", "05_FlightDeck", "Maintenance 1"),
        Tuple.Create("05_FlightDeck", "03_Maintenance", "Flight Deck"),
        Tuple.Create("03_Maintenance", "06_Executive", "Maintenance 2"),
        Tuple.Create("06_Executive", "07_SysEngineering", "Executive"),
        Tuple.Create("07_SysEngineering", "08_Security", "Engineering"),
        Tuple.Create("08_Security", "09_Bridge", "Security"),
        Tuple.Create("09_Bridge", "ShodanArena", "Bridge"),
        Tuple.Create("ShodanArena", "None", "SHODAN")
    };

    settings.Add("Any", false, "Any%");
    foreach (var sd in vars.anyData)
	{
		settings.Add(sd.Item3 + "_Any", false, sd.Item3, "Any");
    }

    vars.completedSplits = new HashSet<string>();
}

init
{
    var scn = new SignatureScanner(game, game.MainModule.BaseAddress, game.MainModule.ModuleMemorySize);
    var gameEngineTrg = new SigScanTarget(3, "48 39 35 ?? ?? ?? ?? 0F 85 ?? ?? ?? ?? 48 8B 0D") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var gameEngine = scn.Scan(gameEngineTrg);
    var syncLoadTrg = new SigScanTarget(5, "89 43 60 8B 05") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var syncLoadCounter = scn.Scan(syncLoadTrg);
    var uWorldTrg = new SigScanTarget(8, "0F 2E ?? 74 ?? 48 8B 1D ?? ?? ?? ?? 48 85 DB 74") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var uWorld = scn.Scan(uWorldTrg);
    var fNamePoolTrg = new SigScanTarget(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var fNamePool = scn.Scan(fNamePoolTrg);

    if(gameEngine == IntPtr.Zero || syncLoadCounter == IntPtr.Zero || fNamePool == IntPtr.Zero || uWorld == IntPtr.Zero)
    {
        throw new Exception("One or more base pointers not found - retrying");
    }

    vars.Watchers = new MemoryWatcherList
    {
        new MemoryWatcher<int>(new DeepPointer(gameEngine, 0xD28, 0x490)) { Name = "levelLoadCount"},
        new MemoryWatcher<ulong>(new DeepPointer(gameEngine, 0xD28, 0x700)) { Name = "loadingScreenPtr"},
        new MemoryWatcher<ulong>(new DeepPointer(gameEngine, 0xD28, 0x1D8)) { Name = "levelFName"},
        new MemoryWatcher<ulong>(new DeepPointer(uWorld, 0x18)) { Name = "worldFName"},
        new MemoryWatcher<int>(new DeepPointer(syncLoadCounter)) { Name = "syncLoadCount" },
    };

    vars.FNameToString = (Func<ulong, string>)(fName =>
    {
        var number   = (fName & 0xFFFFFFFF00000000) >> 0x20;
        var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
        var nameIdx  = (fName & 0x000000000000FFFF) >> 0x00;

        var chunk = game.ReadPointer(fNamePool + 0x10 + (int)chunkIdx * 0x8);
        var nameEntry = chunk + (int)nameIdx * 0x2;

        var length = game.ReadValue<short>(nameEntry) >> 6;
        var name = game.ReadString(nameEntry + 0x2, length);

        return number == 0 ? name : name + "_" + number;
    });
}

update
{
    vars.Watchers.UpdateAll(game);
    current.level = vars.FNameToString(vars.Watchers["levelFName"].Current);
    current.world = vars.FNameToString(vars.Watchers["worldFName"].Current);
    current.loading = vars.Watchers["loadingScreenPtr"].Current != 0 
        || vars.Watchers["levelLoadCount"].Current != 0
        || vars.Watchers["syncLoadCount"].Current != 0;
}

onStart
{
    vars.completedSplits.Clear();
}

start
{
    if (current.world == "Introduction" && old.world == "00_Menu")
    {
        return true;
    }
}

split
{
    for (int i = 0; i < vars.anyData.Length; i++)
    {
        if (settings[vars.anyData[i].Item3 + "_Any"] == true
        && old.level == vars.anyData[i].Item1
        && current.level == vars.anyData[i].Item2
        && vars.completedSplits.Add(vars.anyData[i].Item3 + "_Any"))
        {
            return true;
        }
    }
}

isLoading
{
    return current.loading;
}