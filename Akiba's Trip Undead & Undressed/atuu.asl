state("AkibaUU")
{
    // Increases by one when completing a mission (main or side)
    int missionСounter: "AkibaUU.exe", 0x4F6CFC;

    // Current map number
    int mapNumber: "AkibaUU.exe", 0x5324DC;

    // Character position
    float positionY: "AkibaUU.exe", 0x465FE4;
    float positionZ: "AkibaUU.exe", 0x465FE0;
    float positionX: "AkibaUU.exe", 0x465FE8;

    // Changes the value to 111 when credits start
    int creditsStart: "AkibaUU.exe", 0x481500;

    // Changes the value to 151 or 223 when leav Akihabara
    int trainEnd: "AkibaUU.exe", 0x4ACA64;
}

startup
{
    // chapter_
    // Item1: mission id in settings
    // Item2: positionY character 
    // Item2: positionZ character 
    // Item3: positionX character 

    // Chapter 1
    // Same for all endings
    vars.chapter1 = new Tuple<int, float, float, float>[]
    {
        Tuple.Create(1, 1.729497f, -2.678275f, 2.182908f),
        Tuple.Create(2, 1.44997f, -3.382344f, 6.325909f),
        Tuple.Create(3, 1.615439f, -7.485596f, 13.636044f), 
        Tuple.Create(4, 1.284996f, -6.429576f, 14.757700f),
        Tuple.Create(5, 1.273742f, -8.754382f, 13.374955f),
        Tuple.Create(6, 1.604571f, -8.925579f, -118.675133f),
        Tuple.Create(7, 1.434686f, -5.191771f, 9.622315f),
        Tuple.Create(8, 1.526805f, -6.715621f, 13.143861f),
        Tuple.Create(9, 1.507847f, -6.404016f, 15.007300f),
        Tuple.Create(10, 1.178108f, -3.251970f, 9.506982f),
        Tuple.Create(11, 1.354699f, 27.982529f, 8.312622f),
        Tuple.Create(12, 1.179444f, -1.225575f, -36.363506f),
        Tuple.Create(13, 1.340432f, 43.361782f, -75.738457f),    
    };

    // Chapter 2
    vars.chapter2 = new Tuple<int, float, float, float>[]
    {
        Tuple.Create(14, 1.753968f, -3.575703f, 12.967361f),
        Tuple.Create(15, 1.403322f, -3.024755f, 2.366887f),
        Tuple.Create(16, 1.903178f, -5.590683f, 11.821987f),
        Tuple.Create(17, 1.442598f, -2.954975f, 7.310930f),
        Tuple.Create(18, 1.555321f, -5.148322f, 13.262603f),
        Tuple.Create(19, 1.459551f, -6.631887f, 13.373309f),
        Tuple.Create(20, 1.474003f, -7.645730f, 10.132676f),
        Tuple.Create(21, 1.173435f,	15.427427f, -39.462936f),
        // To the Battle Arena where Zenya Amou Awaits!
        // Shizuku
        Tuple.Create(22, 1.420989f, -8.703035f, 10.144214f),
        // Tohko
        Tuple.Create(22, 1.718277f, -8.39325f, 13.656679f),
        // Rin
        Tuple.Create(22, 1.620726f, -4.492122f, 14.412026f),
        // Shion
        Tuple.Create(22, 1.760053f, -5.100903f, 12.793765f),
    };

    // Chapter 3 - Shizuku 100
    vars.chapter3Shizuku = new Tuple<int, float, float, float>[]
    {
        Tuple.Create(123, 1.521416f, -8.861973f, 12.929842f),
        Tuple.Create(124, 1.794408f, -5.758067f, 12.43737f),
        Tuple.Create(125, 1.550729f, -3.143151f, 1.906818f),
        Tuple.Create(126, 2.164646f, -5.215629f, 13.285363f),
        Tuple.Create(127, 1.124656f, 13.13219f, -69.59417f),
    };

    // Chapter 3 - Tohko 200
    vars.chapter3Tohko = new Tuple<int, float, float, float>[]
    {
        Tuple.Create(223, 1.548041f, -5.745729f, 12.256323f),
        Tuple.Create(224, 1.585566f, -5.567666f, 11.359394f),
        Tuple.Create(225, 1.42815f, -7.247728f, 9.722128f),
        Tuple.Create(226, 1.64619f, -5.567641f, 10.903448f),
        Tuple.Create(227, 1.124862f, 13.81955f, -69.386406f),
    };

    // Chapter 3 - Rin 300
    vars.chapter3Rin = new Tuple<int, float, float, float>[]
    {
        Tuple.Create(323, 1.425153f, -9.590592f, 13.756587f),
        Tuple.Create(324, 1.918821f, -3.522397f, 7.151635f),
        Tuple.Create(325, 1.545065f, -5.712129f, 11.259362f),
        Tuple.Create(326, 1.961876f, -2.155976f, 12.904745f),
        Tuple.Create(327, 1.327725f, 13.811988f, -69.378403f),
    };

    // Chapter 3 - Shion 400
    vars.chapter3Shion = new Tuple<int, float, float, float>[]
    {
        Tuple.Create(423, 1.282270f, -4.978224f, 9.561569f),
        Tuple.Create(424, 1.008330f, 60.626144f, 46.817780f),
        Tuple.Create(425, 1.502857f, -8.490373f, -61.773266f),
        Tuple.Create(426, 1.392580f, 7.410832f, 0.348735f),
        Tuple.Create(427, 1.307403f, 0.875389f, -17.276546f),
        Tuple.Create(428, 1.368003f, 31.868629f, -19.367922f),
    };

    // Settings
    // Prologue
    settings.Add("0", true, "M0 - Prologue");
    // Chapter 1
    settings.Add("chapter1", true, "Chapter 1");
    settings.Add("1", true, "M1 - To the Freedom Fighter Base MOGRA", "chapter1");
    settings.Add("2", true, "M2 - Off to the Battle Arena", "chapter1");
    settings.Add("3", true, "M3 - A Stranger on Junk Street", "chapter1");
    settings.Add("4", true, "M4 - A Favor For Your Sister", "chapter1");
    settings.Add("5", true, "M5 - Patrol the Side Streets with Shizuku", "chapter1");
    settings.Add("6", true, "M6 - Shopping with Kati on the Side Streets", "chapter1");
    settings.Add("7", true, "M7 - Rin's Street Performance", "chapter1");
    settings.Add("8", true, "M8 - Patrolling with Shizuku, Tohko or Alone", "chapter1");
    settings.Add("9", true, "M9 - Search for Shizuku", "chapter1");
    settings.Add("10", true, "M10 - Train at the Battle Arena", "chapter1");
    settings.Add("11", true, "M11 - Meet up with Everyone by the Station", "chapter1");
    settings.Add("12", true, "M12 - Patrolling with Shizuku", "chapter1");
    settings.Add("13", true, "M13 - Hurry to Electric Town Plaza!", "chapter1");
    // Chapter 2
    settings.Add("chapter2", true, "Chapter 2");
    settings.Add("14", true, "M14 - Return to MOGRA for Your Report", "chapter2");
    settings.Add("15", true, "M15 - Go to Akimori Shrine with Shizuku", "chapter2");
    settings.Add("16", true, "M16 - Head to Akihabara Park", "chapter2");
    settings.Add("17", true, "M17 - Deliver the Goods", "chapter2");
    settings.Add("18", true, "M18 - Cosplay Fest Begins!", "chapter2");
    settings.Add("19", true, "M19 - Patrol Main Street Southwest with Kaito", "chapter2");
    settings.Add("20", true, "M20 - Proceed As Instructed to Akimori Shrine", "chapter2");
    settings.Add("21", true, "M21 - Patrol Yodobashi Area with Shizuku", "chapter2");
    settings.Add("22", true, "M22 - To the Battle Arena where Zenya Amou Awaits!", "chapter2");
    // Chapter 3 - Shizuku 100
    settings.Add("chapter3_shizuku", false, "Chapter 3 - Shizuku");
    settings.Add("123", false, "M23 - Patrol Akihabara Park with Shizuku", "chapter3_shizuku");
    settings.Add("124", false, "M24 - Hurry to the Suit Store with Shizuku!", "chapter3_shizuku");
    settings.Add("125", false, "M25 - Go Figurine Shopping with Shizuku", "chapter3_shizuku");
    settings.Add("126", false, "M26 - See What Ms. Kasugai is Up To", "chapter3_shizuku");
    settings.Add("127", false, "M27 - Operation Decoy, Commence!", "chapter3_shizuku");
    // Chapter 3 - Tohko 200
    settings.Add("chapter3_tohko", true, "Chapter 3 - Tohko - Normal Ending");
    settings.Add("223", true, "M23 - Patrolling Main Street Southwest with Tohko", "chapter3_tohko");
    settings.Add("224", true, "M24 - Hurry to the Suit Store with Tohko!", "chapter3_tohko");
    settings.Add("225", true, "M25 - Help Tohko Pick Out a Smartphone", "chapter3_tohko");
    settings.Add("226", true, "M26 - Pass Rin's Challenge", "chapter3_tohko");
    settings.Add("227", true, "M27 - Meet with Managing Director Sakaguchi", "chapter3_tohko");
    // Chapter 3 - Rin 300
    settings.Add("chapter3_rin", false, "Chapter 3 - Rin");
    settings.Add("323", false, "M23 - Patrol Main Street Northwest with Rin", "chapter3_rin");
    settings.Add("324", false, "M24 - Hurry to the Suit Store with Rin!", "chapter3_rin");
    settings.Add("325", false, "M25 - Head to the Accessory Shop", "chapter3_rin");
    settings.Add("326", false, "M26 - Stop Tohko's Rampage!", "chapter3_rin");
    settings.Add("327", false, "M27 - Carry Out the Plan!", "chapter3_rin");
    // Chapter 3 - Shion 400
    settings.Add("chapter3_shion", false, "Chapter 3 - Shion");
    settings.Add("423", false, "M23 - Patrolling Junk Street with Rin and Kati", "chapter3_shion");
    settings.Add("424", false, "M24 - Go to Akihabara Park with Ms. Kasugai", "chapter3_shion");
    settings.Add("425", false, "M25 - Stop at GO!GO!CURRY with Ms. Kasugai.", "chapter3_shion");
    settings.Add("426", false, "M26 - Return to the Organization's Hideout", "chapter3_shion");
    settings.Add("427", false, "M27 - Investigate the Missing Synthisters", "chapter3_shion");
    settings.Add("428", false, "M28 - Strategy Meeting at Akimori Shrine", "chapter3_shion");
    settings.Add("429", false, "M29 - Off to Confront Souga Kagutsuki!", "chapter3_shion");
    settings.Add("430", false, "M30 - Stop the Akiba Freedom Fighters' Advances!", "chapter3_shion");
    settings.Add("431", false, "M31 - Secure Radio Kaikan!", "chapter3_shion");
    // Chapter 3 - Endings
    settings.Add("endings", true, "Endings");
    settings.Add("28", true, "M28 - Shizuku, Tohko, Rin - Off to the Final Battle", "endings");
    settings.Add("432", false, "M32 - Shion - Go to Radio Kaikan", "endings");
    // Train 500
    settings.Add("500", false, "Leav Akihabara", "endings");

    // Variable for round position
    vars.roundY = 0;
    vars.roundZ = 0;
    vars.roundX = 0;
}

