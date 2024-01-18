state("Doom3", "Steam")
{
    bool isLoading : 0x12BAF5D;
    bool isCutscene : "gamex86.dll", 0x43F408;
    string255 lvlName : 0x00565AE4, 0x4;
    int cdHealth : "gamex86.dll", 0x001EF4C0, 0xBC;
}

state("dhewm3", "dhewm3-1.5.0")
{
    bool isLoading : 0x242AEB9;
    bool isCutscene : "base.dll", 0x4FA858;
}

state("Doom3.exe", "dhewm3-1.5.0")
{
    bool isLoading : 0x242AEB9;
    bool isCutscene : "base.dll", 0x4FA858;
}

state("dhewm3", "dhewm3-1.5.1")
{
    bool isLoading : 0x59F364;
    bool isCutscene : "base.dll", 0x51D7E0;
}

state("Doom3.exe", "dhewm3-1.5.1")
{
    bool isLoading : 0x59F364;
    bool isCutscene : "base.dll", 0x51D7E0;
}

state("Doom3BFG", "BFG-Steam")
{
    bool isLoading : 0x4B56D4;
    bool isCutscene : 0xC8EB2C;
}

/*
    isLoading
        0: game
        1: creating quick save or loading
    isCutscene
        0: game
        1: cutscene
    isIntro
        "generated/swf/doomintro.bswf": when playing intro
    cdHealth
        4000 (At the start of the bosfight): Cyberdemon health decreases by 1000 when using Soul Cube
*/

state("Doom3BFG", "RBDOOM3-1.1.0-preview3")
{
    bool isLoading : 0x19B3E89;
    bool isCutscene : 0x1848150;
    string255 lvlName : 0x14BA4A4;
    string255 isIntro : 0x11FA9C0;
    int cdHealth : 0x014C9D38, 0xD8;
}

state("RBDoom3BFG", "RBDOOM3-1.1.0-preview3")
{
    bool isLoading : 0x19B3E89;
    bool isCutscene : 0x1848150;
    string255 lvlName : 0x14BA4A4;
    string255 isIntro : 0x11FA9C0;
    int cdHealth : 0x014C9D38, 0xD8;
}

state("Doom3BFG", "RBDOOM3-1.2.0-preview1")
{
    bool isLoading : 0x278CCE1;
    bool isCutscene : 0x249A92C;
    string255 lvlName : 0x1E592BC;
    string255 isIntro : 0x770FD8;
    int cdHealth : 0x01E6D3C8, 0x168;
}

state("RBDoom3BFG", "RBDOOM3-1.2.0-preview1")
{
    bool isLoading : 0x278CCE1;
    bool isCutscene : 0x249A92C;
    string255 lvlName : 0x1E592BC;
    string255 isIntro : 0x770FD8;
    int cdHealth : 0x01E6D3C8, 0x168;
}

state("Doom3BFG", "RBDOOM3-1.4.0")
{
    bool isLoading : 0x2B7AD11;
    bool isCutscene : 0x288171C;
    string255 lvlName : 0x2B8B90C;
    string255 isIntro : 0xAD0078;
    int cdHealth : 0x022541B8, 0x168;
}

state("RBDoom3BFG", "RBDOOM3-1.4.0")
{
    bool isLoading : 0x2B7AD11;
    bool isCutscene : 0x288171C;
    string255 lvlName : 0x2B8B90C;
    string255 isIntro : 0xAD0078;
    int cdHealth : 0x022541B8, 0x168;
}

init
{
    vars.isLoading = false;
    switch (modules.First().ModuleMemorySize)
    {
        case 38739968: // 3.38 MB (3,549,696 bytes)
            version = "dhewm3-1.5.0";
            break;
        case 42106880: // 13.90 MB (14,598,144 bytes)
            version = "dhewm3-1.5.1";
            break;
        case 30056448: // 6.20 MB (6,510,592 bytes)
            version = "RBDOOM3-1.1.0-preview3";
            break;
        case 44576768: // 7.94 MB (8,332,288 bytes)
            version = "RBDOOM3-1.2.0-preview1";
            break;
        case 48799744: // 11.4 MB (12 017 664 bytes)
            version = "RBDOOM3-1.4.0";
            break;
        case 15675392: // 5.46 MB (5,727,368 bytes)
            version = "BFG-Steam";
            break;
        case 41897984: // 5.57 MB (5,840,896 bytes)
            version = "Steam";
            break;
        default:
            print("Unknown DOOM 3 version.");
            break;
    }
}

