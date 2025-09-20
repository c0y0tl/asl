state("mgsvtpp")
{
    // Mission ID
    // 3XXXX - Open world
    // 4XXXX - Helicopter
    // 1XXXX - Episodes
    int missionId: "mgsvtpp.exe", 0x2950830;

    // Title on Score screen
    string255 scoreTitle: "mgsvtpp.exe", 0x02B51390, 0x70, 0x280, 0x3E8;

    // Resume
    // 1 - When press "Resume ..."
    // 0 - Other
    int resume: "mgsvtpp.exe", 0x02A6F918, 0x3C;

    // Starting splash screen
    // 1 - Splash screen active
    // 0 - Other
    int splashScreen: "mgsvtpp.exe", 0x02A641D0, 0xEF0;


    // Loading screen
    // 1 - In game
    // 0 - Loading
    int isLoading: "mgsvtpp.exe", 0x02A6FBD8, 0x38, 0x60, 0x698;

    // For loading between cutscene
    // 1 - Loading, loading between cutscene, some cutscene, report, score
    // 0 - Other
    int bLoading: "mgsvtpp.exe", 0x02B3A070, 0x40;

    // Cutscene
    // 1 - Cutscene
    // 0 - Other
    int isCutscene: "mgsvtpp.exe", 0x2A9C8C0;

    // Report
    // 1 - Report
    // 0 - Other
    int isReport: "mgsvtpp.exe", 0x2A9C140;
}

startup
{
    vars.Completed = new HashSet<string>();
    
    vars.statusC1 = false;
    vars.cutsceneCounterC1 = 0;

    vars.episodeNumber = -1;

    vars.missionData = new Tuple<int, int, string>[]
    {
        Tuple.Create(10010, 0, "Episode 0: Prologue: Awakening"),
        Tuple.Create(10020, 1, "Episode 1: Phantom Limbs"),
        Tuple.Create(10030, 2, "Episode 2: Diamond Dogs"),
        Tuple.Create(10036, 3, "Episode 3: A Hero's Way"),
        Tuple.Create(10043, 4, "Episode 4: C2W"),
        Tuple.Create(10033, 5, "Episode 5: Over the Fence"),
        Tuple.Create(10040, 6, "Episode 6: Where Do the Bees Sleep?"),
        Tuple.Create(10041, 7, "Episode 7: Red Brass"),
        Tuple.Create(10044, 8, "Episode 8: Occupation Forces"),
        Tuple.Create(10054, 9, "Episode 9: Backup, Back Down"),
        Tuple.Create(10052, 10, "Episode 10: Angel With Broken Wings"),
        Tuple.Create(10050, 11, "Episode 11: Cloaked in Silence"),
        Tuple.Create(10070, 12, "Episode 12: Hellbound"),
        Tuple.Create(10080, 13, "Episode 13: Pitch Dark"),
        Tuple.Create(10086, 14, "Episode 14: Lingua Franca"),
        Tuple.Create(10082, 15, "Episode 15: Footprints of Phantoms"),
        Tuple.Create(10090, 16, "Episode 16: Traitors' Caravan"),
        Tuple.Create(10091, 17, "Episode 17: Rescue The Intel Agents"),
        Tuple.Create(10100, 18, "Episode 18: Blood Runs Deep"),
        Tuple.Create(10195, 19, "Episode 19: On the Trail"),
        Tuple.Create(10110, 20, "Episode 20: Voices"),
        Tuple.Create(10121, 21, "Episode 21: The War Economy"),
        Tuple.Create(10115, 22, "Episode 22: Retake the Platform"),
        Tuple.Create(10120, 23, "Episode 23: The White Mamba"),
        Tuple.Create(10085, 24, "Episode 24: Close Contact"),
        Tuple.Create(10200, 25, "Episode 25: Aim True, Ye Vengeful"),
        Tuple.Create(10211, 26, "Episode 26: Hunting Down"),
        Tuple.Create(10081, 27, "Episode 27: Root Cause"),
        Tuple.Create(10130, 28, "Episode 28: Code Talker"),
        Tuple.Create(10140, 29, "Episode 29: Metallic Archaea"),
        Tuple.Create(10150, 30, "Episode 30: Skull Face"),
        Tuple.Create(10151, 31, "Episode 31: Sahelanthropus")
        
        // Tuple.Create("32", "Episode 32", "Episode 32: To Know Too Much"),
        // Tuple.Create("33", "Episode 33", "Episode 33: [Subsistence] C2W"),
        // Tuple.Create("34", "Episode 34", "Episode 34: [Extreme] Backup, Back Down"),
        // Tuple.Create("35", "Episode 35", "Episode 35: Cursed Legacy"),
        // Tuple.Create("36", "Episode 36", "Episode 36: [Total Stealth] Footprints Of Phantoms"),
        // Tuple.Create("37", "Episode 37", "Episode 37: [Extreme] Traitors' Caravan"),
        // Tuple.Create("38", "Episode 38", "Episode 38: Extraordinary"),
        // Tuple.Create("39", "Episode 39", "Episode 39: [Total Stealth] Over the Fence"),
        // Tuple.Create("40", "Episode 40", "Episode 40: [Extreme] Cloaked in Silence"),
        // Tuple.Create("41", "Episode 41", "Episode 41: Proxy War Without End"),
        // Tuple.Create("42", "Episode 42", "Episode 42: [Extreme] Metallic Archaea"),
        // Tuple.Create("43", "Episode 43", "Episode 43: Shining Lights, Even in Death"),
        // Tuple.Create("44", "Episode 44", "Episode 44: [Total Stealth] Pitch Dark"),
        // Tuple.Create("45", "Episode 45", "Episode 45: A Quiet Exit"),
        // Tuple.Create("46", "Episode 46", "Episode 46: Truth: The Man Who Sold the World"),
        // Tuple.Create("47", "Episode 47", "Episode 47: [Total Stealth] The War Economy"),
        // Tuple.Create("48", "Episode 48", "Episode 48: [Extreme] Code Talker"),
        // Tuple.Create("49", "Episode 49", "Episode 49: [Subsistence] Occupation Forces"),
        // Tuple.Create("50", "Episode 50", "Episode 50: [Extreme] Sahelanthropus")    
    };

    settings.Add("start", true, "Split on EPISODE START");

    foreach (var d in vars.missionData)
	{

        settings.Add("st" + d.Item1, false, d.Item3, "start");

    }

    settings.Add("score", true, "Split on SCORE");

    foreach (var d in vars.missionData)
	{
	    settings.Add("sc" + d.Item1, false, d.Item3, "score");
    }

    settings.Add("credits", true, "Split on CREDITS");
    settings.Add("c1", false, "Chapter 1", "credits");
}

