state("ePSXe")
{
    // currentLap
    // +1 when crossing the finish line
    byte currentLap: "ePSXe.exe", 0xB45587;

    // loading
    // 1: loading screen
    // 0: menu, race etc.
    byte loading: "ePSXe.exe", 0xB32FFE;
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
    if (settings["split_ab"] == true && old.currentLap == 2 && current.currentLap == 3)
    {
        return true;
    }
}