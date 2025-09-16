state("mgsvtpp")
{
    // Title on Score screen
    string255 scoreTitle: "mgsvtpp.exe", 0x02B51390, 0x70, 0x280, 0x3E8;

    // Resume
    // 1 - When press "Resume ..."
    // 0 - Other
    int startResume: "mgsvtpp.exe", 0x02A6F918, 0x3C;


    // int isLoading: "mgsvtpp.exe", 0x02B3A070, 0x40; // Has 1 on score, report, first cutscenes and etc.
    // int isLoading: "mgsvtpp.exe", 0x02B51390,  0x70, 0x68, 0x20, 0x60, 0x9D8, 0xE30; // Low accuracy

    // Loading
    // 1 - Loading
    // 0 - Other
    // 256 - Cutscene
    int isLoading: "mgsvtpp.exe", 0x2A9CC14;

    // Cutscene
    // 1 - Cutscene
    // 0 - Other
    int isCutscene: "mgsvtpp.exe", 0x2A9C8C0;

    // Mission Start
    // 1 - Mission start
    // 0 - Other
    int missionStart: "mgsvtpp.exe", 0x02A641D0, 0xEF0;

    // Mission Start Episode N
    // Changes if on screen "Episode N"
    string255 missionStartEpisode: "mgsvtpp.exe", 0x02AB6638, 0xEB8, 0x778;

    
    // Report
    // 1 - Report
    // 0 - Other
    int isReport: "mgsvtpp.exe", 0x2A9C140;
}

startup
{
    vars.Completed = new HashSet<string>();
    vars.finishChapter1 = false;
    vars.cutsceneCounterC1 = 0;

    vars.missionData = new Tuple<string, string>[]
    {
        Tuple.Create("0", "Episode 0: Prologue: Awakening"),
        Tuple.Create("1", "Episode 1: Phantom Limbs"),
        Tuple.Create("2", "Episode 2: Diamond Dogs"),
        Tuple.Create("3", "Episode 3: A Hero's Way"),
        Tuple.Create("4", "Episode 4: C2W"),
        Tuple.Create("5", "Episode 5: Over the Fence"),
        Tuple.Create("6", "Episode 6: Where Do the Bees Sleep?"),
        Tuple.Create("7", "Episode 7: Red Brass"),
        Tuple.Create("8", "Episode 8: Occupation Forces"),
        Tuple.Create("9", "Episode 9: Backup, Back Down"),
        Tuple.Create("10", "Episode 10: Angel With Broken Wings"),
        Tuple.Create("11", "Episode 11: Cloaked in Silence"),
        Tuple.Create("12", "Episode 12: Hellbound"),
        Tuple.Create("13", "Episode 13: Pitch Dark"),
        Tuple.Create("14", "Episode 14: Lingua Franca"),
        Tuple.Create("15", "Episode 15: Footprints of Phantoms"),
        Tuple.Create("16", "Episode 16: Traitors' Caravan"),
        Tuple.Create("17", "Episode 17: Rescue The Intel Agents"),
        Tuple.Create("18", "Episode 18: Blood Runs Deep"),
        Tuple.Create("19", "Episode 19: On the Trail"),
        Tuple.Create("20", "Episode 20: Voices"),
        Tuple.Create("21", "Episode 21: The War Economy"),
        Tuple.Create("22", "Episode 22: Retake the Platform"),
        Tuple.Create("23", "Episode 23: The White Mamba"),
        Tuple.Create("24", "Episode 24: Close Contact"),
        Tuple.Create("25", "Episode 25: Aim True, Ye Vengeful"),
        Tuple.Create("26", "Episode 26: Hunting Down"),
        Tuple.Create("27", "Episode 27: Root Cause"),
        Tuple.Create("28", "Episode 28: Code Talker"),
        Tuple.Create("29", "Episode 29: Metallic Archaea"),
        Tuple.Create("30", "Episode 30: Skull Face"),
        Tuple.Create("31", "Episode 31: Sahelanthropus"),
        Tuple.Create("32", "Episode 32: To Know Too Much"),
        Tuple.Create("33", "Episode 33: [Subsistence] C2W"),
        Tuple.Create("34", "Episode 34: [Extreme] Backup, Back Down"),
        Tuple.Create("35", "Episode 35: Cursed Legacy"),
        Tuple.Create("36", "Episode 36: [Total Stealth] Footprints Of Phantoms"),
        Tuple.Create("37", "Episode 37: [Extreme] Traitors' Caravan"),
        Tuple.Create("38", "Episode 38: Extraordinary"),
        Tuple.Create("39", "Episode 39: [Total Stealth] Over the Fence"),
        Tuple.Create("40", "Episode 40: [Extreme] Cloaked in Silence"),
        Tuple.Create("41", "Episode 41: Proxy War Without End"),
        Tuple.Create("42", "Episode 42: [Extreme] Metallic Archaea"),
        Tuple.Create("43", "Episode 43: Shining Lights, Even in Death"),
        Tuple.Create("44", "Episode 44: [Total Stealth] Pitch Dark"),
        Tuple.Create("45", "Episode 45: A Quiet Exit"),
        Tuple.Create("46", "Episode 46: Truth: The Man Who Sold the World"),
        Tuple.Create("47", "Episode 47: [Total Stealth] The War Economy"),
        Tuple.Create("48", "Episode 48: [Extreme] Code Talker"),
        Tuple.Create("49", "Episode 49: [Subsistence] Occupation Forces"),
        Tuple.Create("50", "Episode 50: [Extreme] Sahelanthropus")    
    };

    settings.Add("start", true, "Split on 'Episode N' Screen");

    foreach (var d in vars.missionData)
	{
        if (d.Item1 != "0")
        {
            settings.Add("st" + d.Item1, false, d.Item2, "start");
        }
    }

    settings.Add("score", true, "Split on SCORE");

    foreach (var d in vars.missionData)
	{
	    settings.Add("sc" + d.Item1, false, d.Item2, "score");
    }

    settings.Add("credits", true, "Split on CREDITS");
    settings.Add("c1", false, "Chapter 1", "credits");
}

update
{
    if (settings["c1"] == true
        && current.scoreTitle.ToLower().Contains(vars.missionData[31].Item2.ToLower()))
    {
        vars.finishChapter1 = true;
    }

    if (settings["c1"] == true
        && vars.finishChapter1 == true)
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
    vars.finishChapter1 = false;
    vars.cutsceneCounterC1 = 0;
}

start
{
    if (current.isLoading == 1 
        && current.startResume == 1 
        && old.startResume == 0)
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
        if ((settings["sc" + vars.missionData[i].Item1]
        && current.scoreTitle.ToLower().Contains(vars.missionData[i].Item2.ToLower())
        && vars.Completed.Add("sc" + vars.missionData[i].Item1))
        || (settings["st" + vars.missionData[i].Item1]
        && vars.missionData[i].Item2.ToLower().Contains(current.missionStartEpisode.ToLower())
        && vars.Completed.Add("st" + vars.missionData[i].Item1)))
        {
            return true;
        }
    }


}

isLoading
{
    if (current.isLoading == 1 
        && current.isCutscene == 0)
    {
        if (current.missionStart == 1
            || current.isReport == 1)
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