update
{
    if (current.scoreTitle.IndexOf(":") != -1)
    {
        vars.episodeNumber = Convert.ToInt32(current.scoreTitle.Substring(current.scoreTitle.IndexOf(":") - 2, 2));
    }
    else
    {
        vars.episodeNumber = -1;
    }

    if (settings["c1"] == true
        && vars.episodeNumber == 31)
    {
        vars.statusC1 = true;
    }

    if (settings["c1"] == true
        && vars.statusC1 == true)
    {
        if (current.isCutscene == 1 && old.isCutscene == 0)
        {
            vars.cutsceneCounterC1++;
        }
    }
    
}

onStart
{
    vars.Completed.Clear();

    vars.statusC1 = false;
    vars.cutsceneCounterC1 = 0;

    vars.episodeNumber = -1;
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
        && vars.cutsceneCounterC1 == 2
        && vars.Completed.Add("c1"))
    {
        return true;
    }

    for (var i = 0; i < vars.missionData.Length; i++)
    {
        if (settings["sc" + vars.missionData[i].Item1]
        && vars.missionData[i].Item2 == vars.episodeNumber
        && vars.Completed.Add("sc" + vars.missionData[i].Item1))
        {
            return true;
        }
    }
    
    for (var i = 0; i < vars.missionData.Length; i++)
    {
        if (settings["st" + vars.missionData[i].Item1]
        && current.missionId == vars.missionData[i].Item1
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
        if (current.splashScreen == 1)
        {
            return false;
        }
        if (current.isReport == 1)
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