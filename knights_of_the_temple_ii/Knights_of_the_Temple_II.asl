state("KOTT2", "Playlogic")
{
    string255 map: "KOTT2.exe", 0x002C5220, 0xAC;
    int loading: "KOTT2.exe", 0x2A98D8;
}

state("KOTT2", "Akella")
{
    string255 map: "KOTT2.exe", 0x002C51E0, 0xAC;
    int loading: "KOTT2.exe", 0x2A9898;
}

init
{
    switch (modules.First().ModuleMemorySize)
    {
        case 3616768:
            version = "Playlogic";
            break;
        case 3502080:
            version = "Akella";
            break;
        default:
            print("Unknown version.");
            break;
    }
}

isLoading
{
    if(current.loading == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}