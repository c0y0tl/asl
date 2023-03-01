state("Gedonia")
{
  // Loading
  // 1 - in game 
  // 0 - loading
  byte isLoading: "UnityPlayer.dll", 0x0177ED40, 0x1D0, 0x48, 0x68, 0xC8, 0x968;
}

isLoading
{
  if (current.isLoading != 1)
  {
    return true;
  }
  else
  {
    return false;
  }
}