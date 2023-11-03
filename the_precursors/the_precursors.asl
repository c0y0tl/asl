state("Precursors")
{
    // Current mission ID
    int mission: "game.dll", 0x1F7458;

    // Coords
    float posX: "vital.dll", 0x00369C70, 0x17C, 0x8C;
    float posY: "vital.dll", 0x00369C70, 0x17C, 0x90;
    float posZ: "vital.dll", 0x00369C70, 0x17C, 0x94;

    // Loading (Low accuracy)
    // 1 - game
    // 0 - loading
    byte loading: "game.dll", 0x1C2E48;
}

startup
{
    vars.roundX = 0;
    vars.roundY = 0;
    vars.roundZ = 0;

    vars.Completed = new HashSet<string>();

    vars.missionData = new Tuple<string, int>[]
    {
        Tuple.Create("flight", 9600),
        Tuple.Create("beacon", 9604),
        Tuple.Create("airdefense", 9605),
        Tuple.Create("docs", 9613),
        Tuple.Create("robot", 9614),
        Tuple.Create("truck", 9608),
        Tuple.Create("mobileairdefense", 9610),
        Tuple.Create("scientist", 9607),
        Tuple.Create("mines", 9611),

    };

    settings.Add("simultaion", false, "Simultaion");
    settings.Add("flight", false, "Flight");
    settings.Add("beacon", false, "Beacon");
    settings.Add("airdefense", false, "Air Defense");
    settings.Add("docs", false, "Docs");
    settings.Add("robot", false, "Robot");
    settings.Add("truck", false, "Truck");
    settings.Add("mobileairdefense", false, "Mobile Air Defense");
    settings.Add("scientist", false, "Scientist");
    settings.Add("mines", false, "Mines");
    settings.Add("nirrisaprotov", false, "Nirris Aprotov");
}

onStart
{
    vars.Completed.Clear();
}

update
{
    vars.roundX = Math.Round(current.posX, 3);
    vars.roundY = Math.Round(current.posY, 3);
    vars.roundZ = Math.Round(current.posZ, 3);    
}


split 
{
    for (int i = 0; i < vars.missionData.Length; i++)
    {
        if (settings[vars.missionData[i].Item1] == true
            && current.loading == 1
            && current.mission == vars.missionData[i].Item2
            && current.mission != old.mission
            && vars.Completed.Add(vars.missionData[i].Item1))
        {
            return true;
        }
    }

    if (settings["simultaion"] == true
        && current.loading == 1
        && current.mission == 0
        && old.mission == 3104
        && vars.Completed.Add("simultaion")
    {
        return true;
    }

    if (settings["nirrisaprotov"] == true
        && (vars.roundX < 330000f && vars.roundX > 319900f)
        && (vars.roundY < -3400f && vars.roundY > -3800f)
        && (vars.roundZ < 96000f && vars.roundZ > 94000f)
        && vars.Completed.Add("nirrisaprotov"))
    {
        return true;
    }
    
}


isLoading
{
    if (current.loading == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}