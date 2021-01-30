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
}

startup
{
    // Chapter 1
    // Same for all endings
    vars.chapter1 = new Tuple<int, int, float, float, float>[]
    {
        Tuple.Create(1, 14, 1.729497f, -2.678275f, 2.182908f),
        Tuple.Create(2, 14, 1.44997f, -3.382344f, 6.325909f),
        Tuple.Create(3, 14, 1.615439f, -7.485596f, 13.636044f), 
        Tuple.Create(4, 14, 1.284996f, -6.429576f, 14.757700f),
        Tuple.Create(5, 14, 1.273742f, -8.754382f, 13.374955f),
        Tuple.Create(6, 4, 1.604571f, -8.925579f, -118.675133f),
        Tuple.Create(7, 14, 1.434686f, -5.191771f, 9.622315f),
        Tuple.Create(8, 14, 1.526805f, -6.715621f, 13.143861f),
        Tuple.Create(9, 14, 1.507847f, -6.404016f,	15.007300f),
        Tuple.Create(10, 14, 1.178108f, -3.251970f, 9.506982f),
        Tuple.Create(11, 3, 1.354699f, 27.982529f, 8.312622f),
        Tuple.Create(12, 9, 1.179444f, -1.225575f, -36.363506f),
        Tuple.Create(13, 2, 1.340432f, 43.361782f, -75.738457f),
        
    };

    // Chapter 2
    // Same for all endings
    vars.chapter2 = new Tuple<int, int, float, float, float>[]
    {
        Tuple.Create(14, 14, 1.753968f, -3.575703f, 12.967361f),
        Tuple.Create(15, 14, 1.403322f, -3.024755f, 2.366887f),
        Tuple.Create(16, 14, 1.903178f, -5.590683f, 11.821987f),
        Tuple.Create(17, 14, 1.442598f, -2.954975f, 7.310930f),
        Tuple.Create(18, 14, 1.555321f, -5.148322f, 13.262603f),
        Tuple.Create(19, 14, 1.459551f, -6.631887f, 13.373309f),
        Tuple.Create(20, 14, 1.474003f, -7.645730f, 10.132676f),
        Tuple.Create(21, 12, 1.173435f,	15.427427f,	-39.462936f),
    };

    // Chapter 2
    // "To the Battle Arena where Zenya Amou Awaits!" different for all endings
    vars.chapter2Zenya = new Tuple<int, int, float, float, float>[]
    {
        // Normal Ending, Tohko, Sister 
        Tuple.Create(22, 14, 1.718277f, -8.39325f, 13.656679f),
        // Shizuku
        Tuple.Create(22, 14, 1.420989f, -8.703035f, 10.144214f),
        // Rin
        Tuple.Create(22, 14, 1.620726f, -4.492122f, 14.412026f),
        // Shion
        Tuple.Create(22, 14, 1.760053f, -5.100903f, 12.793765f),
    };

    // Chapter 3 - Shizuku 100
    vars.chapter3Shizuku = new Tuple<int, int, float, float, float>[]
    {
        Tuple.Create(123, 14, 1.521416f, -8.861973f, 12.929842f),
        Tuple.Create(124, 14, 1.794408f, -5.758067f, 12.43737f),
        Tuple.Create(125, 14, 1.550729f, -3.143151f, 1.906818f),
        Tuple.Create(126, 14, 2.164646f, -5.215629f, 13.285363f),
        Tuple.Create(127, 2, 1.124656f, 13.13219f, -69.59417f),
    };

    // Chapter 3 - Tohko 200
    vars.chapter3Tohko = new Tuple<int, int, float, float, float>[]
    {
        Tuple.Create(223, 14, 1.548041f, -5.745729f, 12.256323f),
        Tuple.Create(224, 14, 1.585566f, -5.567666f, 11.359394f),
        Tuple.Create(225, 14, 1.42815f, -7.247728f, 9.722128f),
        Tuple.Create(226, 14, 1.64619f, -5.567641f, 10.903448f),
        Tuple.Create(227, 2, 1.124862f, 13.81955f, -69.386406f),
    };

    // Chapter 3 - Rin 300
    vars.chapter3Rin = new Tuple<int, int, float, float, float>[]
    {
        Tuple.Create(323, 14, 1.425153f, -9.590592f, 13.756587f),
        Tuple.Create(324, 14, 1.918821f, -3.522397f, 7.151635f),
        Tuple.Create(325, 14, 1.545065f, -5.712129f, 11.259362f),
        Tuple.Create(326, 14, 1.961876f, -2.155976f, 12.904745f),
        Tuple.Create(327, 2, 1.327725f, 13.811988f, -69.378403f),
    };

    // Chapter 3 - Shion 400
    vars.chapter3Shion = new Tuple<int, int, float, float, float>[]
    {
        Tuple.Create(323, 14, 1.282270f, -4.978224f, 9.561569f),
        Tuple.Create(324, 13, 1.008330f, 60.626144f, 46.817780f),
        Tuple.Create(325, 6, 1.502857f, -8.490373f, -61.773266f),
        Tuple.Create(326, 17, 1.392580f, 7.410832f, 0.348735f),
        Tuple.Create(327, 16, 1.307403f, 0.875389f, -17.276546f),
        Tuple.Create(328, 19, 1.368003f, 31.868629f, -19.367922f),
        Tuple.Create(329, 16, 0.381696f, 2.584327f, -10.294657f),
        Tuple.Create(330, 5, 2.058285f, 17.414858f, -161.731430f),
        Tuple.Create(331, 3, 1.616837f, -10.755868f, 8.205438f),
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
    settings.Add("chapter3_shizuku", true, "Chapter 3 - Shizuku");
    settings.Add("123", true, "M23 - Patrol Akihabara Park with Shizuku", "chapter3_shizuku");
    settings.Add("124", true, "M24 - Hurry to the Suit Store with Shizuku!", "chapter3_shizuku");
    settings.Add("125", true, "M25 - Go Figurine Shopping with Shizuku", "chapter3_shizuku");
    settings.Add("126", true, "M26 - See What Ms. Kasugai is Up To", "chapter3_shizuku");
    settings.Add("127", true, "M27 - Operation Decoy, Commence!", "chapter3_shizuku");
    // Chapter 3 - Tohko 200
    settings.Add("chapter3_tohko", true, "Chapter 3 - Tohko - Normal Ending");
    settings.Add("223", true, "M23 - Patrolling Main Street Southwest with Tohko", "chapter3_tohko");
    settings.Add("224", true, "M24 - Hurry to the Suit Store with Tohko!", "chapter3_tohko");
    settings.Add("225", true, "M25 - Help Tohko Pick Out a Smartphone", "chapter3_tohko");
    settings.Add("226", true, "M26 - Pass Rin's Challenge", "chapter3_tohko");
    settings.Add("227", true, "M27 - Meet with Managing Director Sakaguchi", "chapter3_tohko");
    // Chapter 3 - Rin 300
    settings.Add("chapter3_rin", true, "Chapter 3 - Rin");
    settings.Add("323", true, "M23 - Patrol Main Street Northwest with Rin", "chapter3_rin");
    settings.Add("324", true, "M24 - Hurry to the Suit Store with Rin!", "chapter3_rin");
    settings.Add("325", true, "M25 - Head to the Accessory Shop", "chapter3_rin");
    settings.Add("326", true, "M26 - Stop Tohko's Rampage!", "chapter3_rin");
    settings.Add("327", true, "M27 - Carry Out the Plan!", "chapter3_rin");
    // Chapter 3 - Shion 400
    settings.Add("chapter3_shion", true, "Chapter 3 - Shion");
    settings.Add("423", true, "M23 - Patrolling Junk Street with Rin and Kati", "chapter3_shion");
    settings.Add("424", true, "M24 - Go to Akihabara Park with Ms. Kasugai", "chapter3_shion");
    settings.Add("425", true, "M25 - Stop at GO!GO!CURRY with Ms. Kasugai.", "chapter3_shion");
    settings.Add("426", true, "M26 - Return to the Organization's Hideout", "chapter3_shion");
    settings.Add("427", true, "M27 - Investigate the Missing Synthisters", "chapter3_shion");
    settings.Add("428", true, "M28 - Strategy Meeting at Akimori Shrine", "chapter3_shion");
    settings.Add("429", true, "M29 - Off to Confront Souga Kagutsuki!", "chapter3_shion");
    settings.Add("430", true, "M30 - Stop the Akiba Freedom Fighters' Advances!", "chapter3_shion");
    settings.Add("431", true, "M31 - Secure Radio Kaikan!", "chapter3_shion");
    // Chapter 3 - Endings
    settings.Add("endings", true, "Endings [Does not work]");
    settings.Add("28", true, "M28 - Normal Ending - Off to the Final Battle", "endings");
    settings.Add("128", true, "M28 - Shizuku - Off to the Final Battle", "endings");
    settings.Add("228", true, "M28 - Tohko - Off to the Final Battle", "endings");
    settings.Add("328", true, "M28 - Rin - Off to the Final Battle", "endings");
    settings.Add("433", true, "M32 - Shion - Go to Radio Kaikan", "endings");
    // Train 500
    settings.Add("502", true, "Leav Akihabara", "endings");

    // Variable for round position
    vars.roundY = 0;
	vars.roundZ = 0;
    vars.roundX = 0;

    // Main mission counters 
    vars.counterC1 = 0;
	vars.counterC2 = 0;
	vars.counterС3Shizuku = 0;
	vars.counterС3Tohko = 0;
	vars.counterС3Rin = 0;
	vars.counterС3Shion = 0;

    // Counter for sister missions
	vars.counterSister = 0;
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

    if (current.missionСounter != old.missionСounter)
    {
        // Chapter 1
        if (vars.counterC1 <= 12)
        {
            if (settings[(vars.counterC1 + 1).ToString()])
            {
                if (vars.roundY == Math.Round(vars.chapter1[vars.counterC1].Item3,3) && vars.roundZ == Math.Round(vars.chapter1[vars.counterC1].Item4,3) && vars.roundX == Math.Round(vars.chapter1[vars.counterC1].Item5,3))
                {
                    vars.counterC1++;
                    return true;
                }
            }
            else
            {
                vars.counterC1++;
            } 
        }

        // Chapter 2 before "To the Battle Arena where Zenya Amou Awaits!"
        if (vars.counterC2 <= 7) {
            if (settings[(vars.counterC2 + 1).ToString()])
            {
                if (vars.roundY == Math.Round(vars.chapter2[vars.counterC2].Item3,3) && vars.roundZ == Math.Round(vars.chapter2[vars.counterC2].Item4,3) && vars.roundX == Math.Round(vars.chapter2[vars.counterC2].Item5,3))
                {
                    vars.counterC2++;
                    return true;
                }
            }
            else
            {
                vars.counterC2++;
            } 
        }

        // Chapter 2 "To the Battle Arena where Zenya Amou Awaits!"
        if (settings["22"]) {
            // Normal Ending, Tohko, Sister
            if (vars.roundY == Math.Round(vars.chapter2Zenya[0].Item3,3) && vars.roundZ == Math.Round(vars.chapter2Zenya[0].Item4,3) && vars.roundX == Math.Round(vars.chapter2Zenya[0].Item5,3))
            {
                return true;
            }

            // Shizuku
            if (vars.roundY == Math.Round(vars.chapter2Zenya[1].Item3,3) && vars.roundZ == Math.Round(vars.chapter2Zenya[1].Item4,3) && vars.roundX == Math.Round(vars.chapter2Zenya[1].Item5,3))
            {
                return true;
            }

            // Rin
            if (vars.roundY == Math.Round(vars.chapter2Zenya[2].Item3,3) && vars.roundZ == Math.Round(vars.chapter2Zenya[2].Item4,3) && vars.roundX == Math.Round(vars.chapter2Zenya[2].Item5,3))
            {
                return true;
            }

            // Shion
            if (vars.roundY == Math.Round(vars.chapter2Zenya[3].Item3,3) && vars.roundZ == Math.Round(vars.chapter2Zenya[3].Item4,3) && vars.roundX == Math.Round(vars.chapter2Zenya[3].Item5,3))
            {
                return true;
            }
        }

        // Chapter 3
        // Normal Ending, Tohko, Sister
        if (vars.counterС3Tohko <= 4)
        {
            if (settings[(vars.counterС3Tohko + 1 + 222).ToString()])
            {
                if (vars.roundY == Math.Round(vars.chapter3Tohko[vars.counterС3Tohko].Item3,3) && vars.roundZ == Math.Round(vars.chapter3Tohko[vars.counterС3Tohko].Item4,3) && vars.roundX == Math.Round(vars.chapter3Tohko[vars.counterС3Tohko].Item5,3))
                {
                    vars.counterС3Tohko++;
                    return true;
                }
            }
            else
            {
                vars.counterС3Tohko++;
            } 
        }

        // Shizuku
        if (vars.counterС3Shizuku <= 4)
        {
            if (settings[(vars.counterС3Shizuku + 1 + 122).ToString()])
            {
                if (vars.roundY == Math.Round(vars.chapter3Shizuku[vars.counterС3Shizuku].Item3,3) && vars.roundZ == Math.Round(vars.chapter3Shizuku[vars.counterС3Shizuku].Item4,3) && vars.roundX == Math.Round(vars.chapter3Shizuku[vars.counterС3Shizuku].Item5,3))
                {
                    vars.counterС3Shizuku++;
                    return true;
                }
            }
            else
            {
                vars.counterС3Shizuku++;
            } 
        }

        // Rin
        if (vars.counterС3Rin <= 4)
        {
            if (settings[(vars.counterС3Rin + 1 + 322).ToString()])
            {
                if (vars.roundY == Math.Round(vars.chapter3Rin[vars.counterС3Rin].Item3,3) && vars.roundZ == Math.Round(vars.chapter3Rin[vars.counterС3Rin].Item4,3) && vars.roundX == Math.Round(vars.chapter3Rin[vars.counterС3Rin].Item5,3))
                {
                    vars.counterС3Rin++;
                    return true;
                }
            }
            else
            {
                vars.counterС3Rin++;
            } 
        }

        // Shion
        if (vars.counterС3Shion <= 8)
        {
            if (settings[(vars.counterС3Shion + 1 + 422).ToString()])
            {
                if (vars.roundY == Math.Round(vars.chapter3Shion[vars.counterС3Shion].Item3,3) && vars.roundZ == Math.Round(vars.chapter3Shion[vars.counterС3Shion].Item4,3) && vars.roundX == Math.Round(vars.chapter3Shion[vars.counterС3Shion].Item5,3))
                {
                    vars.counterС3Shion++;
                    return true;
                }
            }
            else
            {
                vars.counterС3Shion++;
            } 
        }

        // Endings [Not recommended ]
        if (settings["28"] || settings["128"] || settings["228"] || settings["328"] || settings["432"])
        {
            if (vars.roundY == 1f && vars.roundZ == 0f && vars.roundX == 0f && current.creditsStart == 111)
            {
                return true;
            }
        }
        
    }
      
}