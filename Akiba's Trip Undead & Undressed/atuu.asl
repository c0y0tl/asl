state("AkibaUU")
{
    /*
    gameState
    0 menu, video, credits
    1 loading
    2 open world
    3 cut-scene, mission, dialog
    */
    int gameState: "AkibaUU.exe", 0x4929E8;

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
    // Split end train run
    if (current.onMap == 1 && current.leavAkiba == 151 && current.completedMissions == 0) {
        return true;
    }
    // Split prologue
    if (old.completedMissions == 0 && current.completedMissions == 0 && current.onMap == 3 && old.onMap == 25) {
        return true;
    }
    // Split each main and side mission after prologue
    if (current.completedMissions >= 1) {
        return current.completedMissions != old.completedMissions;
    }   
}

isLoading
{
    if (current.gameState == 1)
    {
        return true;
    }
    return false;
}
