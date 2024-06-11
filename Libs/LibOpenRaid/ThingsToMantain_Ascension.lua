
--data for Ascension.gg

--localization
local gameLanguage = GetLocale()

local L = { --default localization
	["STRING_EXPLOSION"] = "explosion",
	["STRING_MIRROR_IMAGE"] = "Mirror Image",
	["STRING_CRITICAL_ONLY"]  = "critical",
	["STRING_BLOOM"] = "Bloom", --lifebloom 'bloom' healing
	["STRING_GLAIVE"] = "Glaive", --DH glaive toss
	["STRING_MAINTARGET"] = "Main Target",
	["STRING_AOE"] = "AoE", --multi targets
	["STRING_SHADOW"] = "Shadow", --the spell school 'shadow'
	["STRING_PHYSICAL"] = "Physical", --the spell school 'physical'
	["STRING_PASSIVE"] = "Passive", --passive spell
	["STRING_TEMPLAR_VINDCATION"] = "Templar's Vindication", --paladin spell
	["STRING_PROC"] = "proc", --spell proc
	["STRING_TRINKET"] = "Trinket", --trinket
}

if (gameLanguage == "enUS") then
	--default language

elseif (gameLanguage == "deDE") then
	L["STRING_EXPLOSION"] = "Explosion"
	L["STRING_MIRROR_IMAGE"] = "Bilder spiegeln"
	L["STRING_CRITICAL_ONLY"]  = "kritisch"

elseif (gameLanguage == "esES") then
	L["STRING_EXPLOSION"] = "explosión"
	L["STRING_MIRROR_IMAGE"] = "Imagen de espejo"
	L["STRING_CRITICAL_ONLY"]  = "crítico"

elseif (gameLanguage == "esMX") then
	L["STRING_EXPLOSION"] = "explosión"
	L["STRING_MIRROR_IMAGE"] = "Imagen de espejo"
	L["STRING_CRITICAL_ONLY"]  = "crítico"

elseif (gameLanguage == "frFR") then
	L["STRING_EXPLOSION"] = "explosion"
	L["STRING_MIRROR_IMAGE"] = "Effet miroir"
	L["STRING_CRITICAL_ONLY"]  = "critique"

elseif (gameLanguage == "itIT") then
	L["STRING_EXPLOSION"] = "esplosione"
	L["STRING_MIRROR_IMAGE"] = "Immagine Speculare"
	L["STRING_CRITICAL_ONLY"]  = "critico"

elseif (gameLanguage == "koKR") then
	L["STRING_EXPLOSION"] = "폭발"
	L["STRING_MIRROR_IMAGE"] = "미러 이미지"
	L["STRING_CRITICAL_ONLY"]  = "치명타"

elseif (gameLanguage == "ptBR") then
	L["STRING_EXPLOSION"] = "explosão"
	L["STRING_MIRROR_IMAGE"] = "Imagem Espelhada"
	L["STRING_CRITICAL_ONLY"]  = "critico"

elseif (gameLanguage == "ruRU") then
	L["STRING_EXPLOSION"] = "взрыв"
	L["STRING_MIRROR_IMAGE"] = "Зеркальное изображение"
	L["STRING_CRITICAL_ONLY"]  = "критический"

elseif (gameLanguage == "zhCN") then
	L["STRING_EXPLOSION"] = "爆炸"
	L["STRING_MIRROR_IMAGE"] = "镜像"
	L["STRING_CRITICAL_ONLY"]  = "爆击"

elseif (gameLanguage == "zhTW") then
	L["STRING_EXPLOSION"] = "爆炸"
	L["STRING_MIRROR_IMAGE"] = "鏡像"
	L["STRING_CRITICAL_ONLY"]  = "致命"
end

LIB_OPEN_RAID_MANA_POTIONS = {}


LIB_OPEN_RAID_BLOODLUST = {
	[2825] = true, --bloodlust
	[32182] = true, --heroism
}

--which gear slots can be enchanted on the latest retail version of the game
--when the value is a number, the slot only receives enchants for a specific attribute (Enum.PrimaryStat)
LIB_OPEN_RAID_ENCHANT_SLOTS = {
	--[INVSLOT_NECK] = true,
	[INVSLOT_BACK] = true, --for all
	[INVSLOT_CHEST] = true, --for all
	[INVSLOT_FINGER1] = true, --for all
	[INVSLOT_FINGER2] = true, --for all
	[INVSLOT_MAINHAND] = true, --for all
	[INVSLOT_OFFHAND] = true, --for all
	--[INVSLOT_RANGED] = true, --for all
	[INVSLOT_FEET] =  true, --for all
	[INVSLOT_WRIST] = true, --for all
	[INVSLOT_HAND] =  true, --for all
}

