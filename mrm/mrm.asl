state("ePSXe", "2.0.5")
{
    // raceNumber
    // Number of the current track in the league
    // 0:Ghost Town / Swamp
    // 1:Mallory Gallery / Happiness Hotel
    // 2:New York City / Central Park
    // 3:Graveyard Old / London Town
    // 4:Treasure Island / Dock
    // 5:Cape Doom Secret / Base
    byte raceNumber: "ePSXe.exe", 0xB32E58;

    // raceEnd
    // Changes the value to a random number after the finish
    // 0: menu, race
    // !=0: after finish (screen with position)
    int raceEnd: "ePSXe.exe", 0xB454B6;

    // loading
    // 1: loading screen
    // 0: menu, race etc.
    byte loading: "ePSXe.exe", 0xB32FFE;
}

init
{
    switch (modules.First().ModuleMemorySize)
    {
        case 25337856: // 1.21 MB (1 278 464 bytes)
            version = "2.0.5";
            break;
        default:
            version = "Unknown version.";
            break;
    }
}

startup
{
    settings.Add("split_ab", true, "Autosplitter for Tournaments (League A+B, Solo)");
}

isLoading
{
    return current.loading == 1;
}

split
{
    // "current.raceNumber != 6" to prevent splitting on the screen "TOURNAMENT CHAMPION"
    if (settings["split_ab"] == true && current.raceEnd != 0 && old.raceEnd == 0 && current.raceNumber != 6)
    {
        return true;
    }
}