startup
{
    settings.Add("skipLoading", true, "Do not include loading screens in the game time.");
    settings.Add("skipCutscenes", true, "Do not include cutscenes in the game time.");

    // Data for splits
    // Item1: Split name for settings
    // Item2: Split id for settings
    // Item3: Map which you leave
    // Item4: Map you enter
    vars.lvlData = new Tuple<string, string, string, string>[]
    {
        Tuple.Create("Mars City", "mars_city1", "game/mars_city1", "game/mc_underground"),
        Tuple.Create("Mars City Underground", "mc_underground", "game/mc_underground", "game/mars_city2"),
        Tuple.Create("Mars City 2", "mars_city2", "game/mars_city2", "game/admin"),
        Tuple.Create("UAC Administration", "admin", "game/admin", "game/alphalabs1"),
        Tuple.Create("Alpha Labs Sector 1", "alphalabs1", "game/alphalabs1", "game/alphalabs2"),
        Tuple.Create("Alpha Labs Sector 2", "alphalabs2", "game/alphalabs2", "game/alphalabs3"),
        Tuple.Create("Alpha Labs Sector 3", "alphalabs3", "game/alphalabs3", "game/alphalabs4"),
        Tuple.Create("Alpha Labs Sector 4", "alphalabs4", "game/alphalabs4", "game/enpro"),
        Tuple.Create("Enpro Plant", "enpro", "game/enpro", "game/commoutside"),
        Tuple.Create("Communications Transfer", "commoutside", "game/commoutside", "game/comm1"),
        Tuple.Create("Communications", "comm1", "game/comm1", "game/recycling1"),
        Tuple.Create("Monorail Skybridge", "recycling1", "game/recycling1", "game/recycling2"),
        Tuple.Create("Recycling Sector", "recycling2", "game/recycling2", "game/monorail"),
        Tuple.Create("Monorail", "monorail", "game/monorail", "game/delta1"),
        Tuple.Create("Delta Labs Sector 1", "delta1", "game/delta1", "game/delta2a"),
        Tuple.Create("Delta Labs Sector 2a", "delta2a", "game/delta2a", "game/delta2b"),
        Tuple.Create("Delta Labs Sector 2b", "delta2b", "game/delta2b", "game/delta3"),
        Tuple.Create("Delta Labs Sector 3", "delta3", "game/delta3", "game/delta4"),
        Tuple.Create("Delta Labs Sector 4", "delta4", "game/delta4", "game/hell1"),
        Tuple.Create("Hell", "hell1", "game/hell1", "game/delta5"),
        Tuple.Create("Delta Labs Sector 5", "delta5", "game/delta5", "game/cpu"),
        Tuple.Create("Central Processing", "cpu", "game/cpu", "game/cpuboss"),
        Tuple.Create("Central Server Banks", "cpuboss", "game/cpuboss", "game/site3"),
        Tuple.Create("Site 3", "site3", "game/site3", "game/caverns1"),
        Tuple.Create("Caverns Area 1", "caverns1", "game/caverns1", "game/caverns2"),
        Tuple.Create("Caverns Area 2", "caverns2", "game/caverns2", "game/hellhole"),
        Tuple.Create("Primary Excavation Site", "hellhole", "game/hellhole", "-"),
    };

    settings.Add("doom3", false, "AutoSplitter: Doom 3");
	foreach (var lvlDoom3 in vars.lvlData)
	{
		settings.Add(lvlDoom3.Item2, true, lvlDoom3.Item1, "doom3");
	}
}

update
{
    if (version == "")
    {
        return false;
    }

    vars.isLoading = (current.isLoading && settings["skipLoading"]) || (current.isCutscene && settings["skipCutscenes"]);
}

start
{
    if (version == "RBDOOM3-1.1.0-preview3" || version == "RBDOOM3-1.2.0-preview1" || version == "RBDOOM3-1.4.0")
    {
        return current.isIntro == "generated/swf/doomintro.bswf";
    }
    if (version == "Steam")
    {
        return current.isLoading == true && old.isLoading == false;
    }
}

split
{
    if (version == "RBDOOM3-1.1.0-preview3" || version == "RBDOOM3-1.2.0-preview1" || version == "RBDOOM3-1.4.0")
    {
        for (int i = 0; i < vars.lvlData.Length; i++)
        {
            if (settings[vars.lvlData[i].Item2] == true && old.lvlName == vars.lvlData[i].Item3 && current.lvlName == vars.lvlData[i].Item4)
            {
                return true;
            }
        }

        // End
        if (settings["hellhole"] == true && current.cdHealth == 0 && old.cdHealth == 1000)
        {
            return true;
        }
    }
    
    if (version == "Steam") {
        for (int i = 0; i < vars.lvlData.Length; i++)
        {
            if (settings[vars.lvlData[i].Item2] == true && old.lvlName == ("/" + vars.lvlData[i].Item3) && current.lvlName == "/" + vars.lvlData[i].Item4)
            {
                return true;
            }
        }

        // End
        if (settings["hellhole"] == true && current.cdHealth == 0 && old.cdHealth == 1000)
        {
            return true;
        }
    }
}

isLoading
{
    if ((version == "RBDOOM3-1.1.0-preview3" || version == "RBDOOM3-1.2.0-preview1" || version == "RBDOOM3-1.4.0") && current.isIntro == "generated/swf/doomintro.bswf")
    {
        return false;
    }
    else
    {
        return vars.isLoading;
    }
}
