state("pcsx2-qt")
{
    
}
startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS2");
    vars.screenId = vars.Helper.Make<int>(0x4fc868);
}

update
{
    print(vars.screenId.Current.ToString());
}