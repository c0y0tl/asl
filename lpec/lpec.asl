state("LostPlanetDX9", "DX9")
{
    float checkpointY: "LostPlanetDX9.exe", 0x0082BC54, 0x4A8;

    // loading
    // 0 - Menu, In Game
    // 1 - Loading
    byte loading: "LostPlanetDX9.exe", 0x008AE264, 0x34, 0x358;

    // igt / 30 = sec.
    float igt: "LostPlanetDX9.exe", 0x0082BC54, 0x2AC;
}

state("LostPlanetDX10", "DX10")
{
    float checkpointY: "LostPlanetDX10.exe", 0x08D2EF4, 0x4A8;

    // loading
    // 0 - Menu, In Game
    // 1 - Loading
    byte loading: "LostPlanetDX10.exe", 0x008D20C8, 0x34, 0x358;
    
    // igt / 30 = sec.
    float igt: "LostPlanetDX10.exe", 0x008D2EF4, 0x2AC;
}

init
{
    switch (modules.First().ModuleMemorySize)
    {
        case 11341824: 
            version = "DX9";
            break;
        case 12029952:
            version = "DX10";
            break;
        default:
            version = "Unknown";
            break;
    }
}

startup
{
    settings.Add("il_igt", false, "IGT for IL");

    vars.splitsData = new Tuple<string, float, float, string>[]
    {
        // Mission 00
        Tuple.Create("0_1", -54500f, -49331f, "Mission 00 - 01"),
        Tuple.Create("0_2", -55358f, -54500f, "Mission 00 - 02"),
        Tuple.Create("0_3", 0f, -55358f, "Mission 00 - 03 (Boss)"),
        // Mission 01
        Tuple.Create("1_1", -13832f, 7402f, "Mission 01 - 01"),
        Tuple.Create("1_2", -31761f, -13832f, "Mission 01 - 02"),
        Tuple.Create("1_3", 0f, -31761f, "Mission 01 - 03 (Boss)"),
        // Mission 02
        Tuple.Create("2_1", -427f, 13034f, "Mission 02 - 01"),
        Tuple.Create("2_2", -11722f, -427f, "Mission 02 - 02"),
        Tuple.Create("2_3", 67066f, -11722f, "Mission 02 - 03"),
        Tuple.Create("2_4", 78470f, 67066f, "Mission 02 - 04"),
        Tuple.Create("2_5", 94088f, 78470f, "Mission 02 - 05"),
        Tuple.Create("2_6", 0f, 94088f, "Mission 02 - 06 (Boss)"),
        // Mission 03
        Tuple.Create("3_1", 169145f, 106766f, "Mission 03 - 01"),
        Tuple.Create("3_2", 0f, 169145f, "Mission 03 - 02 (Boss)"),
        // Mission 04
        Tuple.Create("4_1", -13666f, -1888f, "Mission 04 - 01"),
        Tuple.Create("4_2", -16464f, -13666f, "Mission 04 - 02"),
        Tuple.Create("4_3", -16002f, -16464f, "Mission 04 - 03"),
        Tuple.Create("4_4", 0f, -16002f, "Mission 04 - 04 (Boss)"),
        // Mission 05
        Tuple.Create("5_1", -7898f, -51554f, "Mission 05 - 01"),
        Tuple.Create("5_2", 4425f, -7898f, "Mission 05 - 02"),
        Tuple.Create("5_3", 1076f, 4425f, "Mission 05 - 03"),
        Tuple.Create("5_4", 0f, 1076f, "Mission 05 - 04 (Boss)"),
        // Mission 06
        Tuple.Create("6_1", -20757f, -3788f, "Mission 06 - 01"),
        Tuple.Create("6_2", -41003f, -20757f, "Mission 06 - 02"),
        Tuple.Create("6_3", 0f, -41003f, "Mission 06 - 03 (Boss)"),
        // Mission 07
        Tuple.Create("7_1", 103892f, 147173f, "Mission 07 - 01"),
        Tuple.Create("7_2", 140233f, 106974f, "Mission 07 - 02"),
        Tuple.Create("7_3", 144251f, 140233f, "Mission 07 - 03"),
        Tuple.Create("7_4", 0f, 144251f, "Mission 07 - 04 (Boss)"),
        // Mission 08
        Tuple.Create("8_1", -10813f, -1201f, "Mission 08 - 01"),
        Tuple.Create("8_2", -36917f, -10813f, "Mission 08 - 02"),
        Tuple.Create("8_3", -81396f, -36917f, "Mission 08 - 03"),
        Tuple.Create("8_4", -84977f, -81396f, "Mission 08 - 04"),
        Tuple.Create("8_5", -79396f, -84977f, "Mission 08 - 05"),
        Tuple.Create("8_6", 0f, -79396f, "Mission 08 - 06 (Boss)"),
        // Mission 09
        Tuple.Create("9_1", -39489f, -75140f, "Mission 09 - 01"),
        Tuple.Create("9_2", -34770f, -39489f, "Mission 09 - 02"),
        Tuple.Create("9_3", -30082f, -34770f, "Mission 09 - 03"),
        Tuple.Create("9_4", 0f, -30082f, "Mission 09 - 04 (Boss)"),
        // Mission 10
        Tuple.Create("10_1", -6532f, 1642f, "Mission 10 - 01"),
        Tuple.Create("10_2", 13026f, -6532f, "Mission 10 - 02"),
        Tuple.Create("10_3", 0f, 13026f, "Mission 10 - 03 (Boss)"),
        Tuple.Create("10_4", 30796f, 20266f, "Mission 10 - 04"),
        Tuple.Create("10_5", 0f, 30796f, "Mission 10 - 05 (Boss)"),
        // Mission 11
        Tuple.Create("11_1", 0f, -4500f, "Mission 11 - 01"),
        Tuple.Create("11_2", 0f, -13800f, "Mission 11 - 02 (Boss)")
    };

    settings.Add("splits", true,"Splits");
    foreach (var d in vars.splitsData)
	{
	    settings.Add(d.Item1, true, d.Item4, "splits");
    }

}

start
{
    if (settings["il_igt"] == true)
    {
        if (current.igt == 0)
        {
            return true;
        }
    }
}

gameTime {
    if (settings["il_igt"] == true)
    {
	return TimeSpan.FromSeconds(current.igt / 30);
    }
}

isLoading
{
    if (settings["il_igt"] == false)
    {
        return current.loading == 1;
    }
}

split
{
    for (int i = 0; i < vars.splitsData.Length; i++)
    {
        if (vars.splitsData[i].Item2 == current.checkpointY
            && vars.splitsData[i].Item3 == old.checkpointY)
        {
            return true;
        }
    }
}