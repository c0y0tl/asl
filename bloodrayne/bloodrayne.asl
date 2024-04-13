state("rayne") // by ToxicTT v0.9 (06072020)
{
    float IGT : 0x2C3C0C;
    string12 map: 0x2C66DB;
	byte16 targets16: 0x2C3C1F;
}

start
{
	if (old.IGT == 0 & current.IGT > 0)
		return true;
}

reset
{
	if (old.IGT == 0 & current.IGT > 0)
		return true;
}

split
{	
	if ((old.map != current.map) || (current.targets16[15] == 1 && old.targets16[15] == 0))
		return true;
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}