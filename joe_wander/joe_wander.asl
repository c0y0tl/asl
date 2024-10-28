state("Joe Wander")
{
   // Coordinates
   // 0 — When сutscene
   float x: "UnityPlayer.dll", 0x01AFB850, 0x1D0, 0x328, 0xA0;
   float y: "UnityPlayer.dll", 0x01AFB850, 0x1D0, 0x328, 0xA4;
   float z: "UnityPlayer.dll", 0x01AFB850, 0x1D0, 0x328, 0xA8;

   // portalId
   // -1 — Hub
   // 0..6 — Inside the portal
   int portalId: "GameAssembly.dll", 0x02C731F0, 0x10, 0x85C;
   
   // loading
   // 0 — In game
   // 1 — Loading
   int loading: "UnityPlayer.dll", 0x01AF67B0, 0x38;
}

startup
{
   vars.xRound = 0f;
   vars.yRound = 0f;
   vars.zRound = 0f;

   settings.Add("portalExit", true, "Split after exiting portal");
}

update
{
   vars.xRound = Math.Round(current.x, 3);
   vars.yRound = Math.Round(current.y, 3);
   vars.zRound = Math.Round(current.z, 3);
}

isLoading
{
   return current.loading == 1;
}

start
{
   if (vars.xRound == 90.323 
      && vars.yRound == 7.485 
      && vars.zRound == 17.143
      && old.x == 0
      && old.y == 0
      && old.z == 0)
   {
      return true;
   }
}

split
{
   if (settings["portalExit"] == true)
   {
      if (current.portalId == -1 && old.portalId >= 0)
      {
         return true;
      }
   }
}
