state("AkibaUU")
{
    /*
    completedMissions
    each main and side mission
    */
    int completedMissions: "AkibaUU.exe", 0x4F6CFC;

    /*
    onMap
    player on the map with number onMap
    */
    int onMap: "AkibaUU.exe", 0x5324DC;
}

split {
    //Split prologue
    if (old.completedMissions == 0 && current.completedMissions == 0 && current.onMap == 3 && old.onMap == 25)
    {
        return true;
    }
    
    //Split each main and side mission after prologue
    if (current.completedMissions >= 1)
    {
        return current.completedMissions != old.completedMissions;
    }
}