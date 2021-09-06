state("sekhmet_x64")
{
    // level
    // 0  - LEVEL R (Reactor level)
    // 1  - LEVEL 1 (Hospital level)
    // 2  - LEVEL 2 (Research level)
    // 3  - LEVEL 3 (Maintenance level)
    // 4  - LEVEL 4 (Storage level)
    // 5  - LEVEL 5 (Flight Deck)
    // 6  - LEVEL 6 (Executive level)
    //      11 - G4 - Delta Grove
    //      12 - G1 - Alpha Grove
    //      13 - G2 - Beta Grove
    // 7  - LEVEL 7 (Engineering level)
    // 8  - LEVEL 8 (Security level)
    // 9  - LEVEL 9 (Bridge)
    // 10 - Shodan
    int level: "sekhmet_x64.exe", 0x9986CC;

    // cutscene (work slowly)
    // 0 - Death
    // 1 - Intro
    // 2 - Ending
    int cutscene: "sekhmet_x64.exe", 0x9998FB;
    
    // menuState
    // 3 - Menu
    // 5 - New Game
    int menuState: "sekhmet_x64.exe", 0x10CEECC;

    // shockArray
    // [2] 
    // Level 1: 14 Game start
    // Level 1: 14-2 Open door by switch (door about elevator)
    // Level 0: (14 or 12)+32 Insert isotope
    // Level 0: (14 or 12)+32+64 Generator Ready
    // Level 0: (14 or 12)+32+64+128 Activate shield
    // [3]
    // Level 2: 1 Activate laser
    // Level 3: 65 Insert demodulator
    // Level 6: 65+4 Activate G4
    // Level 6: 65+4+8 Activate G1
    // Level 6: 65+4+8+16 Activate G2
    // Level 6: 65+4+8+16+128 Launch grove
    byte255 shockArray: "sekhmet_x64.exe", 0xDD7F26;
}

startup
{
    // Settings
    settings.Add("level1", false, "Hospital (1 > 2)");
    settings.SetToolTip("level1", "Split after going to the Research level. No mission check.");

    settings.Add("level2", false, "Research (2 > 3)");
    settings.SetToolTip("level2", "Split after going to the Maintenance level. No mission check.");

    settings.Add("level2m", false, "Research + Reactor (2 > 0 > 2 > 3)");
    settings.SetToolTip("level2m", "Split when the laser has been activated and you have passed to the third level. With mission check.");

    settings.Add("level3", false, "Maintenance (3 > 6)");
    settings.SetToolTip("level3", "Split after going to the Executive level. No mission check.");

    settings.Add("level3m", false, "Maintenance (3 + Demodulator > 6)");
    settings.SetToolTip("level3m", "After replacing the demodulator and moving to the Executive level. With mission check.");

    settings.Add("level6", false, "Executive (6 > 7)");
    settings.SetToolTip("level6", "Split after going to the Engineering level. No mission check.");

    settings.Add("level6m", false, "Executive (6 + Grove > 7)");
    settings.SetToolTip("level6m", "Split after launching the Beta Grove and going to the Engineering level. With mission check.");

    settings.Add("level7", false, "Engineering (7 > 8)");
    settings.SetToolTip("level7", "Split after going to the Security level. No mission check.");

    settings.Add("level8", false, "Security (8 > 9)");
    settings.SetToolTip("level8", "Split after going to the Bridge. No mission check.");

    settings.Add("level9", false, "Bridge (9 > Shodan)");
    settings.SetToolTip("level9", "Split after going to the Shodan. No mission check.");

    //settings.Add("level10", false, "Shodan");

    // Visited levels
    vars.visitedLevels = new bool[11];

    vars.OnReset = (LiveSplit.Model.Input.EventHandlerT<TimerPhase>) ((s, e) => {
        for (int i = 0; i < vars.visitedLevels.Length; i++)
        {
            vars.visitedLevels[i] = false;
        }
    });
    
    timer.OnReset += vars.OnReset;
}

update
{
	print("SS1 | " + "Current level: " + current.level + " | " + "Old level: " + old.level);
	print("SS1 | " + "Current menuState: " + current.menuState + " | " + "Old menuState: " + old.menuState);
	print("SS1 | " + "Current shockArray[3]: " + current.shockArray[3] + " | " + "Old shockArray[3]: " + old.shockArray[3]);
	print("SS1 | " + "Current shockArray[2]: " + current.shockArray[2] + " | " + "Old shockArray[2]: " + old.shockArray[2]);
}

reset
{
    if (current.menuState == 5 && old.menuState == 3)
    {      
        return true;
    }
}

split
{
    if (settings["level1"] && current.level == 2 && old.level == 1 && vars.visitedLevels[0] == false)
    {
        vars.visitedLevels[0] = true;
        return true;
    }

    if (settings["level2"] && current.level == 3 && (old.level == 2 || old.level == 0) && vars.visitedLevels[1] == false)
    {
        vars.visitedLevels[1] = true;
        return true;
    }

    if (settings["level2m"] && current.level == 3 && (old.level == 2 || old.level == 0) && current.shockArray[3] == 1 && vars.visitedLevels[2] == false)
    {
        vars.visitedLevels[2] = true;
        return true;
    }

    if (settings["level3"] && current.level == 6 && old.level == 3 && vars.visitedLevels[3] == false)
    {
        vars.visitedLevels[3] = true;
        return true;
    }

    if (settings["level3m"] && current.level == 6 && old.level == 3 && current.shockArray[3] == 65 && vars.visitedLevels[4]== false)
    {
        vars.visitedLevels[4] = true;
        return true;
    }

    if (settings["level6"] && current.level == 7 && old.level == 6 && vars.visitedLevels[5] == false)
    {
        vars.visitedLevels[5] = true;
        return true;
    }

    if (settings["level6m"] && current.level == 7 && old.level == 6 && current.shockArray[3] == 221 && vars.visitedLevels[6] == false)
    {
        vars.visitedLevels[6] = true;
        return true;
    }

    if (settings["level7"] && current.level == 8 && old.level == 7 && vars.visitedLevels[7] == false)
    {
        vars.visitedLevels[7] = true;
        return true;
    }

    if (settings["level8"] && current.level == 9 && old.level == 8 && vars.visitedLevels[8] == false)
    {
        vars.visitedLevels[8] = true;
        return true;
    }

    if (settings["level9"] && current.level == 10 && old.level == 9 && vars.visitedLevels[9] == false)
    {
        vars.visitedLevels[9] = true;
        return true;
    }
        
}

exit
{
    timer.OnReset -= vars.OnReset;
}