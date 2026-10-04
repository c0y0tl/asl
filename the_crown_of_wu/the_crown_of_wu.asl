state("CrownOfWu_v1-Win64-Shipping", "v1.00 (unknown)")
{
    // Current level
    string250 level: "CrownOfWu_v1-Win64-Shipping.exe", 0x04E40A40, 0x20, 0x8B0, 0x0;

    // Usual loading screen
    // 0 - in game
    // >0 - loading screen
    int loading: "fmodstudio.dll", 0x00158B50, 0x28, 0x10, 0x74;

    // Loading screen with art
    // 0 - in game
    // >0 - loading screen
    int loadingArt: "CrownOfWu_v1-Win64-Shipping.exe", 0x04E2F518, 0xD8;

    // Zhu HP
    // Max 150
    float zhuHP: "CrownOfWu_v1-Win64-Shipping.exe", 0x04E4BED0, 0x10, 0x20, 0x240, 0x758;
}

state("CrownOfWu_v1-Win64-Shipping", "v1.03 (Steam)")
{
    // Current level
    string250 level: "CrownOfWu_v1-Win64-Shipping.exe", 0x050EFA00, 0x20, 0x8B0, 0x0;

    // Usual loading screen
    // 0 - in game
    // >0 - loading screen
    int loading: "fmodstudio.dll", 0x00158B50, 0x38, 0x10, 0x74;

    // Loading screen with art
    // 0 - in game
    // >0 - loading screen
    int loadingArt: "CrownOfWu_v1-Win64-Shipping.exe", 0x050DE4D8, 0xD8;

    // Zhu HP
    // Max 150
    float zhuHP: "CrownOfWu_v1-Win64-Shipping.exe", 0x050FAE90, 0x10, 0x20, 0x240, 0x758;
}

init
{
    switch (modules.First().ModuleMemorySize)
    {
        case 87097344:
            version = "v1.00 (unknown)";
            break;
        case 90185728:
            version = "v1.03 (Steam)";
            break;
        default:
            print("Unknown version.");
            break;
    }
}

startup
{
    vars.Completed = new HashSet<string>();

    vars.levelData = new Tuple<int, string, string, string>[]
    {
        Tuple.Create(1, "/Game/CrownOfWu/Maps/01Prision/Prision", "/Game/CrownOfWu/Maps/02Descenso/Descenso", "Prision"), 
        Tuple.Create(2, "/Game/CrownOfWu/Maps/02Descenso/Descenso", "/Game/CrownOfWu/Maps/02DescensoBis_Rocadragon/Rocadragon", "Descenso"), 
        Tuple.Create(3, "/Game/CrownOfWu/Maps/02DescensoBis_Rocadragon/Rocadragon", "/Game/CrownOfWu/Maps/03Puente/Cueva", "Rocadragon"), 
        Tuple.Create(4, "/Game/CrownOfWu/Maps/03Puente/Cueva", "/Game/CrownOfWu/Maps/04Pagoda/Pagoda", "Cueva"), 
        Tuple.Create(5, "/Game/CrownOfWu/Maps/04Pagoda/Pagoda", "/Game/CrownOfWu/Maps/06Slum/Slum", "Pagoda"), 
        Tuple.Create(6, "/Game/CrownOfWu/Maps/06Slum/Slum", "/Game/CrownOfWu/Maps/09Trono/Trono", "Slum")
    };

    foreach (var i in vars.levelData)
    {
        settings.Add(i.Item1.ToString(), false, i.Item4);
    }

    settings.Add("7", false, "Trono");
}

start
{
    if (old.level == "/Game/CrownOfWu/Maps/MenuPagoda/MenuPagoda" && current.level == "/Game/CrownOfWu/Maps/01Prision/Prision")
    {
        return true;
    }
}

onStart
{
    vars.Completed.Clear();
}

split 
{
    if (current.level == "/Game/CrownOfWu/Maps/09Trono/Trono" && current.zhuHP == 0 && old.zhuHP > 0)
    {
        if (old.zhuHP >= 1 && old.zhuHP <= 7)
        {
            return true;
        }
    }

    for (int i = 0; i < vars.levelData.Length; i++)
    {
        if (settings[vars.levelData[i].Item1.ToString()] == true
            && old.level == vars.levelData[i].Item2 
            && current.level == vars.levelData[i].Item3 
            && vars.Completed.Add(vars.levelData[i].Item1.ToString()))
        {
            return true;
        }
    }

}

isLoading
{
    if (current.loading > 0 || current.loadingArt > 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

exit
{
    vars.IsGameTimePaused = true;
}