LIB_OPEN_RAID_AUGMENTATED_RUNE = 0

LIB_OPEN_RAID_COVENANT_ICONS = {}

LIB_OPEN_RAID_ENCHANT_IDS = {}

LIB_OPEN_RAID_GEM_IDS = {}

LIB_OPEN_RAID_WEAPON_ENCHANT_IDS = {}

LIB_OPEN_RAID_FOOD_BUFF = {}

LIB_OPEN_RAID_FLASK_BUFF = {}

LIB_OPEN_RAID_ALL_POTIONS = {}

LIB_OPEN_RAID_HEALING_POTIONS = {
	-- level 60
	[9421] = true, --Major Healthstone (0/2)
	[19012] = true, --Major Healthstone (1/2)
	[19013] = true, --Major Healthstone (2/2)

	[13446] = true, --Major Healing Potion
	[220889] = true, --Battleground Healing Potion

	-- level 70
	[22103] = true, --Master Healthstone (0/2)
	[22104] = true, --Master Healthstone (1/2)
	[22105] = true, --Master Healthstone (2/2)

	[22829] = true, --Super Healing Potion
	[32947] = true, --Auchenai Healing Potion
	[43531] = true, --Argent Healing Potion
	[220888] = true, --Battleground Healing Potion
	[23822] = true, --Healing Potion Injector (Engineering)
	[33092] = true, --Healing Potion Injector (Engineering)

	-- level 80
	[36892] = true, --Fel Healthstone (0/2)
	[36893] = true, --Fel Healthstone (1/2)
	[36894] = true, --Fel Healthstone (2/2)

	[33447] = true, --Runic Healing Potion
	[41166] = true, --Runic Healing Injector (Engineering)
	[43569] = true, --Endless Healing Potion (Alchemy)
}

LIB_OPEN_RAID_MELEE_SPECS = {}

for _, class in ipairs(CLASS_SORT_ORDER) do
    local specs = C_ClassInfo.GetAllSpecs(class)
    for _, spec in ipairs(specs) do
        local specInfo = C_ClassInfo.GetSpecInfo(class, spec)
		if specInfo.MeleeDPS then
			LIB_OPEN_RAID_MELEE_SPECS[specInfo.ID] = class
		end
    end
end

--tells the duration, requirements and cooldown
--information about a cooldown is mainly get from tooltips
--if talent is required, use the command:
--/dump GetTalentInfo (talentTier, talentColumn, 1)
--example: to get the second talent of the last talent line, use: /dump GetTalentInfo (7, 2, 1)

local ENUM_SPELL_TYPE = {
	AttackCooldown = 1,
	PersonalDefensive = 2,
	ExternalDefensive = 3,
	RaidDefensive = 4,
	PersonalUtility = 5,
	Interrupt = 6,
}

