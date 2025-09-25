state("mgsvtpp")
{
    // Mission ID
    // 3XXXX - Open world
    // 4XXXX - Helicopter
    // 1XXXX - Episodes
    int missionId: "mgsvtpp.exe", 0x2950830;

    // Score pages
    // 1..3 - Score screen
    // ?? - Other
    int scorePages: "mgsvtpp.exe", 0x02B51390, 0x70, 0x280, 0x3D4;

    // Resume
    // 1 - When press "Resume ..."
    // 0 - Other
    int resume: "mgsvtpp.exe", 0x02A6F918, 0x3C;

    // Starting splash screen
    // 1 - Splash screen active
    // 0 - Other
    int splashScreen: "mgsvtpp.exe", 0x02A641D0, 0xEF0;

    // Loading screen
    // 1 / 256 - In game
    // 0 / 257 - Loading
    int isLoading: "mgsvtpp.exe", 0x02A6FBD8, 0x38, 0x60, 0x698;

    // Cutscene
    // 1 - In more cases Cutscene
    // 0 - Other
    // 2..3 - ??
    int isCutscene: "mgsvtpp.exe", 0x2A9C8C0;

    // Report
    // 1 - In more cases Report 
    // 0 - Other
    int isReport: "mgsvtpp.exe", 0x2A9C140;
}

startup
{
    vars.Completed = new HashSet<string>();

    vars.statusC1 = false;
    vars.cutsceneCounterC1 = 0;

    vars.statusC2 = false;
    vars.cutsceneCounterC2 = 0;

    vars.missionData = new Tuple<int, string>[]
    {
        Tuple.Create(10010, "Episode 0: Prologue: Awakening"),
        Tuple.Create(10020, "Episode 1: Phantom Limbs"),
        Tuple.Create(10030, "Episode 2: Diamond Dogs"),
        Tuple.Create(10036, "Episode 3: A Hero's Way"),
        Tuple.Create(10043, "Episode 4: C2W"),
        Tuple.Create(10033, "Episode 5: Over the Fence"),
        Tuple.Create(10040, "Episode 6: Where Do the Bees Sleep?"),
        Tuple.Create(10041, "Episode 7: Red Brass"),
        Tuple.Create(10044, "Episode 8: Occupation Forces"),
        Tuple.Create(10054, "Episode 9: Backup, Back Down"),
        Tuple.Create(10052, "Episode 10: Angel With Broken Wings"),
        Tuple.Create(10050, "Episode 11: Cloaked in Silence"),
        Tuple.Create(10070, "Episode 12: Hellbound"),
        Tuple.Create(10080, "Episode 13: Pitch Dark"),
        Tuple.Create(10086, "Episode 14: Lingua Franca"),
        Tuple.Create(10082, "Episode 15: Footprints of Phantoms"),
        Tuple.Create(10090, "Episode 16: Traitors' Caravan"),
        Tuple.Create(10091, "Episode 17: Rescue The Intel Agents"),
        Tuple.Create(10100, "Episode 18: Blood Runs Deep"),
        Tuple.Create(10195, "Episode 19: On the Trail"),
        Tuple.Create(10110, "Episode 20: Voices"),
        Tuple.Create(10121, "Episode 21: The War Economy"),
        Tuple.Create(10115, "Episode 22: Retake the Platform"),
        Tuple.Create(10120, "Episode 23: The White Mamba"),
        Tuple.Create(10085, "Episode 24: Close Contact"),
        Tuple.Create(10200, "Episode 25: Aim True, Ye Vengeful"),
        Tuple.Create(10211, "Episode 26: Hunting Down"),
        Tuple.Create(10081, "Episode 27: Root Cause"),
        Tuple.Create(10130, "Episode 28: Code Talker"),
        Tuple.Create(10140, "Episode 29: Metallic Archaea"),
        Tuple.Create(10150, "Episode 30: Skull Face"),
        Tuple.Create(10151, "Episode 31: Sahelanthropus"),
        Tuple.Create(10045, "Episode 32: To Know Too Much"),
        Tuple.Create(11043, "Episode 33: [Subsistence] C2W"),
        Tuple.Create(11054, "Episode 34: [Extreme] Backup, Back Down"),
        Tuple.Create(10093, "Episode 35: Cursed Legacy"),
        Tuple.Create(11082, "Episode 36: [Total Stealth] Footprints Of Phantoms"),
        Tuple.Create(11090, "Episode 37: [Extreme] Traitors' Caravan"),
        Tuple.Create(10156, "Episode 38: Extraordinary"),
        Tuple.Create(11033, "Episode 39: [Total Stealth] Over the Fence"),
        Tuple.Create(11050, "Episode 40: [Extreme] Cloaked in Silence"),
        Tuple.Create(10171, "Episode 41: Proxy War Without End"),
        Tuple.Create(11140, "Episode 42: [Extreme] Metallic Archaea"),
        Tuple.Create(10240, "Episode 43: Shining Lights, Even in Death"),
        Tuple.Create(11080, "Episode 44: [Total Stealth] Pitch Dark"),
        Tuple.Create(10260, "Episode 45: A Quiet Exit"),
        Tuple.Create(10280, "Episode 46: Truth: The Man Who Sold the World"),
        Tuple.Create(11121, "Episode 47: [Total Stealth] The War Economy"),
        Tuple.Create(11130, "Episode 48: [Extreme] Code Talker"),
        Tuple.Create(11044, "Episode 49: [Subsistence] Occupation Forces"),
        Tuple.Create(11151, "Episode 50: [Extreme] Sahelanthropus")    
    };

    settings.Add("start", true, "Split on EPISODE START");

    foreach (var d in vars.missionData)
	{
        settings.Add("st" + d.Item1, false, d.Item2, "start");
    }

    settings.Add("score", true, "Split on SCORE");

    foreach (var d in vars.missionData)
	{
	    settings.Add("sc" + d.Item1, false, d.Item2, "score");
    }

    settings.Add("credits", true, "Split on CREDITS");
    settings.Add("c1", false, "Chapter 1", "credits");
    settings.Add("c2", false, "Chapter 2", "credits");
}

