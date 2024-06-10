do

	local _detalhes = 		_G.Details
	local addonName, Details222 = ...

	local GetSpellInfo = Details222.GetSpellInfo

	--import potion list from the framework
	_detalhes.PotionList = {}
	for spellID, _ in pairs(DetailsFramework.PotionIDs) do
		_detalhes.PotionList [spellID] = true
	end

	_detalhes.SpecSpellList = { --~spec
		-- Balance Druid:
		[33831] 		= 	102, -- Force of Nature
		[24858] 		= 	102, -- Moonkin Form
		[50516]			= 	102, -- Typhoon (rank 1)
		[53223]			=	102, -- Typhoon (rank 2)
		[53225] 		=	102, -- Typhoon (rank 3)
		[53226] 		= 	102, -- Typhoon (rank 4)
		[61384] 		= 	102, -- Typhoon (rank 5)
		[48505] 		=	102, -- Starfall (rank 1)
		[53199] 		=	102, -- Starfall (rank 2)
		[53200] 		=	102, -- Starfall (rank 3)
		[53201] 		= 	102, -- Starfall (rank 4)

		-- Feral DPS (Cat):
		[33876] 		= 	103, -- Mangle Cat (rank 1)
		[33982]			=	103, -- Mangle Cat (rank 2)
		[33983]			= 	103, -- Mangle Cat (rank 3)
		[48565]			=	103, -- Mangle Cat (rank 4)
		[48566]			=	103, -- Mangle Cat (rank 5)

		-- Feral Tank (Bear) / Guardian Druid:
		[33878] 		= 	104, -- Mangle Bear (rank 1)
		[33986] 		= 	104, -- Mangle Bear (rank 2)
		[33987] 		= 	104, -- Mangle Bear (rank 3)
		[48563]			= 	104, -- Mangle Bear (rank 4)
		[48564]			= 	104, -- Mangle Bear (rank 5)

		-- Restoration Druid:
		[33891] 		= 	105, -- Tree of Life
		[18562] 		= 	105, -- Swiftmend
		[48438]			=	105, -- Wild Growth (rank 1)
		[53248]			=	105, -- Wild Growth (rank 2)
		[53249]			= 	105, -- Wild Growth (rank 3)
		[53251]			=	105, -- Wild Growth (rank 4)

		-- Beast Mastery Hunter:
		[19574]			=	253, -- Bestial Wrath
		[53257]			=	253, -- Cobra Strikes

		-- Marksmanship Hunter:
		[34490]			=	254, -- Silecing Shot
		[19506]			=	254, -- Trueshot Aura
		[53209]			=	254, -- Chimera Shot

		-- Survival Hunter:
		[19386]			=	255, -- Wyvern Sting (rank 1)
		[24132]			=	255, -- Wyvern Sting (rank 2)
		[24133]			=	255, -- Wyvern Sting (rank 3)
		[27068]			=	255, -- Wyvern Sting (rank 4)
		[49011]			=	255, -- Wyvern Sting (rank 5)
		[49012]			=	255, -- Wyvern Sting (rank 6)
		[3674]			= 	255, -- Black Arrow (rank 1)
		[63668]			=	255, -- Black Arrow (rank 2)
		[63669]			= 	255, -- Black Arrow (rank 3)
		[63670]			=	255, -- Black Arrow (rank 4)
		[63671]			=	255, -- Black Arrow (rank 5)
		[63672]			=	255, -- Black Arrow (rank 6)
		[53301]			=	255, -- Explosive Shot (rank 1)
		[60051]			=	255, -- Explosive Shot (rank 2)
		[60052]			=	255, -- Explosive Shot (rank 3)
		[60053]			=	255, -- Explosive Shot (rank 4)

		-- Arcane Mage:
		[12043]			=	62, -- Presence of Mind
		[12042]			=	62, -- Arcane Power
		[31589]			=	62, -- Slow
		[44425]			=	62, -- Arcane Barrage (rank 1)
		[44780]			=	62, -- Arcane Barrage (rank 2)
		[44781]			=	62, -- Arcane Barrage (rank 3)

		-- Fire Mage:
		[28682]			=	63, -- Combustion
		[48108]			=	63, -- Hot Streak
		[31661]			=	63, -- Dragon's Breath (rank 1)
		[33041]			=	63, -- Dragon's Breath (rank 2)
		[33042]			=	63, -- Dragon's Breath (rank 3)
		[33043]			=	63, -- Dragon's Breath (rank 4)
		[42949]			=	63, -- Dragon's Breath (rank 5)
		[42950]			=	63, -- Dragon's Breath (rank 6)
		[44457]			=	63, -- Living Bomb (rank 1)
		[55359]			=	63, -- Living Bomb (rank 2)
		[55360]			=	63, -- Living Bomb (rank 3)

		-- Frost Mage:
		[11426]			=	64, -- Ice Barrier (rank 1)
		[13031]			=	64, -- Ice Barrier (rank 2)
		[13032]			=	64, -- Ice Barrier (rank 3)
		[13033]			=	64, -- Ice Barrier (rank 4)
		[27134]			=	64, -- Ice Barrier (rank 5)
		[33405]			=	64, -- Ice Barrier (rank 6)
		[43038]			=	64, -- Ice Barrier (rank 7)
		[43039]			=	64, -- Ice Barrier (rank 8)
		[44544]			=	64, -- Fingers of Frost
		[57761]			=	64, -- Fireball! (Brain Freeze talent)
		[31687]			=	64, -- Summon Water Elemental
		[44572]			=	64, -- Deep Freeze

		-- Holy Paladin:
		[20473]			=	65, -- Holy Shock (rank 1)
		[20929]			=	65, -- Holy Shock (rank 2)
		[20930]			=	65, -- Holy Shock (rank 3)
		[27174]			=	65, -- Holy Shock (rank 4)
		[33072]			=	65, -- Holy Shock (rank 5)
		[48824]			=	65, -- Holy Shock (rank 6)
		[48825]			=	65, -- Holy Shock (rank 7)
		[31842]			=	65, -- Divine Illumination
		[53563]			=	65, -- Beacon of Light

		-- Protection Paladin:
		[20925]			=	66, -- Holy Shield (rank 1)
		[20927]			=	66, -- Holy Shield (rank 2)
		[20928]			=	66, -- Holy Shield (rank 3)
		[27179]			=	66, -- Holy Shield (rank 4)
		[48951]			=	66, -- Holy Shield (rank 5)
		[48952]			=	66, -- Holy Shield (rank 6)
		[31935]			=	66, -- Avenger's Shield (rank 1)
		[32699]			=	66, -- Avenger's Shield (rank 2)
		[32700]			=	66, -- Avenger's Shield (rank 3)
		[48826]			=	66, -- Avenger's Shield (rank 4)
		[48827]			=	66, -- Avenger's Shield (rank 5)
		[53595]			=	66, -- Hammer of the Righteous

		-- Retribution Paladin:
		[53489]			=	70, -- The Art of War (rank 1)
		[59578]			=	70, -- The Art of War (rank 2)
		[20066]			=	70, -- Repentance
		[35395]			=	70, -- Crusader Strike
		[53385]			=	70, -- Divine Storm

		-- Discipline Priest:
		--[63944]			=	256, -- Renewed Hope
		[10060]			=	256, -- Power Infusion
		[33206]			=	256, -- Pain Suppression
		[47540]			=	256, -- Penance (rank 1)
		[53005]			=	256, -- Penance (rank 2)
		[53006]			=	256, -- Penance (rank 3)
		[53007]			=	256, -- Penance (rank 4)

		-- Holy Priest:
		[20711]			=	257, -- Spirit of Redemption
		[724]			=	257, -- Lightwell (rank 1)
		[27870]			=	257, -- Lightwell (rank 2)
		[27871]			=	257, -- Lightwell (rank 3)
		[27875]			=	257, -- Lightwell (rank 4)
		[48086]			=	257, -- Lightwell (rank 5)
		[48087]			=	257, -- Lightwell (rank 6)
		[34861]			=	257, -- Circle of Healing (rank 1)
		[34863]			=	257, -- Circle of Healing (rank 2)
		[34864]			=	257, -- Circle of Healing (rank 3)
		[34865]			=	257, -- Circle of Healing (rank 4)
		[34866]			=	257, -- Circle of Healing (rank 5)
		[48088]			=	257, -- Circle of Healing (rank 6)
		[48089]			=	257, -- Circle of Healing (rank 7)
		[47788]			=	257, -- Guardian Spirit

		-- Shadow Priest:
		[15286]			=	258, -- Vampiric Embrace
		[15473]			=	258, -- Shadowform
		[34914]			=	258, -- Vampiric Touch (rank 1)
		[34916]			=	258, -- Vampiric Touch (rank 2)
		[34917]			=	258, -- Vampiric Touch (rank 3)
		[48159]			=	258, -- Vampiric Touch (rank 4)
		[48160]			=	258, -- Vampiric Touch (rank 5)
		[47585]			=	258, -- Dispersion

		-- Assassination Rogue:
		[58427]			=	259, -- Overkill
		[1329]			=	259, -- Mutilate (rank 1)
		[34411]			=	259, -- Mutilate (rank 2)
		[34412]			=	259, -- Mutilate (rank 3)
		[34413]			=	259, -- Mutilate (rank 4)
		[48663]			=	259, -- Mutilate (rank 5)
		[48666]			=	259, -- Mutilate (rank 6)
		[52914]			=	259, -- Turn the Tables (rank 1)
		[52915]			=	259, -- Turn the Tables (rank 2)
		[52910]			=	259, -- Turn the Tables (rank 3)
		[51662]			=	259, -- Hunger For Blood

		-- Combat Rogue (Outlaw Rogue):
		[13750]			=	260, -- Adrenaline Rush
		[51690]			=	260, -- Killing Spree
		[58684]			=	260, -- Savage Combat (rank 1)
		[58683]			=	260, -- Savage Combat (rank 2)

		-- Subtlety Rogue:
		[14183]			=	261, -- Premeditation
		[36554]			=	261, -- Shadowstep
		[51713]			=	261, -- Shadow Dance

		-- Elemental Shaman:
		[16166]			=	262, -- Elemental Mastery
		[30706]			=	262, -- Totem of Wrath (rank 1)
		[57720]			=	262, -- Totem of Wrath (rank 2)
		[57721]			=	262, -- Totem of Wrath (rank 3)
		[57722]			=	262, -- Totem of Wrath (rank 4)
		[51490]			=	262, -- Thunderstorm (rank 1)
		[59156]			=	262, -- Thunderstorm (rank 2)
		[59158]			=	262, -- Thunderstorm (rank 3)
		[59159]			=	262, -- Thunderstorm (rank 4)

		-- Enhancement Shaman:
		[17364]			=	263, -- Stormstrike
		[60103]			=	263, -- Lava Lash
		[30823]			=	263, -- Shamanistic Rage
		[53817]			=	263, -- Maelstrom Weapon
		[51533]			=	263, -- Feral Spirit

		-- Restoration Shaman:
		[16190]			=	264, -- Mana Tide Totem
		[51886]			=	264, -- Cleanse Spirit
		[974]			=	264, -- Earth Shield (rank 1)
		[32593]			=	264, -- Earth Shield (rank 2)
		[32594]			=	264, -- Earth Shield (rank 3)
		[49283]			=	264, -- Earth Shield (rank 4)
		[49284]			=	264, -- Earth Shield (rank 5)
		[61295]			=	264, -- Riptide (rank 1)
		[61299]			=	264, -- Riptide (rank 2)
		[61300]			=	264, -- Riptide (rank 3)
		[61301]			=	264, -- Riptide (rank 4)

		-- Affliction Warlock:
		[30108]			=	265, -- Unstable Affliction (rank 1)
		[30404]			=	265, -- Unstable Affliction (rank 2)
		[30405]			=	265, -- Unstable Affliction (rank 3)
		[47841]			=	265, -- Unstable Affliction (rank 4)
		[47843]			=	265, -- Unstable Affliction (rank 5)
		[18220]			=	265, -- Dark Pact (rank 1)
		[18937]			=	265, -- Dark Pact (rank 2)
		[18938]			=	265, -- Dark Pact (rank 3)
		[27265]			=	265, -- Dark Pact (rank 4)
		[59092]			=	265, -- Dark Pact (rank 5)
		[48181]			=	265, -- Haunt (rank 1)
		[59161]			=	265, -- Haunt (rank 2)
		[59163]			=	265, -- Haunt (rank 3)
		[59164]			=	265, -- Haunt (rank 4)

		-- Demonology Warlock:
		[30146]			=	266, -- Summon Felguard
		-- [48090]			=	266, -- Demonic Pact -- Need confirmation for WotLK Classic whether this is the right buff
		[47383]			=	266, -- Molten Core (rank 1)
		[71162]			=	266, -- Molten Core (rank 2)
		[71165]			=	266, -- Molten Core (rank 3)
		[63165]			=	266, -- Decimation (rank 1)
		[63167]			=	266, -- Decimation (rank 2)
		[47241]			=	266, -- Metamorphosis

		-- Destruction Warlock:
		[17962]			=	267, -- Conflagrate
		[30283]			=	267, -- Shadowfury (rank 1)
		[30413]			=	267, -- Shadowfury (rank 2)
		[30414]			=	267, -- Shadowfury (rank 3)
		[47846]			=	267, -- Shadowfury (rank 4)
		[47847]			=	267, -- Shadowfury (rank 5)
		[50796]			=	267, -- Chaos Bolt (rank 1)
		[59170]			=	267, -- Chaos Bolt (rank 2)
		[59171]			=	267, -- Chaos Bolt (rank 3)
		[59172]			=	267, -- Chaos Bolt (rank 4)

		-- Arms Warrior:
		[46856]			=	71, -- Trauma (rank 1)
		[46857]			=	71, -- Trauma (rank 2)
		[12294]			=	71, -- Mortal Strike (rank 1)
		[21551]			=	71, -- Mortal Strike (rank 2)
		[21552]			=	71, -- Mortal Strike (rank 3)
		[21553]			=	71, -- Mortal Strike (rank 4)
		[25248]			=	71, -- Mortal Strike (rank 5)
		[30330]			=	71, -- Mortal Strike (rank 6)
		[47485]			=	71, -- Mortal Strike (rank 7)
		[47486]			=	71, -- Mortal Strike (rank 8)
		[29623]			=	71, -- Endless Rage
		[46924]			=	71, -- Bladestorm

		-- Fury Warrior:
		[29801]			=	72, -- Rampage
		[23881]			=	72, -- Bloodthirst

		-- Protection Warrior:
		[50720]			=	73, -- Vigilance
		[20243]			=	73, -- Devastate (rank 1)
		[30016]			=	73, -- Devastate (rank 2)
		[30022]			=	73, -- Devastate (rank 3)
		[47497]			=	73, -- Devastate (rank 4)
		[47498]			=	73, -- Devastate (rank 5)
		[50227]			=	73, -- Sword and Board
		[46968]			=	73, -- Shockwave

		-- Blood Death Knight:
		[53137]			=	250, -- Abomination's Might (rank 1)
		[53138]			=	250, -- Abomination's Might (rank 2)
		[50452]			=	250, -- Bloodworms
		[49016]			=	250, -- Hysteria
		[55233]			=	250, -- Vampiric Blood
		[55050]			=	250, -- Heart Strike (rank 1)
		[55258]			=	250, -- Heart Strike (rank 2)
		[55259]			=	250, -- Heart Strike (rank 3)
		[55260]			=	250, -- Heart Strike (rank 4)
		[55261]			=	250, -- Heart Strike (rank 5)
		[55262]			=	250, -- Heart Strike (rank 6)
		[49028]			=	250, -- Dancing Rune Weapon

		-- Frost Death Knight:
		[49203]			=	251, -- Hungering Cold
		[51271]			=	251, -- Unbreakable Armor
		[49143]			=	251, -- Frost Strike (rank 1)
		[51416]			=	251, -- Frost Strike (rank 2)
		[51417]			=	251, -- Frost Strike (rank 3)
		[51418]			=	251, -- Frost Strike (rank 4)
		[51419]			=	251, -- Frost Strike (rank 5)
		[55268]			=	251, -- Frost Strike (rank 6)
		[49184]			=	251, -- Howling Blast (rank 1)
		[51409]			=	251, -- Howling Blast (rank 2)
		[51410]			=	251, -- Howling Blast (rank 3)
		[51411]			=	251, -- Howling Blast (rank 4)

		-- Unholy Death Knight:
		[51052]			=	252, -- Anti-Magic Zone
		[63583]			=	252, -- Desolation (rank 1)
		[66800]			=	252, -- Desolation (rank 2)
		[66801]			=	252, -- Desolation (rank 3)
		[66802]			=	252, -- Desolation (rank 4)
		[66803]			=	252, -- Desolation (rank 5)
		[49222]			=	252, -- Bone Shield
		[51726]			=	252, -- Ebon Plague (rank 1)
		[51734]			=	252, -- Ebon Plague (rank 2)
		[51735]			=	252, -- Ebon Plague (rank 3)
		[55090]			=	252, -- Scourge Strike (rank 1)
		[55265]			=	252, -- Scourge Strike (rank 2)
		[55270]			=	252, -- Scourge Strike (rank 3)
		[55271]			=	252, -- Scourge Strike (rank 4)
		[49206]			=	252, -- Summon Gargoyle
	}

	_detalhes.SpecIDToClass = {}
	for _, class in ipairs(CLASS_SORT_ORDER) do
		local specs = C_ClassInfo.GetAllSpecs(class)
		for index, spec in ipairs(specs) do
			local specInfo = C_ClassInfo.GetSpecInfo(class, spec)
			_detalhes.SpecIDToClass[specInfo.ID] = class
		end
	end

	_detalhes.ClassSpellList = {
		-- [spellID] = "CLASS"	
	}
	-- redirect AbsorbSpells to check IsAbsorbSpell
	-- only true if mask = 127 (absorbs all schools/phys)
	_detalhes.AbsorbSpells = setmetatable({}, { __index = function(t,k) local isAbsorb, mask = IsAbsorbSpell(k) return isAbsorb and mask == 127  end })

	local allowedCooldownTypes = { --LIB_OPEN_RAID_COOLDOWNS_INFO types
		[1] = false, --attack
		[2] = true, --defensive
		[3] = true, --defensive
		[4] = true, --defensive
		[5] = false, --utility
		[6] = false, --interrupt
		[7] = false, --dispel
		[8] = false, --crowd control
		[9] = false, --racials
		[10] = false, --item heal
		[11] = false, --item power
		[12] = false, --item utility
	}

	local getCooldownsForClass = function(class)
		local result = {}
		--Use LibOpenRaid if possible. Otherwise fallback to DF.
		if (LIB_OPEN_RAID_COOLDOWNS_INFO) then
			for spellId, spellInfo in pairs(LIB_OPEN_RAID_COOLDOWNS_INFO) do
				if (class == spellInfo.class and allowedCooldownTypes[spellInfo.type]) then
					result[#result+1] = spellId
				end
			end
		else
			for spellId, spellInfo in pairs(_G.DetailsFramework.CooldownsInfo) do
				if (class == spellInfo.class) then
					result[#result+1] = spellId
				end
			end
		end
		return result
	end

	_detalhes.DefensiveCooldownSpells = {}
	for _, class in ipairs(CLASS_SORT_ORDER) do
		_detalhes.DefensiveCooldownSpells[class] = getCooldownsForClass(class)
	end

	_detalhes.HarmfulSpells = {
		-- [spellID] = true,
	}

	_detalhes.MiscClassSpells = {
		-- [spellID] = true,
	}

	_detalhes.AttackCooldownSpells = {
		-- [spellID] = true,
	}

	_detalhes.HelpfulSpells = {
		-- [spellID] = true,
	}


	_detalhes.SpellOverwrite = {
		--[124464] = {name = GetSpellInfo(124464) .. " (" .. Loc ["STRING_MASTERY"] .. ")"}, --shadow word: pain mastery proc (priest)
	}

	_detalhes.spells_school = {
		[1] = {name = STRING_SCHOOL_PHYSICAL , formated = "|cFFFFFF00" .. STRING_SCHOOL_PHYSICAL .. "|r", hex = "FFFFFF00", rgb = {255, 255, 0}, decimals = {1.00, 1.00, 0.00}},
		[2] = {name = STRING_SCHOOL_HOLY , formated = "|cFFFFE680" .. STRING_SCHOOL_HOLY .. "|r", hex = "FFFFE680", rgb = {255, 230, 128}, decimals = {1.00, 0.90, 0.50}},
		[4] = {name = STRING_SCHOOL_FIRE , formated = "|cFFFF8000" .. STRING_SCHOOL_FIRE .. "|r", hex = "FFFF8000", rgb = {255, 128, 0}, decimals = {1.00, 0.50, 0.00}},
		[8] = {name = STRING_SCHOOL_NATURE , formated = "|cFFbeffbe" .. STRING_SCHOOL_NATURE .. "|r", hex = "FFbeffbe", rgb = {190, 190, 190}, decimals = {0.7451, 1.0000, 0.7451}},
		[16] = {name = STRING_SCHOOL_FROST, formated = "|cFF80FFFF" .. STRING_SCHOOL_FROST .. "|r", hex = "FF80FFFF", rgb = {128, 255, 255}, decimals = {0.50, 1.00, 1.00}},
		[32] = {name = STRING_SCHOOL_SHADOW, formated = "|cFF8080FF" .. STRING_SCHOOL_SHADOW .. "|r", hex = "FF8080FF", rgb = {128, 128, 255}, decimals = {0.50, 0.50, 1.00}},
		[64] = {name = STRING_SCHOOL_ARCANE, formated = "|cFFFF80FF" .. STRING_SCHOOL_ARCANE .. "|r", hex = "FFFF80FF", rgb = {255, 128, 255}, decimals = {1.00, 0.50, 1.00}},
		[3] = {name = STRING_SCHOOL_HOLYSTRIKE , formated = "|cFFFFF240" .. STRING_SCHOOL_HOLYSTRIKE  .. "|r", hex = "FFFFF240", rgb = {255, 64, 64}, decimals = {1.0000, 0.9490, 0.2510}}, --#FFF240
		[5] = {name = STRING_SCHOOL_FLAMESTRIKE, formated = "|cFFFFB900" .. STRING_SCHOOL_FLAMESTRIKE .. "|r", hex = "FFFFB900", rgb = {255, 0, 0}, decimals = {1.0000, 0.7255, 0.0000}}, --#FFB900
		[6] = {name = STRING_SCHOOL_HOLYFIRE , formated = "|cFFFFD266" .. STRING_SCHOOL_HOLYFIRE  .. "|r", hex = "FFFFD266", rgb = {255, 102, 102}, decimals = {1.0000, 0.8235, 0.4000}}, --#FFD266
		[9] = {name = STRING_SCHOOL_STORMSTRIKE, formated = "|cFFAFFF23" .. STRING_SCHOOL_STORMSTRIKE .. "|r", hex = "FFAFFF23", rgb = {175, 35, 35}, decimals = {0.6863, 1.0000, 0.1373}}, --#AFFF23
		[10] = {name = STRING_SCHOOL_HOLYSTORM , formated = "|cFFC1EF6E" .. STRING_SCHOOL_HOLYSTORM  .. "|r", hex = "FFC1EF6E", rgb = {193, 110, 110}, decimals = {0.7569, 0.9373, 0.4314}}, --#C1EF6E
		[12] = {name = STRING_SCHOOL_FIRESTORM, formated = "|cFFAFB923" .. STRING_SCHOOL_FIRESTORM .. "|r", hex = "FFAFB923", rgb = {175, 35, 35}, decimals = {0.6863, 0.7255, 0.1373}}, --#AFB923
		[17] = {name = STRING_SCHOOL_FROSTSTRIKE , formated = "|cFFB3FF99" .. STRING_SCHOOL_FROSTSTRIKE .. "|r", hex = "FFB3FF99", rgb = {179, 153, 153}, decimals = {0.7020, 1.0000, 0.6000}},--#B3FF99
		[18] = {name = STRING_SCHOOL_HOLYFROST , formated = "|cFFCCF0B3" .. STRING_SCHOOL_HOLYFROST  .. "|r", hex = "FFCCF0B3", rgb = {204, 179, 179}, decimals = {0.8000, 0.9412, 0.7020}},--#CCF0B3
		[20] = {name = STRING_SCHOOL_FROSTFIRE, formated = "|cFFC0C080" .. STRING_SCHOOL_FROSTFIRE .. "|r", hex = "FFC0C080", rgb = {192, 128, 128}, decimals = {0.7529, 0.7529, 0.5020}}, --#C0C080
		[24] = {name = STRING_SCHOOL_FROSTSTORM, formated = "|cFF69FFAF" .. STRING_SCHOOL_FROSTSTORM .. "|r", hex = "FF69FFAF", rgb = {105, 175, 175}, decimals = {0.4118, 1.0000, 0.6863}}, --#69FFAF
		[33] = {name = STRING_SCHOOL_SHADOWSTRIKE , formated = "|cFFC6C673" .. STRING_SCHOOL_SHADOWSTRIKE .. "|r", hex = "FFC6C673", rgb = {198, 115, 115}, decimals = {0.7765, 0.7765, 0.4510}},--#C6C673
		[34] = {name = STRING_SCHOOL_SHADOWHOLY, formated = "|cFFD3C2AC" .. STRING_SCHOOL_SHADOWHOLY .. "|r", hex = "FFD3C2AC", rgb = {211, 172, 172}, decimals = {0.8275, 0.7608, 0.6745}},--#D3C2AC
		[36] = {name = STRING_SCHOOL_SHADOWFLAME , formated = "|cFFB38099" .. STRING_SCHOOL_SHADOWFLAME  .. "|r", hex = "FFB38099", rgb = {179, 153, 153}, decimals = {0.7020, 0.5020, 0.6000}}, -- #B38099
		[40] = {name = STRING_SCHOOL_SHADOWSTORM, formated = "|cFF6CB3B8" .. STRING_SCHOOL_SHADOWSTORM .. "|r", hex = "FF6CB3B8", rgb = {108, 184, 184}, decimals = {0.4235, 0.7020, 0.7216}}, --#6CB3B8
		[48] = {name = STRING_SCHOOL_SHADOWFROST , formated = "|cFF80C6FF" .. STRING_SCHOOL_SHADOWFROST  .. "|r", hex = "FF80C6FF", rgb = {128, 255, 255}, decimals = {0.5020, 0.7765, 1.0000}},--#80C6FF
		[65] = {name = STRING_SCHOOL_SPELLSTRIKE, formated = "|cFFFFCC66" .. STRING_SCHOOL_SPELLSTRIKE .. "|r", hex = "FFFFCC66", rgb = {255, 102, 102}, decimals = {1.0000, 0.8000, 0.4000}},--#FFCC66
		[66] = {name = STRING_SCHOOL_DIVINE, formated = "|cFFFFBDB3" .. STRING_SCHOOL_DIVINE .. "|r", hex = "FFFFBDB3", rgb = {255, 179, 179}, decimals = {1.0000, 0.7412, 0.7020}},--#FFBDB3
		[68] = {name = STRING_SCHOOL_SPELLFIRE, formated = "|cFFFF808C" .. STRING_SCHOOL_SPELLFIRE .. "|r", hex = "FFFF808C", rgb = {255, 140, 140}, decimals = {1.0000, 0.5020, 0.5490}}, --#FF808C
		[72] = {name = STRING_SCHOOL_SPELLSTORM, formated = "|cFFAFB9AF" .. STRING_SCHOOL_SPELLSTORM .. "|r", hex = "FFAFB9AF", rgb = {175, 175, 175}, decimals = {0.6863, 0.7255, 0.6863}}, --#AFB9AF
		[80] = {name = STRING_SCHOOL_SPELLFROST , formated = "|cFFC0C0FF" .. STRING_SCHOOL_SPELLFROST  .. "|r", hex = "FFC0C0FF", rgb = {192, 255, 255}, decimals = {0.7529, 0.7529, 1.0000}},--#C0C0FF
		[96] = {name = STRING_SCHOOL_SPELLSHADOW, formated = "|cFFB980FF" .. STRING_SCHOOL_SPELLSHADOW .. "|r", hex = "FFB980FF", rgb = {185, 255, 255}, decimals = {0.7255, 0.5020, 1.0000}},--#B980FF

		[28] = {name = STRING_SCHOOL_ELEMENTAL, formated = "|cFF0070DE" .. STRING_SCHOOL_ELEMENTAL .. "|r", hex = "FF0070DE", rgb = {0, 222, 222}, decimals = {0.0000, 0.4392, 0.8706}},
		[124] = {name = STRING_SCHOOL_CHROMATIC, formated = "|cFFC0C0C0" .. STRING_SCHOOL_CHROMATIC .. "|r", hex = "FFC0C0C0", rgb = {192, 192, 192}, decimals = {0.7529, 0.7529, 0.7529}},
		[126] = {name = STRING_SCHOOL_MAGIC , formated = "|cFF1111FF" .. STRING_SCHOOL_MAGIC  .. "|r", hex = "FF1111FF", rgb = {17, 255, 255}, decimals = {0.0667, 0.0667, 1.0000}},
		[127] = {name = STRING_SCHOOL_CHAOS, formated = "|cFFFF1111" .. STRING_SCHOOL_CHAOS .. "|r", hex = "FFFF1111", rgb = {255, 17, 17}, decimals = {1.0000, 0.0667, 0.0667}},
	--[[custom]]	[1024] = {name = "Reflection", formated = "|cFFFFFFFF" .. "Reflection" .. "|r", hex = "FFFFFFFF", rgb = {255, 255, 255}, decimals = {1, 1, 1}},
	}

	---return the school of a spell, this value is gotten from a cache
	---@param spellID spellid|spellname
	---@return spellschool
	function Details:GetSpellSchool(spellID)
		if (spellID == "number") then
			spellID = GetSpellInfo(spellID)
		end
		local school = Details.spell_school_cache[spellID] or 1
		return school
	end

	---return the name of a spell school
	---@param school spellschool
	---@return string
	function Details:GetSpellSchoolName(school)
		return Details.spells_school [school] and Details.spells_school [school].name or ""
	end

	---return the name of a spell school containing the scape code to color the name by the school color
	---@param school spellschool
	---@return string
	function Details:GetSpellSchoolFormatedName(school)
		return Details.spells_school[school] and Details.spells_school[school].formated or ""
	end

	local default_school_color = {145/255, 180/255, 228/255}
	---return the color of a spell school
	---@param school spellschool
	---@return red, green, blue
	function Details:GetSpellSchoolColor(school)
		return unpack(Details.spells_school[school] and Details.spells_school[school].decimals or default_school_color)
	end

	function Details:GetCooldownList(class)
		class = class or select(2, UnitClass("player"))
		return Details.DefensiveCooldownSpells[class]
	end
end


--save spells of a segment
local SplitLoadFrame = CreateFrame("frame")
local MiscContainerNames = {
    "dispell_spells",
    "cooldowns_defensive_spells",
    "debuff_uptime_spells",
    "buff_uptime_spells",
    "interrupt_spells",
    "cc_done_spells",
    "cc_break_spells",
    "ress_spells",
}
local SplitLoadFunc = function(self, deltaTime)
    --which container it will iterate on this tick
    local container = Details.tabela_vigente and Details.tabela_vigente [SplitLoadFrame.NextActorContainer] and Details.tabela_vigente [SplitLoadFrame.NextActorContainer]._ActorTable

    if (not container) then
        if (Details.debug) then
            --Details:Msg("(debug) finished index spells.")
        end
        SplitLoadFrame:SetScript("OnUpdate", nil)
        return
    end

    local inInstance = IsInInstance()
    local isEncounter = Details.tabela_vigente and Details.tabela_vigente.is_boss
    local encounterID = isEncounter and isEncounter.id

    --get the actor
    local actorToIndex = container [SplitLoadFrame.NextActorIndex]

    --no actor? go to the next container
    if (not actorToIndex) then
        SplitLoadFrame.NextActorIndex = 1
        SplitLoadFrame.NextActorContainer = SplitLoadFrame.NextActorContainer + 1

        --finished all the 4 container? kill the process
        if (SplitLoadFrame.NextActorContainer == 5) then
            SplitLoadFrame:SetScript("OnUpdate", nil)
            if (Details.debug) then
                --Details:Msg("(debug) finished index spells.")
            end
            return
        end
    else
        --++
        SplitLoadFrame.NextActorIndex = SplitLoadFrame.NextActorIndex + 1

        --get the class name or the actor name in case the actor isn't a player
        local source
        if (inInstance) then
            source = RAID_CLASS_COLORS [actorToIndex.classe] and Details.classstring_to_classid [actorToIndex.classe] or actorToIndex.nome
        else
            source = RAID_CLASS_COLORS [actorToIndex.classe] and Details.classstring_to_classid [actorToIndex.classe]
        end

        --if found a valid actor
        if (source) then
            --if is damage, heal or energy
            if (SplitLoadFrame.NextActorContainer == 1 or SplitLoadFrame.NextActorContainer == 2 or SplitLoadFrame.NextActorContainer == 3) then
                --get the spell list in the spells container
                local spellList = actorToIndex.spells and actorToIndex.spells._ActorTable
                if (spellList) then

                    local SpellPool = Details.spell_pool
                    local EncounterSpellPool = Details.encounter_spell_pool

                    for spellID, _ in pairs(spellList) do
                        if (not SpellPool [spellID]) then
                            SpellPool [spellID] = source
                        end
                        if (encounterID and not EncounterSpellPool [spellID]) then
                            if (actorToIndex:IsEnemy()) then
                                EncounterSpellPool [spellID] = {encounterID, source}
                            end
                        end
                    end
                end

            --if is a misc container
            elseif (SplitLoadFrame.NextActorContainer == 4) then
                for _, containerName in ipairs(MiscContainerNames) do
                    --check if the actor have this container
                    if (actorToIndex [containerName]) then
                        local spellList = actorToIndex [containerName]._ActorTable
                        if (spellList) then
                            local spellPool = Details.spell_pool
                            local encounterSpellPool = Details.encounter_spell_pool

                            for spellId, _ in pairs(spellList) do
                                if (not spellPool[spellId]) then
                                    spellPool[spellId] = source
                                end
                                if (encounterID and not encounterSpellPool[spellId]) then
                                    if (actorToIndex:IsEnemy()) then
                                        encounterSpellPool[spellId] = {encounterID, source}
                                    end
                                end
                            end
                        end
                    end
                end

				--[=[ .spell_cast is deprecated
                --spells the actor casted
                if (actorToIndex.spell_cast) then
                    local spellPool = Details.spell_pool
                    local encounterSpellPool = Details.encounter_spell_pool

                    for spellName, _ in pairs(actorToIndex.spell_cast) do
						local _, _, _, _, _, _, spellId = GetSpellInfo(spellName)
						if (spellId) then
							if (not spellPool[spellId]) then
								spellPool[spellId] = source
							end
							if (encounterID and not encounterSpellPool[spellId]) then
								if (actorToIndex:IsEnemy()) then
									encounterSpellPool[spellId] = {encounterID, source}
								end
							end
						end
                    end
                end
				--]=]
            end
        end
    end
end

function Details.StoreSpells()
    if (Details.debug) then
        --Details:Msg("(debug) started to index spells.")
    end
    SplitLoadFrame:SetScript("OnUpdate", SplitLoadFunc)
    SplitLoadFrame.NextActorContainer = 1
    SplitLoadFrame.NextActorIndex = 1
end