LIB_OPEN_RAID_COOLDOWNS_INFO = {
	--interrupts
	-- Classless
	[6552] =	 {class = "WARRIOR",	specs = {64, 65, 66},	cooldown = 12, silence = 4, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Pummel
	[2139] =	 {class = "MAGE",		specs = {85, 86, 87},	cooldown = 40, silence = 5, talent = false, cooldownWithTalent = 30, 	cooldownTalentId = 435,   type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Counterspell
	[955071] =	 {class = "MAGE",		specs = {85, 86, 87},	cooldown = 35, silence = 2, talent = false, cooldownWithTalent = 25, 	cooldownTalentId = 435,   type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Fizzle
	[15487] =	 {class = "PRIEST",		specs = {78},			cooldown = 45, silence = 4, talent = 552, 	cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Silence (shadow)
	[1766] =	 {class = "ROGUE",		specs = {73, 74, 75},	cooldown = 12, silence = 4, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Kick
	[955070] =	 {class = "PALADIN",	specs = {67, 68, 69},	cooldown = 22, silence = 3, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Rebuke
	[57994] =	 {class = "SHAMAN",		specs = {82, 83, 84},	cooldown = 22, silence = 2, talent = false, cooldownWithTalent = 16, 	cooldownTalentId = 1143,  type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Wind Shear
	[47528] =	 {class = "DEATHKNIGHT",specs = {79, 80, 81},	cooldown = 15, silence = 3, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Mind Freeze
	[47476] =	 {class = "DEATHKNIGHT",specs = {79, 80, 81},	cooldown = 120,silence = 5, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Strangulate
	[78675] =	 {class = "DRUID",		specs = {91},			cooldown = 50, silence = 6, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Solar Beam (balance)
	[34490] =	 {class = "HUNTER",		specs = {71},			cooldown = 30, silence = 2, talent = 926,	cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Silencing Shot (Marksmanship)
	[19647] =	 {class = "WARLOCK",	specs = {88, 89, 90},	cooldown = 60, silence = 6, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = 417	}, --Spell Lock (pet felhunter ability)
	
	--paladin
	-- 67 - Holy
	-- 68 - Protection
	-- 69 - Retribution

	[31884] = 	{cooldown = 120, 	duration = 20, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.AttackCooldown}, --Avenging Wrath
	[498] = 	{cooldown = 60, 	duration = 8, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Divine Protection
	[642] = 	{cooldown = 300, 	duration = 8, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Divine Shield
	[633] = 	{cooldown = 600, 	duration = false, 	specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Lay on Hands
	[1022] = 	{cooldown = 300, 	duration = 10, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Blessing of Protection
	[6940] = 	{cooldown = 120, 	duration = 12, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Blessing of Sacrifice
	[31821] = 	{cooldown = 180, 	duration = 8, 		specs = {67},		 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.RaidDefensive}, --Aura Mastery
	[1044] = 	{cooldown = 25, 	duration = 8, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalUtility}, --Blessing of Freedom
	[853] = 	{cooldown = 60, 	duration = 6, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalUtility}, --Hammer of Justice
	[31850] = 	{cooldown = 120, 	duration = 8, 		specs = {68}, 			talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Ardent Defender

	--warrior
	-- 64 - Arms
	-- 65 - Fury
	-- 66 - Protection

	[227847] = 	{cooldown = 90, 	duration = 5, 		specs = {64},	 		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Bladestorm
	[46924] = 	{cooldown = 60, 	duration = 4, 		specs = {64},		 	talent =22400, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Bladestorm (talent)
	[1719] = 	{cooldown = 90, 	duration = 10, 		specs = {64,65,66},		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Recklessness
	[184364] = 	{cooldown = 120, 	duration = 8, 		specs = {64,65,66},		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Enraged Regeneration
	[12975] = 	{cooldown = 180, 	duration = 15, 		specs = {66}, 			talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Last Stand
	[871] = 	{cooldown = 8, 		duration = 240, 	specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Shield Wall
	[64382]  = 	{cooldown = 180, 	duration = false, 	specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalUtility}, --Shattering Throw
	[5246]  = 	{cooldown = 90, 	duration = 8, 		specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalUtility}, --Intimidating Shout

	--warlock
	-- 88 - Affliction
	-- 89 - Destruction
	-- 90 - Demonology

	[1122] = 	{cooldown = 180, 	duration = 30, 		specs = {88,89,90}, 	talent =false, charges = 1, class = "WARLOCK", type = ENUM_SPELL_TYPE.AttackCooldown}, --Summon Infernal
	[30283] = 	{cooldown = 60, 	duration = 3, 		specs = {88,89,90}, 	talent =false, charges = 1, class = "WARLOCK", type = ENUM_SPELL_TYPE.PersonalUtility}, --Shadowfury
	[333889] = 	{cooldown = 180, 	duration = 15, 		specs = {90}, 			talent =false, charges = 1, class = "WARLOCK", type = ENUM_SPELL_TYPE.PersonalUtility}, --Fel Domination
	[5484] = 	{cooldown = 40, 	duration = 20, 		specs = {88,89,90}, 	talent =23465, charges = 1, class = "WARLOCK", type = ENUM_SPELL_TYPE.PersonalUtility}, --Howl of Terror (talent)

	--shaman
	-- 82 - Elemental
	-- 83 - Enchancment
	-- 84 - Restoration

	[198067] = 	{cooldown = 150, 	duration = 30, 		specs = {82,83,84}, 	talent =false, charges = 1, class = "SHAMAN", type = ENUM_SPELL_TYPE.AttackCooldown}, --Fire Elemental
	[51533] = 	{cooldown = 120, 	duration = 15, 		specs = {83}, 			talent =false, charges = 1, class = "SHAMAN", type = ENUM_SPELL_TYPE.AttackCooldown}, --Feral Spirit
	[108280] = 	{cooldown = 180, 	duration = 10, 		specs = {84}, 			talent =false, charges = 1, class = "SHAMAN", type = ENUM_SPELL_TYPE.RaidDefensive}, --Healing Tide Totem
	[16191] = 	{cooldown = 180, 	duration = 8, 		specs = {8}, 			talent =false, charges = 1, class = "SHAMAN", type = ENUM_SPELL_TYPE.RaidDefensive}, --Mana Tide Totem
	[198103] = 	{cooldown = 300, 	duration = 60, 		specs = {82,83,84}, 	talent =false, charges = 1, class = "SHAMAN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Earth Elemental
	
	--hunter
	-- 70 - Beast Mastery
	-- 71 - Marksmenship
	-- 72 - Survival

	[19574] = 	{cooldown = 90, 	duration = 12, 		specs = {70}, 			talent =false, charges = 1, class = "HUNTER", type = ENUM_SPELL_TYPE.AttackCooldown}, --Bestial Wrath
	[19577] = 	{cooldown = 60, 	duration = 5, 		specs = {70}, 			talent =false, charges = 1, class = "HUNTER", type = ENUM_SPELL_TYPE.PersonalUtility}, --Intimidation
	[187650] = 	{cooldown = 25, 	duration = 60, 		specs = {70,71,72}, 	talent =false, charges = 1, class = "HUNTER", type = ENUM_SPELL_TYPE.PersonalUtility}, --Freezing Trap

	--druid
	-- 91 - Balance
	-- 92 - Feral
	-- 93 - Restoration

	[22812] = 	{cooldown = 60, 	duration = 12, 		specs = {91,92,93}, 		talent =false, charges = 1, class = "DRUID", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Barkskin
	[29166] = 	{cooldown = 180, 	duration = 12, 		specs = {91,92,93}, 		talent =false, charges = 1, class = "DRUID", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Innervate
	[106951] = 	{cooldown = 180, 	duration = 15, 		specs = {92}, 				talent =false, charges = 1, class = "DRUID", type = ENUM_SPELL_TYPE.AttackCooldown}, --Berserk
	[740] = 	{cooldown = 180, 	duration = 8, 		specs = {91,92,93}, 		talent =false, charges = 1, class = "DRUID", type = ENUM_SPELL_TYPE.RaidDefensive}, --Tranquility
	[132469] = 	{cooldown = 30, 	duration = false, 	specs = {91}, 				talent =false, charges = 1, class = "DRUID", type = ENUM_SPELL_TYPE.PersonalUtility}, --Typhoon

	--death knight
	-- 79 - Blood
	-- 80 - Frost
	-- 81 - Unholy

	[42650] = 	{cooldown = 480, 	duration = 30, 		specs = {79,80,81}, 	talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.AttackCooldown}, --Army of the Dead
	[49206] = 	{cooldown = 180, 	duration = 30, 		specs = {81}, 			talent =22110, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.AttackCooldown}, --Summon Gargoyle (talent)
	[48743] = 	{cooldown = 120, 	duration = 15, 		specs = {79}, 			talent =23373, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Death Pact (talent)
	[48707] = 	{cooldown = 60, 	duration = 10, 		specs = {79,80,81}, 	talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Anti-magic Shell
	[47568] = 	{cooldown = 120, 	duration = 20, 		specs = {80}, 			talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.AttackCooldown}, --Empower Rune Weapon
	[49028] = 	{cooldown = 120, 	duration = 8, 		specs = {79}, 			talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.AttackCooldown}, --Dancing Rune Weapon
	[55233] = 	{cooldown = 90, 	duration = 10, 		specs = {79}, 			talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Vampiric Blood
	[48792] = 	{cooldown = 120, 	duration = 8, 		specs = {79,80,81}, 	talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Icebound Fortitude
	[51052] = 	{cooldown = 120, 	duration = 10, 		specs = {80}, 			talent =false, charges = 1, class = "DEATHKNIGHT", type = ENUM_SPELL_TYPE.RaidDefensive}, --Anti-magic Zone
	
	--mage
	-- 85 - Arcane
	-- 86 - Fire
	-- 87 - Frost

	[12042] = 	{cooldown = 90, 	duration = 10, 		specs = {85}, 			talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Arcane Power
	[12051] = 	{cooldown = 90, 	duration = 6, 		specs = {85,86,87}, 	talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Evocation
	[11426] = 	{cooldown = 25, 	duration = 60, 		specs = {87}, 			talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.PersonalUtility},  --Ice Barrier
	[190319] = 	{cooldown = 120, 	duration = 10, 		specs = {86}, 			talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Combustion
	[55342] = 	{cooldown = 120, 	duration = 40, 		specs = {85,86,87}, 	talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Mirror Image
	[66] = 		{cooldown = 300, 	duration = 20, 		specs = {85,86,87}, 	talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.PersonalDefensive},  --Invisibility
	[12472] = 	{cooldown = 180, 	duration = 20, 		specs = {87}, 			talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Icy Veins
	[45438] = 	{cooldown = 240, 	duration = 10, 		specs = {85,86,87}, 	talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.PersonalDefensive},  --Ice Block
	[235219] = 	{cooldown = 300, 	duration = false, 	specs = {87}, 			talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.PersonalUtility},  --Cold Snap
	[113724] = 	{cooldown = 45, 	duration = 10, 		specs = {85,86,87}, 	talent =false, charges = 1, class = "MAGE", type = ENUM_SPELL_TYPE.PersonalUtility},  --Ring of Frost (talent)

	--priest
	-- 76 - Discipline
	-- 77 - Holy
	-- 78 - Shadow

	[10060] = 	{cooldown = 120, 	duration = 20, 		specs = {76}, 			talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.AttackCooldown},  --Power Infusion
	[34433] = 	{cooldown = 180, 	duration = 15, 		specs = {78}, 			talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.AttackCooldown},  --Shadowfiend
	[33206] = 	{cooldown = 180, 	duration = 8, 		specs = {76}, 			talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.ExternalDefensive},  --Pain Suppression
	[64843] = 	{cooldown = 180, 	duration = 8, 		specs = {76,77,78}, 	talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.RaidDefensive},  --Divine Hymn
	[64901] = 	{cooldown = 300, 	duration = 6, 		specs = {76,77,78}, 	talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.RaidDefensive},  --Symbol of Hope
	[8122] = 	{cooldown = 60, 	duration = 8, 		specs = {76,77,78}, 	talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.PersonalUtility},  --Psychic Scream
	[47585] = 	{cooldown = 120, 	duration = 6, 		specs = {78}, 			talent =false, charges = 1, class = "PRIEST", type = ENUM_SPELL_TYPE.PersonalDefensive},  --Dispersion

	--rogue
	-- 73 - Assasination
	-- 74 - Combat
	-- 75 - Subtlety

	[1856] = 	{cooldown = 120, 	duration = 3, 		specs = {73,74,75}, 	talent =false, charges = 1, class = "ROGUE", type = ENUM_SPELL_TYPE.PersonalDefensive},  --Vanish
	[5277] = 	{cooldown = 120, 	duration = 10, 		specs = {73,74,75}, 	talent =false, charges = 1, class = "ROGUE", type = ENUM_SPELL_TYPE.PersonalDefensive},  --Evasion
	[31224] = 	{cooldown = 120, 	duration = 5, 		specs = {73,74,75}, 	talent =false, charges = 1, class = "ROGUE", type = ENUM_SPELL_TYPE.PersonalDefensive},  --Cloak of Shadows
	[2094] = 	{cooldown = 120, 	duration = 60, 		specs = {73,74,75}, 	talent =false, charges = 1, class = "ROGUE", type = ENUM_SPELL_TYPE.PersonalUtility},  --Blind
	[13750] = 	{cooldown = 180, 	duration = 20, 		specs = {74}, 			talent =false, charges = 1, class = "ROGUE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Adrenaline Rush
	[51690] = 	{cooldown = 120, 	duration = 2, 		specs = {74}, 			talent =23175, charges = 1, class = "ROGUE", type = ENUM_SPELL_TYPE.AttackCooldown},  --Killing Spree (talent)
}

--this table store all cooldowns the player currently have available
LIB_OPEN_RAID_PLAYERCOOLDOWNS = {}

LIB_OPEN_RAID_COOLDOWNS_BY_SPEC = {};
for spellID,spellData in pairs(LIB_OPEN_RAID_COOLDOWNS_INFO) do
	for _,specID in ipairs(spellData.specs) do
		LIB_OPEN_RAID_COOLDOWNS_BY_SPEC[specID] = LIB_OPEN_RAID_COOLDOWNS_BY_SPEC[specID] or {};
		LIB_OPEN_RAID_COOLDOWNS_BY_SPEC[specID][spellID] = spellData.type;
	end
end

--list of all crowd control spells
--it is not transmitted to other clients
LIB_OPEN_RAID_CROWDCONTROL = { --copied from retail
	[334693] = {cooldown = 0,	class = "DEAHTKNIGHT"}, --Absolute Zero
	[221562] = {cooldown = 45,	class = "DEATHKNIGHT"}, --Asphyxiate
	[47528] = {cooldown = 15,	class = "DEATHKNIGHT"}, --Mind Freeze
	[207167] = {cooldown = 60,	class = "DEATHKNIGHT"}, --Blinding Sleet
	[91807] = {cooldown = 0,	class = "DEATHKNIGHT"}, --Shambling Rush
	[108194] = {cooldown = 45,	class = "DEATHKNIGHT"}, --Asphyxiate
	[211881] = {cooldown = 30,	class = "DEMONHUNTER"}, --Fel Eruption
	[200166] = {cooldown = 0,	class = "DEMONHUNTER"}, --Metamorphosis
	[217832] = {cooldown = 45,	class = "DEMONHUNTER"}, --Imprison
	[183752] = {cooldown = 15,	class = "DEMONHUNTER"}, --Disrupt
	[207685] = {cooldown = 0,	class = "DEMONHUNTER"}, --Sigil of Misery
	[179057] = {cooldown = 45,	class = "DEMONHUNTER"}, --Chaos Nova
	[221527] = {cooldown = 45,	class = "DEMONHUNTER"}, --Imprison with detainment talent
	[339] = {cooldown = 0,		class = "DRUID"}, --Entangling Roots
	[102359] = {cooldown = 30,	class = "DRUID"}, --Mass Entanglement
	[93985] = {cooldown = 0,	class = "DRUID"}, --Skull Bash
	[2637] = {cooldown = 0,		class = "DRUID"}, --Hibernate
	[5211] = {cooldown = 60,	class = "DRUID"}, --Mighty Bash
	[99] = {cooldown = 30,		class = "DRUID"}, --Incapacitating Roar
	[127797] = {cooldown = 0,	class = "DRUID"}, --Ursol's Vortex
	[203123] = {cooldown = 0,	class = "DRUID"}, --Maim
	[45334] = {cooldown = 0,	class = "DRUID"}, --Immobilized
	[33786] = {cooldown = 0,	class = "DRUID"}, --Cyclone
	[236748] = {cooldown = 30,	class = "DRUID"}, --Intimidating Roar
	[61391] = {cooldown = 0,	class = "DRUID"}, --Typhoon
	[163505] = {cooldown = 0,	class = "DRUID"}, --Rake
	[50259] = {cooldown = 0,	class = "DRUID"}, --Dazed
	[162480] = {cooldown = 0,	class = "HUNTER"}, --Steel Trap
	[187707] = {cooldown = 15,	class = "HUNTER"}, --Muzzle
	[147362] = {cooldown = 24,	class = "HUNTER"}, --Counter Shot
	[190927] = {cooldown = 6,	class = "HUNTER"}, --Harpoon
	[117526] = {cooldown = 45,	class = "HUNTER"}, --Binding Shot
	[24394] = {cooldown = 0,	class = "HUNTER"}, --Intimidation
	[117405] = {cooldown = 0,	class = "HUNTER"}, --Binding Shot
	[19577] = {cooldown = 60,	class = "HUNTER"}, --Intimidation
	[1513] = {cooldown = 0,		class = "HUNTER"}, --Scare Beast
	[3355] = {cooldown = 30,	class = "HUNTER"}, --Freezing Trap
	[203337] = {cooldown = 30,	class = "HUNTER"}, --Freezing trap with diamond ice talent
	[31661] = {cooldown = 45,	class = "MAGE"}, --Dragon's Breath
	[161353] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[277787] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[157981] = {cooldown = 30,	class = "MAGE"}, --Blast Wave
	[82691] = {cooldown = 0,	class = "MAGE"}, --Ring of Frost
	[118] = {cooldown = 0,		class = "MAGE"}, --Polymorph
	[161354] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[157997] = {cooldown = 25,	class = "MAGE"}, --Ice Nova
	[391622] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[28271] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[122] = {cooldown = 0,		class = "MAGE"}, --Frost Nova
	[277792] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[61721] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[126819] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[61305] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[28272] = {cooldown = 0,	class = "MAGE"}, --Polymorph
	[2139] = {cooldown = 24,	class = "MAGE"}, --Counterspell
	[198909] = {cooldown = 0,	class = "MONK"}, --Song of Chi-Ji
	[119381] = {cooldown = 60,	class = "MONK"}, --Leg Sweep
	[107079] = {cooldown = 120,	class = "MONK"}, --Quaking Palm
	[116706] = {cooldown = 0,	class = "MONK"}, --Disable
	[115078] = {cooldown = 45,	class = "MONK"}, --Paralysis
	[116705] = {cooldown = 15,	class = "MONK"}, --Spear Hand Strike
	[31935] = {cooldown = 15,	class = "PALADIN"}, --Avenger's Shield
	[20066] = {cooldown = 15,	class = "PALADIN"}, --Repentance
	[217824] = {cooldown = 0,	class = "PALADIN"}, --Shield of Virtue
	[105421] = {cooldown = 0,	class = "PALADIN"}, --Blinding Light
	[10326] = {cooldown = 15,	class = "PALADIN"}, --Turn Evil
	[853] = {cooldown = 60,		class = "PALADIN"}, --Hammer of Justice
	[96231] = {cooldown = 15,	class = "PALADIN"}, --Rebuke
	[205364] = {cooldown = 30,	class = "PRIEST"}, --Dominate Mind
	[64044] = {cooldown = 45,	class = "PRIEST"}, --Psychic Horror
	[226943] = {cooldown = 0,	class = "PRIEST"}, --Mind Bomb
	[15487] = {cooldown = 45,	class = "PRIEST"}, --Silence
	[605] = {cooldown = 0,		class = "PRIEST"}, --Mind Control
	[8122] = {cooldown = 45,	class = "PRIEST"}, --Psychic Scream
	[200200] = {cooldown = 60,	class = "PRIEST"}, --Holy Word: Chastise
	[9484] = {cooldown = 0,		class = "PRIEST"}, --Shackle Undead
	[200196] = {cooldown = 60,	class = "PRIEST"}, --Holy Word: Chastise
	[6770] = {cooldown = 0,		class = "ROGUE"}, --Sap
	[2094] = {cooldown = 120,	class = "ROGUE"}, --Blind
	[1766] = {cooldown = 15,	class = "ROGUE"}, --Kick
	[427773] = {cooldown = 0,	class = "ROGUE"}, --Blind
	[408] = {cooldown = 20,		class = "ROGUE"}, --Kidney Shot
	[1776] = {cooldown = 20,	class = "ROGUE"}, --Gouge
	[1833] = {cooldown = 0,		class = "ROGUE"}, --Cheap Shot
	[211015] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[269352] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[277778] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[64695] = {cooldown = 0,	class = "SHAMAN"}, --Earthgrab
	[57994] = {cooldown = 12,	class = "SHAMAN"}, --Wind Shear
	[197214] = {cooldown = 40,	class = "SHAMAN"}, --Sundering
	[118905] = {cooldown = 0,	class = "SHAMAN"}, --Static Charge
	[277784] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[309328] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[211010] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[210873] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[211004] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[51514] = {cooldown = 30,	class = "SHAMAN"}, --Hex
	[305485] = {cooldown = 30,	class = "SHAMAN"}, --Lightning Lasso
	[89766] = {cooldown = 30,	class = "WARLOCK"}, --Axe Toss (pet felguard ability)
	[6789] = {cooldown = 45,	class = "WARLOCK"}, --Mortal Coil
	[118699] = {cooldown = 0,	class = "WARLOCK"}, --Fear
	[710] = {cooldown = 0,		class = "WARLOCK"}, --Banish
	[212619] = {cooldown = 60,	class = "WARLOCK"}, --Call Felhunter
	[19647] = {cooldown = 24,	class = "WARLOCK"}, --Spell Lock
	[30283] = {cooldown = 60,	class = "WARLOCK"}, --Shadowfury
	[5484] = {cooldown = 40,	class = "WARLOCK"}, --Howl of Terror
	[6552] = {cooldown = 15,	class = "WARRIOR"}, --Pummel
	[132168] = {cooldown = 0,	class = "WARRIOR"}, --Shockwave
	[132169] = {cooldown = 0,	class = "WARRIOR"}, --Storm Bolt
	[5246] = {cooldown = 90,	class = "WARRIOR"}, --Intimidating Shout
}

--[=[
Spell customizations:
	Many times there's spells with the same name which does different effects
	In here you find a list of spells which has its name changed to give more information to the player
	you may add into the list any other parameter your addon uses declaring for example 'icon = ' or 'texcoord = ' etc.

Implamentation Example:
	if (LIB_OPEN_RAID_SPELL_CUSTOM_NAMES) then
		for spellId, customTable in pairs(LIB_OPEN_RAID_SPELL_CUSTOM_NAMES) do
			local name = customTable.name
			if (name) then
				MyCustomSpellTable[spellId] = name
			end
		end
	end
--]=]

LIB_OPEN_RAID_SPELL_CUSTOM_NAMES = {
	-- [44461] = {name = GetSpellInfo(44461) .. " (" .. L["STRING_EXPLOSION"] .. ")"}, --Living Bomb (explosion)
	-- [59638] = {name = GetSpellInfo(59638) .. " (" .. L["STRING_MIRROR_IMAGE"] .. ")"}, --Mirror Image's Frost Bolt (mage)
	-- [88082] = {name = GetSpellInfo(88082) .. " (" .. L["STRING_MIRROR_IMAGE"] .. ")"}, --Mirror Image's Fireball (mage)
	-- [94472] = {name = GetSpellInfo(94472) .. " (" .. L["STRING_CRITICAL_ONLY"] .. ")"}, --Atonement critical hit (priest)
	-- [33778] = {name = GetSpellInfo(33778) .. " (" .. L["STRING_BLOOM"] .. ")"}, --lifebloom (bloom)
	-- [121414] = {name = GetSpellInfo(121414) .. " (" .. L["STRING_GLAIVE"] .. " #1)"}, --glaive toss (hunter)
	-- [120761] = {name = GetSpellInfo(120761) .. " (" .. L["STRING_GLAIVE"] .. " #2)"}, --glaive toss (hunter)
	-- [212739] = {name = GetSpellInfo(212739) .. " (" .. L["STRING_MAINTARGET"] .. ")"}, --DK Epidemic
	-- [215969] = {name = GetSpellInfo(215969) .. " (" .. L["STRING_AOE"] .. ")"}, --DK Epidemic
	-- [70890] = {name = GetSpellInfo(70890) .. " (" .. L["STRING_SHADOW"] .. ")"}, --DK Scourge Strike
	-- [55090] = {name = GetSpellInfo(55090) .. " (" .. L["STRING_PHYSICAL"] .. ")"}, --DK Scourge Strike
	-- [49184] = {name = GetSpellInfo(49184) .. " (" .. L["STRING_MAINTARGET"] .. ")"}, --DK Howling Blast
	-- [237680] = {name = GetSpellInfo(237680) .. " (" .. L["STRING_AOE"] .. ")"}, --DK Howling Blast
	-- [228649] = {name = GetSpellInfo(228649) .. " (" .. L["STRING_PASSIVE"] .. ")"}, --Monk Mistweaver Blackout kick - Passive Teachings of the Monastery
	-- [339538] = {name = GetSpellInfo(224266) .. " (" .. L["STRING_TEMPLAR_VINDCATION"] .. ")"}, --
	-- [343355] = {name = GetSpellInfo(343355)  .. " (" .. L["STRING_PROC"] .. ")"}, --shadow priest's void bold proc

	-- --shadowlands trinkets
	-- [345020] = {name = GetSpellInfo(345020) .. " ("  .. L["STRING_TRINKET"] .. ")"},
}

--interrupt list using proxy from cooldown list
--this list should be expansion and combatlog safe
LIB_OPEN_RAID_SPELL_INTERRUPT = {
	[6552] = LIB_OPEN_RAID_COOLDOWNS_INFO[6552], --Pummel

	[2139] = LIB_OPEN_RAID_COOLDOWNS_INFO[2139], --Counterspell

	[15487] = LIB_OPEN_RAID_COOLDOWNS_INFO[15487], --Silence (shadow) Last Word Talent to reduce cooldown in 15 seconds

	[1766] = LIB_OPEN_RAID_COOLDOWNS_INFO[1766], --Kick

	[96231] = LIB_OPEN_RAID_COOLDOWNS_INFO[96231], --Rebuke (protection and retribution)

	[116705] = LIB_OPEN_RAID_COOLDOWNS_INFO[116705], --Spear Hand Strike (brewmaster and windwalker)

	[57994] = LIB_OPEN_RAID_COOLDOWNS_INFO[57994], --Wind Shear

	[47528] = LIB_OPEN_RAID_COOLDOWNS_INFO[47528], --Mind Freeze

	[106839] = LIB_OPEN_RAID_COOLDOWNS_INFO[106839], --Skull Bash (feral, guardian)
	[78675] = LIB_OPEN_RAID_COOLDOWNS_INFO[78675], --Solar Beam (balance)

	[147362] = LIB_OPEN_RAID_COOLDOWNS_INFO[147362], --Counter Shot (beast mastery, marksmanship)
	[187707] = LIB_OPEN_RAID_COOLDOWNS_INFO[187707], --Muzzle (survival)

	[183752] = LIB_OPEN_RAID_COOLDOWNS_INFO[183752], --Disrupt

	[19647] = LIB_OPEN_RAID_COOLDOWNS_INFO[19647], --Spell Lock (pet felhunter ability)
	[89766] = LIB_OPEN_RAID_COOLDOWNS_INFO[89766], --Axe Toss (pet felguard ability)
}

--override list of spells with more than one effect, example: multiple types of polymorph
LIB_OPEN_RAID_SPELL_DEFAULT_IDS = {
	--[id_to_override] = original_id
}

LIB_OPEN_RAID_DATABASE_LOADED = true