update
{
    vars.roundY = Math.Round(current.positionY, 3);
    vars.roundZ = Math.Round(current.positionZ, 3);
    vars.roundX = Math.Round(current.positionX, 3);
}

split {

    // Prologue
    if (settings["0"])
    {
        if (current.missionСounter == 0 && current.mapNumber == 3 && old.mapNumber == 25)
        {
            return true;
        }
    }

    // End Train Run
    if (settings["500"])
    {
        if (current.mapNumber == 1 && (current.trainEnd == 223 || current.trainEnd == 151)  && current.missionСounter == 0)
        {
            return true;
        }
    }

    if (current.missionСounter != old.missionСounter)
    {
        // Chapter 1
        for (int i = 0; i < vars.chapter1.Length; i++)
        {
            if (settings[(i + 1).ToString()] == true && vars.roundY == Math.Round(vars.chapter1[i].Item2,3) && vars.roundZ == Math.Round(vars.chapter1[i].Item3,3) && vars.roundX == Math.Round(vars.chapter1[i].Item4,3))
            {
                return true;
            }
        }

        // Chapter 2 before "To the Battle Arena where Zenya Amou Awaits!"
        for (int i = 0; i < vars.chapter2.Length; i++)
        {
            if (settings[(i + 14).ToString()] == true && vars.roundY == Math.Round(vars.chapter2[i].Item2,3) && vars.roundZ == Math.Round(vars.chapter2[i].Item3,3) && vars.roundX == Math.Round(vars.chapter2[i].Item4,3))
            {
                return true;
            }
        }

        // Chapter 3
        // Shizuku
        for (int i = 0; i < vars.chapter3Shizuku.Length; i++)
        {
            if (settings[(i + 123).ToString()] == true && vars.roundY == Math.Round(vars.chapter3Shizuku[i].Item2,3) && vars.roundZ == Math.Round(vars.chapter3Shizuku[i].Item3,3) && vars.roundX == Math.Round(vars.chapter3Shizuku[i].Item4,3))
            {
                return true;
            }
        }

        // Tohko
        for (int i = 0; i < vars.chapter3Tohko.Length; i++)
        {
            if (settings[(i + 223).ToString()] == true && vars.roundY == Math.Round(vars.chapter3Tohko[i].Item2,3) && vars.roundZ == Math.Round(vars.chapter3Tohko[i].Item3,3) && vars.roundX == Math.Round(vars.chapter3Tohko[i].Item4,3))
            {
                return true;
            }
        }

        // Rin
        for (int i = 0; i < vars.chapter3Rin.Length; i++)
        {
            if (settings[(i + 323).ToString()] == true && vars.roundY == Math.Round(vars.chapter3Rin[i].Item2,3) && vars.roundZ == Math.Round(vars.chapter3Rin[i].Item3,3) && vars.roundX == Math.Round(vars.chapter3Rin[i].Item4,3))
            {
                return true;
            }
        }

        // Shion
        for (int i = 0; i < vars.chapter3Shion.Length; i++)
        {
            if (settings[(i + 423).ToString()] == true && vars.roundY == Math.Round(vars.chapter3Shion[i].Item2,3) && vars.roundZ == Math.Round(vars.chapter3Shion[i].Item3,3) && vars.roundX == Math.Round(vars.chapter3Shion[i].Item4,3))
            {
                return true;
            }
        }

        // Shion (No stable position)
        if (settings["429"] == true && current.mapNumber == 16 && (vars.roundY >= -1f && vars.roundY <= 1f) && (vars.roundZ >= 2f && vars.roundZ <= 4f) && (vars.roundX >= -11f && vars.roundX <= -9f))
        {
            return true;
        }

        if (settings["430"] == true && current.mapNumber == 5 && (vars.roundY >= 1f && vars.roundY <= 3f) && (vars.roundZ >= 14f && vars.roundZ <= 20f) && (vars.roundX >= -165f && vars.roundX <= -155f))
        {
            return true;
        }
        
        if (settings["431"] == true && current.mapNumber == 3 && (vars.roundY >= 1f && vars.roundY <= 3f) && (vars.roundZ >= -20f && vars.roundZ <= -5f) && (vars.roundX >= 6f && vars.roundX <= 12f) && current.mapNumber == 3)
        {
            return true;
        }
        
    }

    // Endings
    if (settings["28"] || settings["432"])
    {
        if (vars.roundY == 1f && vars.roundZ == 0f && vars.roundX == 0f)
        {
            return current.creditsStart != old.creditsStart;
        }
    }
}