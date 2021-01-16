state("AkibaUU")
{
    /*
    completedMissions
    each main and side mission
    */
    int completedMissions: "AkibaUU.exe", 0x4B272C;

    /*
    onMap
    player on the map with number onMap
    */
    int onMap: "AkibaUU.exe", 0x4EDF0C;

    /*
    leavAkiba
    Leav Akihabara
    */
    int leavAkiba: "AkibaUU.exe", 0x468B2C;
}

split {
    // Split end for train run
    if (current.onMap == 1 && current.leavAkiba == 151 && current.completedMissions == 0)
    {
        return true;
    }
    // Split prologue
    if (old.completedMissions == 0 && current.completedMissions == 0 && current.onMap == 3 && old.onMap == 25)
    {
        return true;
    }
    // Split each main and side mission after prologue
    if (current.completedMissions >= 1)
    {
        return current.completedMissions != old.completedMissions;
    }
}