update
{
    if (settings["c1"] == true
        && current.missionId == 10151
        && current.scorePages == 1)
    {
        vars.statusC1 = true;
    }

    if (settings["c1"] == true
        && vars.statusC1 == true)
    {
        if (old.isCutscene == 1 && current.isCutscene == 0)
        {
            vars.cutsceneCounterC1++;
        }
    }

    if (settings["c2"] == true
        && current.missionId == 10280
        && current.scorePages == 1)
    {
        vars.statusC2 = true;
    }

    if (settings["c2"] == true
        && vars.statusC2 == true)
    {
        if (old.isCutscene == 1 && current.isCutscene == 0)
        {
            vars.cutsceneCounterC2++;
            
        }
    }
}

onStart
{
    vars.Completed.Clear();

    vars.statusC1 = false;
    vars.cutsceneCounterC1 = 0;

    vars.statusC2 = false;
    vars.cutsceneCounterC2 = 0;
}



start
{
    if (current.missionId == 10020
        && current.resume == 1 
        && old.resume == 0)
    {
        return true;
    }
}

split
{
    if (settings["c1"] == true
        && vars.cutsceneCounterC1 == 1
        && vars.Completed.Add("c1"))
    {
        return true;
    }

    if (settings["c2"] == true
        && vars.cutsceneCounterC2 == 3
        && vars.Completed.Add("c2"))
    {
        return true;
    }


    for (var i = 0; i < vars.missionData.Length; i++)
    {
        if (settings["sc" + vars.missionData[i].Item1]
        && vars.missionData[i].Item1 == current.missionId
        && current.scorePages == 1
        && old.scorePages != 1
        && vars.Completed.Add("sc" + vars.missionData[i].Item1))
        {
            return true;
        }
    }
    
    for (var i = 0; i < vars.missionData.Length; i++)
    {
        if (settings["st" + vars.missionData[i].Item1]
        && current.missionId == vars.missionData[i].Item1
        && (Math.Floor(old.missionId / 1e4) == 3 || Math.Floor(old.missionId / 1e4) == 4)
        && vars.Completed.Add("st" + vars.missionData[i].Item1))
        {
            return true;
        }
    }


}

isLoading
{
    if (current.isLoading == 0 || current.isLoading == 256)
    {
        // Exceptions
        if (current.splashScreen == 1
            || current.isReport == 1
            || (current.scorePages >= 1 && current.scorePages <= 3))
        {
            return false;
        }
        
        return true;
    } 
    else
    {
        return false;
    }
}