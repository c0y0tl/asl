state("DiRT")
{
	int loading : "DiRT.exe", 0x0076EDDC;
	float progress : "DiRT.exe", 0x0079E07C, 0x5C, 0xC4, 0xC8, 0x304, 0x210, 0x1C0;
}

split
{
	if ((old.progress >= 0.99f && old.progress <= 1f) && current.progress > 1f)
	{
		return true;
	}
}

isLoading
{
	return current.loading == 2;
}