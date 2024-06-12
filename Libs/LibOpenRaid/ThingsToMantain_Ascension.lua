
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

-- list of spells that map to a specific spec ID, this is used for spec guessing
LIB_OPEN_RAID_SPEC_SPELL_LIST = {
	-- [spellID] = specID
	-- Arms Warrior [64]
	[947486] = 	64,	-- Demolishing Strike, Rank 1 (Demolisher)
	[947487] = 	64,	-- Demolishing Strike, Rank 2 (Demolisher)
	[947488] = 	64,	-- Demolishing Strike, Rank 3 (Demolisher)
	[947489] = 	64,	-- Demolishing Strike, Rank 4 (Demolisher)
	[947490] = 	64,	-- Demolishing Strike, Rank 5 (Demolisher)
	[947491] = 	64,	-- Demolishing Strike, Rank 6 (Demolisher)
	[947492] = 	64,	-- Demolishing Strike, Rank 7 (Demolisher)
	[947493] = 	64,	-- Demolishing Strike, Rank 8 (Demolisher)
	[7384] = 	64, -- Overpower Rank 0
	[56636] = 	64, -- Taste for Blood, Rank 1
	[56637] = 	64, -- Taste for Blood, Rank 2
	[56638] = 	64, -- Taste for Blood, Rank 3
	[12294] = 	64, -- Mortal Strike
	
	-- Fury Warrior [65]
	[977813] = 	65,	-- Titanic Strike, Rank RE (Titanic Strike)
	[977812] = 	65,	-- Titanic Strike (Off Hand), Rank RE (Titanic Strike)
	[954066] = 	65,	-- Titanic Mutilate, Rank RE (Titanic Mutilate)
	[954065] = 	65,	-- Titanic Mutilate (Off Hand), Rank RE (Titanic Mutilate)
	[977774] = 	65,	-- Dominant Strike, Rank RE (Ambidextrous)
	[977775] = 	65,	-- Southpaw Strike, Rank RE (Ambidextrous)
	[1003052] = 65,	-- Slam (Off-hand), Rank 0
	[1464] = 	65, -- Slam (Rank 1) 
	[8820] = 	65, -- Slam (Rank 2) 
	[11604] = 	65, -- Slam (Rank 3) 
	[11605] = 	65, -- Slam (Rank 4) 
	[25241] = 	65, -- Slam (Rank 5) 
	[25242] = 	65, -- Slam (Rank 6) 
	[47474] = 	65, -- Slam (Rank 7) 
	[47475] = 	65, -- Slam (Rank 8) 
	[23881] = 	65, -- Bloodthirst
	[46917] = 	65, -- Titan's Grip
	[49152] = 	65, -- Titan's Grip Effect

	-- Protection Warrior [66]
	[871] = 	66, -- Shield Wall
	[12975] = 	66, -- Last Stand
	[6572] = 	66, -- Revenge (Rank 1) 
	[6574] = 	66, -- Revenge (Rank 2) 
	[7379] = 	66, -- Revenge (Rank 3) 
	[11600] = 	66, -- Revenge (Rank 4) 
	[11601] = 	66, -- Revenge (Rank 5) 
	[25288] = 	66, -- Revenge (Rank 6) 
	[25269] = 	66, -- Revenge (Rank 7) 
	[30357] = 	66, -- Revenge (Rank 8) 
	[57823] = 	66, -- Revenge (Rank 9) 
	[20243] = 	66, -- Devastate (Rank 1) 
	[30016] = 	66, -- Devastate (Rank 2) 
	[30022] = 	66, -- Devastate (Rank 3) 
	[47497] = 	66, -- Devastate (Rank 4) 
	[47498] = 	66, -- Devastate (Rank 5) 
	[23922] = 	66, -- Shield Slam (Rank 1) 
	[23923] = 	66, -- Shield Slam (Rank 2) 
	[23924] = 	66, -- Shield Slam (Rank 3) 
	[23925] = 	66, -- Shield Slam (Rank 4) 
	[25258] = 	66, -- Shield Slam (Rank 5) 
	[30356] = 	66, -- Shield Slam (Rank 6) 
	[47487] = 	66, -- Shield Slam (Rank 7) 
	[47488] = 	66, -- Shield Slam (Rank 8) 
	[46953] = 	66, -- Sword and Board
	[50227] = 	66, -- Sword and Board Trigger

	-- Holy Paladin [67]
	[25914] =	67, -- Holy Shock (Rank 1) 
	[25913] =	67, -- Holy Shock (Rank 2) 
	[25903] =	67, -- Holy Shock (Rank 3) 
	[27175] =	67, -- Holy Shock (Rank 4) 
	[33074] =	67, -- Holy Shock (Rank 5) 
	[48820] =	67, -- Holy Shock (Rank 6) 
	[48821] =	67, -- Holy Shock (Rank 7) 
	[635] =		67, -- Holy Light (Rank 1) 
	[639] =		67, -- Holy Light (Rank 2) 
	[647] =		67, -- Holy Light (Rank 3) 
	[1026] =	67, -- Holy Light (Rank 4) 
	[1042] =	67, -- Holy Light (Rank 5) 
	[3472] =	67, -- Holy Light (Rank 6) 
	[10328] =	67, -- Holy Light (Rank 7) 
	[10329] =	67, -- Holy Light (Rank 8) 
	[25292] =	67, -- Holy Light (Rank 9) 
	[27135] =	67, -- Holy Light (Rank 10) 
	[27136] =	67, -- Holy Light (Rank 11) 
	[48781] =	67, -- Holy Light (Rank 12) 
	[48782] =	67, -- Holy Light (Rank 13) 

	-- Protection Paladin [68]
	[53595] = 68, -- Hammer of the Righteous
	[31935] = 68, -- Avenger's Shield (Rank 1) 
	[32699] = 68, -- Avenger's Shield (Rank 2) 
	[32700] = 68, -- Avenger's Shield (Rank 3) 
	[48826] = 68, -- Avenger's Shield (Rank 4) 
	[48827] = 68, -- Avenger's Shield (Rank 5) 
	[20925] = 68, -- Holy Shield (Rank 1) 
	[20927] = 68, -- Holy Shield (Rank 2) 
	[20928] = 68, -- Holy Shield (Rank 3) 
	[27179] = 68, -- Holy Shield (Rank 4) 
	[48951] = 68, -- Holy Shield (Rank 5) 
	[48952] = 68, -- Holy Shield (Rank 6) 

	-- Retribution Paladin [69]
	[935395] = 	69,	-- Crusader Strike (One With The Light), Rank RE
	[953385] = 	69,	-- Divine Storm (One With The Light), Rank RE
	[53385] = 	69,	-- Divine Storm
	[35395] = 	69,	-- Crusader Strike
	[24275] = 	69,	-- Hammer of Wrath (Rank 1) 
	[24274] = 	69,	-- Hammer of Wrath (Rank 2) 
	[24239] = 	69,	-- Hammer of Wrath (Rank 3) 
	[27180] = 	69,	-- Hammer of Wrath (Rank 4) 
	[48805] = 	69,	-- Hammer of Wrath (Rank 5) 
	[48806] = 	69,	-- Hammer of Wrath (Rank 6) 

	-- Beast Mastery Hunter [70]
	[34026] = 70, 	-- Kill Command Rank 0
	[19574] = 70, 	-- Bestial Wrath

	-- Marksmanship Hunter [71]
	[965941] = 	71,	-- Expunge, Rank RE
	[978762] = 	71,	-- Multi-Shot (Focused Burst), Rank RE
	[978761] = 	71,	-- Focused Burst, Rank RE
	[954052] = 	71,	-- Locust Shot, Rank RE
	[53209] =	71, -- Chimera Shot
	[19434] =	71, -- Aimed Shot (Rank 1) 
	[20900] =	71, -- Aimed Shot (Rank 2) 
	[20901] =	71, -- Aimed Shot (Rank 3) 
	[20902] =	71, -- Aimed Shot (Rank 4) 
	[20903] =	71, -- Aimed Shot (Rank 5) 
	[20904] =	71, -- Aimed Shot (Rank 6) 
	[27065] =	71, -- Aimed Shot (Rank 7) 
	[49049] =	71, -- Aimed Shot (Rank 8) 
	[49050] =	71, -- Aimed Shot (Rank 9) 
	[53254] =	71, -- Wild Quiver Rank 0

	-- Survival Hunter [72]
	[81449] = 	72, -- Explosive Shot (Aimed) (Rank 1) 
	[81450] = 	72, -- Explosive Shot (Aimed) (Rank 2) 
	[81451] = 	72, -- Explosive Shot (Aimed) (Rank 3) 
	[81452] = 	72, -- Explosive Shot (Aimed) (Rank 4) 
	[81278] = 	72,	-- Arrows of Fire, Rank RE
	[965408] = 	72,	-- Deadly Bite, Rank RE
	[53301] =	72, -- Explosive Shot (Rank 1) 
	[60051] =	72, -- Explosive Shot (Rank 2) 
	[60052] =	72, -- Explosive Shot (Rank 3) 
	[60053] =	72, -- Explosive Shot (Rank 4) 

	-- Assassination Rogue [73]
	[977907] = 73,	-- Blood and Guts, Rank RE (Blood and Guts)
	[947470] = 73,	-- Eviscerate (Disembowel), Rank 1 (Blood and Guts)
	[947471] = 73,	-- Eviscerate (Disembowel), Rank 2 (Blood and Guts)
	[947472] = 73,	-- Eviscerate (Disembowel), Rank 3 (Blood and Guts)
	[947473] = 73,	-- Eviscerate (Disembowel), Rank 4 (Blood and Guts)
	[947474] = 73,	-- Eviscerate (Disembowel), Rank 5 (Blood and Guts)
	[947475] = 73,	-- Eviscerate (Disembowel), Rank 6 (Blood and Guts)
	[947476] = 73,	-- Eviscerate (Disembowel), Rank 7 (Blood and Guts)
	[947477] = 73,	-- Eviscerate (Disembowel), Rank 8 (Blood and Guts)
	[947478] = 73,	-- Eviscerate (Disembowel), Rank 9 (Blood and Guts)
	[947479] = 73,	-- Eviscerate (Disembowel), Rank 10 (Blood and Guts)
	[947480] = 73,	-- Eviscerate (Disembowel), Rank 11 (Blood and Guts)
	[947481] = 73,	-- Eviscerate (Disembowel), Rank 12 (Blood and Guts)
	[32645] = 	73, -- Envenom (Rank 1) 
	[32684] = 	73, -- Envenom (Rank 2) 
	[57992] = 	73, -- Envenom (Rank 3) 
	[57993] = 	73, -- Envenom (Rank 4) 
	[1329] = 	73, -- Mutilate
	[5374] = 	73, -- Mutilate
	[27576] = 	73, -- Mutilate Off-Hand

	-- Combat Rogue [74]
	[980050] = 74,	-- Master of Shadow, Rank RE
	[978743] = 74,	-- Double Down, Rank RE

	-- Subtlety Rogue [75]
	[53] = 		75, -- Backstab (Rank 1) 
	[2589] = 	75, -- Backstab (Rank 2) 
	[2590] = 	75, -- Backstab (Rank 3) 
	[2591] = 	75, -- Backstab (Rank 4) 
	[8721] = 	75, -- Backstab (Rank 5) 
	[11279] = 	75, -- Backstab (Rank 6) 
	[11280] = 	75, -- Backstab (Rank 7) 
	[11281] = 	75, -- Backstab (Rank 8) 
	[25300] = 	75, -- Backstab (Rank 9) 
	[26863] = 	75, -- Backstab (Rank 10) 
	[48656] = 	75, -- Backstab (Rank 11) 
	[48657] = 	75, -- Backstab (Rank 12) 
	[8676] = 	75, -- Ambush (Rank 1) 
	[8724] = 	75, -- Ambush (Rank 2) 
	[8725] = 	75, -- Ambush (Rank 3) 
	[11267] = 	75, -- Ambush (Rank 4) 
	[11268] = 	75, -- Ambush (Rank 5) 
	[11269] = 	75, -- Ambush (Rank 6) 
	[27441] = 	75, -- Ambush (Rank 7) 
	[48689] = 	75, -- Ambush (Rank 8) 
	[48690] = 	75, -- Ambush (Rank 9) 
	[48691] = 	75, -- Ambush (Rank 10) 
	[51713] = 	75, -- Shadow Dance

	-- Discipline Priest [76]
	[17] = 		76, -- Power Word: Shield (Rank 1) 
	[592] = 	76, -- Power Word: Shield (Rank 2) 
	[600] = 	76, -- Power Word: Shield (Rank 3) 
	[3747] = 	76, -- Power Word: Shield (Rank 4) 
	[6065] = 	76, -- Power Word: Shield (Rank 5) 
	[6066] = 	76, -- Power Word: Shield (Rank 6) 
	[10898] = 	76, -- Power Word: Shield (Rank 7) 
	[10899] = 	76, -- Power Word: Shield (Rank 8) 
	[10900] = 	76, -- Power Word: Shield (Rank 9) 
	[10901] = 	76, -- Power Word: Shield (Rank 10) 
	[25217] = 	76, -- Power Word: Shield (Rank 11) 
	[25218] = 	76, -- Power Word: Shield (Rank 12) 
	[48065] = 	76, -- Power Word: Shield (Rank 13) 
	[48066] = 	76, -- Power Word: Shield (Rank 14) 
	[47750] = 	76, -- Penance (Rank 1) 
	[52983] = 	76, -- Penance (Rank 2) 
	[52984] = 	76, -- Penance (Rank 3) 
	[52985] = 	76, -- Penance (Rank 4) 

	-- Holy Priest [77]
	[2050] = 	77, -- Greater Heal (Rank 1) 
	[2052] = 	77, -- Greater Heal (Rank 2) 
	[2053] = 	77, -- Greater Heal (Rank 3) 
	[2054] = 	77, -- Greater Heal (Rank 4) 
	[2055] = 	77, -- Greater Heal (Rank 5) 
	[6063] = 	77, -- Greater Heal (Rank 6) 
	[6064] = 	77, -- Greater Heal (Rank 7) 
	[2060] = 	77, -- Greater Heal (Rank 8) 
	[10963] = 	77, -- Greater Heal (Rank 9) 
	[10964] = 	77, -- Greater Heal (Rank 10) 
	[10965] = 	77, -- Greater Heal (Rank 11) 
	[25314] = 	77, -- Greater Heal (Rank 12) 
	[25210] = 	77, -- Greater Heal (Rank 13) 
	[25213] = 	77, -- Greater Heal (Rank 14) 
	[48062] = 	77, -- Greater Heal (Rank 15) 
	[48063] = 	77, -- Greater Heal (Rank 16) 
	[34861] = 	77, -- Circle of Healing (Rank 1) 
	[34863] = 	77, -- Circle of Healing (Rank 2) 
	[34864] = 	77, -- Circle of Healing (Rank 3) 
	[34865] = 	77, -- Circle of Healing (Rank 4) 
	[34866] = 	77, -- Circle of Healing (Rank 5) 
	[48088] = 	77, -- Circle of Healing (Rank 6) 
	[48089] = 	77, -- Circle of Healing (Rank 7) 
	[596] = 	77, -- Prayer of Healing (Rank 1) 
	[996] = 	77, -- Prayer of Healing (Rank 2) 
	[10960] = 	77, -- Prayer of Healing (Rank 3) 
	[10961] = 	77, -- Prayer of Healing (Rank 4) 
	[25316] = 	77, -- Prayer of Healing (Rank 5) 
	[25308] = 	77, -- Prayer of Healing (Rank 6) 
	[48072] = 	77, -- Prayer of Healing (Rank 7) 
	[585] = 	77, -- Smite (Rank 1) 
	[591] = 	77, -- Smite (Rank 2) 
	[598] = 	77, -- Smite (Rank 3) 
	[984] = 	77, -- Smite (Rank 4) 
	[1004] = 	77, -- Smite (Rank 5) 
	[6060] = 	77, -- Smite (Rank 6) 
	[10933] = 	77, -- Smite (Rank 7) 
	[10934] = 	77, -- Smite (Rank 8) 
	[25363] = 	77, -- Smite (Rank 9) 
	[25364] = 	77, -- Smite (Rank 10) 
	[48122] = 	77, -- Smite (Rank 11) 
	[48123] = 	77, -- Smite (Rank 12) 
	[14914] = 	77, -- Holy Fire (Rank 1) 
	[15262] = 	77, -- Holy Fire (Rank 2) 
	[15263] = 	77, -- Holy Fire (Rank 3) 
	[15264] = 	77, -- Holy Fire (Rank 4) 
	[15265] = 	77, -- Holy Fire (Rank 5) 
	[15266] = 	77, -- Holy Fire (Rank 6) 
	[15267] = 	77, -- Holy Fire (Rank 7) 
	[15261] = 	77, -- Holy Fire (Rank 8) 
	[25384] = 	77, -- Holy Fire (Rank 9) 
	[48134] = 	77, -- Holy Fire (Rank 10) 
	[48135] = 	77, -- Holy Fire (Rank 11) 


	-- Shadow Priest [78]
	[81371] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 1) 
	[81372] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 2) 
	[81373] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 3) 
	[81374] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 4) 
	[81375] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 5) 
	[81376] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 6) 
	[81377] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 7) 
	[81378] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 8) 
	[81379] = 	78, 	-- Mind Flay (Unbounded Mind Flay) (Rank 9) 
	[977850] = 	78, 	-- Twilight Treason (Unbounded Mind Flay) (Rank RE) 
	[977851] = 	78, 	-- Twilight Treason (Unbounded Mind Flay) (Rank RE) 

	-- Blood Death Knight [79]

	-- Frost Death Knight [80]

	-- Unholy Death Knight [81]

	-- Elemental Shaman [82]
	[29000] = 	82, -- Elemental Reach, Rank 2
	[16164] = 	82, -- Elemental Focus
	[16246] = 	82, -- Elemental Focus Effect
	[16166] = 	82, -- Elemental Mastery
	[64701] = 	82, -- Elemental Mastery Effect
	[403] = 	82, -- Lightning Bolt (Rank 1) 
	[529] = 	82, -- Lightning Bolt (Rank 2) 
	[548] = 	82, -- Lightning Bolt (Rank 3) 
	[915] = 	82, -- Lightning Bolt (Rank 4) 
	[943] = 	82, -- Lightning Bolt (Rank 5) 
	[6041] = 	82, -- Lightning Bolt (Rank 6) 
	[10391] = 	82, -- Lightning Bolt (Rank 7) 
	[10392] = 	82, -- Lightning Bolt (Rank 8) 
	[15207] = 	82, -- Lightning Bolt (Rank 9) 
	[15208] = 	82, -- Lightning Bolt (Rank 10) 
	[25448] = 	82, -- Lightning Bolt (Rank 11) 
	[25449] = 	82, -- Lightning Bolt (Rank 12) 
	[49237] = 	82, -- Lightning Bolt (Rank 13) 
	[49238] = 	82, -- Lightning Bolt (Rank 14) 
	[421] = 	82, -- Chain Lightning (Rank 1) 
	[930] = 	82, -- Chain Lightning (Rank 2) 
	[2860] = 	82, -- Chain Lightning (Rank 3) 
	[10605] = 	82, -- Chain Lightning (Rank 4) 
	[25439] = 	82, -- Chain Lightning (Rank 5) 
	[25442] = 	82, -- Chain Lightning (Rank 6) 
	[49270] = 	82, -- Chain Lightning (Rank 7) 
	[49271] = 	82, -- Chain Lightning (Rank 8) 

	-- Enhancement Shaman [83]
	[860103] = 	83,	-- Ice Lash, Rank RE
	[51530] = 	83, -- Maelstrom Weapon
	[51521] = 	83, -- Improved Stormstrike, Rank 1
	[51522] = 	83, -- Improved Stormstrike, Rank 2
	[60103] = 	83,	-- Lava Lash, Rank 0

	-- Restoration Shaman [84]
	[51566] = 	84, -- Tidal Waves, Rank 5
	[331] = 	84, -- Healing Wave (Rank 1) 
	[332] = 	84, -- Healing Wave (Rank 2) 
	[547] = 	84, -- Healing Wave (Rank 3) 
	[913] = 	84, -- Healing Wave (Rank 4) 
	[939] = 	84, -- Healing Wave (Rank 5) 
	[959] = 	84, -- Healing Wave (Rank 6) 
	[8005] = 	84, -- Healing Wave (Rank 7) 
	[10395] = 	84, -- Healing Wave (Rank 8) 
	[10396] = 	84, -- Healing Wave (Rank 9) 
	[25357] = 	84, -- Healing Wave (Rank 10) 
	[25391] = 	84, -- Healing Wave (Rank 11) 
	[25396] = 	84, -- Healing Wave (Rank 12) 
	[49272] = 	84, -- Healing Wave (Rank 13) 
	[49273] = 	84, -- Healing Wave (Rank 14) 
	[8004] = 	84, -- Lesser Healing Wave (Rank 1) 
	[8008] = 	84, -- Lesser Healing Wave (Rank 2) 
	[8010] = 	84, -- Lesser Healing Wave (Rank 3) 
	[10466] = 	84, -- Lesser Healing Wave (Rank 4) 
	[10467] = 	84, -- Lesser Healing Wave (Rank 5) 
	[10468] = 	84, -- Lesser Healing Wave (Rank 6) 
	[25420] = 	84, -- Lesser Healing Wave (Rank 7) 
	[49275] = 	84, -- Lesser Healing Wave (Rank 8) 
	[49276] = 	84, -- Lesser Healing Wave (Rank 9) 
	[1064] = 	84, -- Chain Heal (Rank 1) 
	[10622] = 	84, -- Chain Heal (Rank 2) 
	[10623] = 	84, -- Chain Heal (Rank 3) 
	[25422] = 	84, -- Chain Heal (Rank 4) 
	[25423] = 	84, -- Chain Heal (Rank 5) 
	[55458] = 	84, -- Chain Heal (Rank 6) 
	[55459] = 	84, -- Chain Heal (Rank 7) 
	[974] = 	84, -- Earth Shield (Rank 1) 
	[32593] = 	84, -- Earth Shield (Rank 2) 
	[32594] = 	84, -- Earth Shield (Rank 3) 
	[49283] = 	84, -- Earth Shield (Rank 4) 
	[49284] = 	84, -- Earth Shield (Rank 5) 
	[16188] = 	84, -- Nature's Swiftness (Rank 0) 
	[61295] = 	84, -- Riptide (Rank 1) 
	[61299] = 	84, -- Riptide (Rank 2) 
	[61300] = 	84, -- Riptide (Rank 3) 
	[61301] = 	84, -- Riptide (Rank 4) 

	-- Arcane Mage [85]
	[977871] = 	85,	-- Manacharged Strike, Rank RE (Mana Fiend)
	[830560] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830561] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830562] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830563] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830564] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830565] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830566] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830567] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830568] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830569] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830570] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830571] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830572] = 	85,	-- Arcane Missile (Divine), Rank RE 
	[830451] = 	85,	-- Arcane Blast (Divine), Rank RE 
	[44425] =	85, -- Arcane Barrage (Rank 1) 
	[44780] =	85, -- Arcane Barrage (Rank 2) 
	[44781] =	85, -- Arcane Barrage (Rank 3) 
	[30451] =	85, -- Arcane Blast (Rank 1) 
	[42894] =	85, -- Arcane Blast (Rank 2) 
	[42896] =	85, -- Arcane Blast (Rank 3) 
	[42897] =	85, -- Arcane Blast (Rank 4) 

	-- Fire Mage [86]
	[81226] = 	86, -- Scorch (Scorched Earth) (Rank 1) 
	[81227] = 	86, -- Scorch (Scorched Earth) (Rank 2) 
	[81228] = 	86, -- Scorch (Scorched Earth) (Rank 3) 
	[81229] = 	86, -- Scorch (Scorched Earth) (Rank 4) 
	[81230] = 	86, -- Scorch (Scorched Earth) (Rank 5) 
	[81231] = 	86, -- Scorch (Scorched Earth) (Rank 6) 
	[81232] = 	86, -- Scorch (Scorched Earth) (Rank 7) 
	[81233] = 	86, -- Scorch (Scorched Earth) (Rank 8) 
	[81234] = 	86, -- Scorch (Scorched Earth) (Rank 9) 
	[81246] = 	86, -- Scorch (Scorched Earth) (Rank 10) 
	[81247] = 	86, -- Scorch (Scorched Earth) (Rank 11) 
	[133] = 	86, -- Fireball (Rank 1) 
	[143] = 	86, -- Fireball (Rank 2) 
	[145] = 	86, -- Fireball (Rank 3) 
	[3140] = 	86, -- Fireball (Rank 4) 
	[8400] = 	86, -- Fireball (Rank 5) 
	[8401] = 	86, -- Fireball (Rank 6) 
	[8402] = 	86, -- Fireball (Rank 7) 
	[10148] = 	86, -- Fireball (Rank 8) 
	[10149] = 	86, -- Fireball (Rank 9) 
	[10150] = 	86, -- Fireball (Rank 10) 
	[10151] = 	86, -- Fireball (Rank 11) 
	[25306] = 	86, -- Fireball (Rank 12) 
	[27070] = 	86, -- Fireball (Rank 13) 
	[38692] = 	86, -- Fireball (Rank 14) 
	[42832] = 	86, -- Fireball (Rank 15) 
	[42833] = 	86, -- Fireball (Rank 16) 
	[1811] = 	86, -- Scorch (Rank 1) 
	[8447] = 	86, -- Scorch (Rank 2) 
	[8448] = 	86, -- Scorch (Rank 3) 
	[8449] = 	86, -- Scorch (Rank 4) 
	[10208] = 	86, -- Scorch (Rank 5) 
	[10209] = 	86, -- Scorch (Rank 6) 
	[10210] = 	86, -- Scorch (Rank 7) 
	[27375] = 	86, -- Scorch (Rank 8) 
	[27376] = 	86, -- Scorch (Rank 9) 
	[42858] = 	86, -- Scorch (Rank 10) 
	[42859] = 	86, -- Scorch (Rank 11) 

	-- Frost Mage [87]
	[953313] = 	87,	-- Evoker, Rank RE
	[30455] = 	87,	-- Ice Lance (Rank 1) 
	[42913] = 	87,	-- Ice Lance (Rank 2) 
	[42914] = 	87,	-- Ice Lance (Rank 3) 

	-- Affliction Warlock [88]
	[978426] = 	88,	-- Shadow Lance, Rank RE (Fingers of Death)
	[48181] = 	88, -- Haunt (Rank 1) 
	[59161] = 	88, -- Haunt (Rank 2) 
	[59163] = 	88, -- Haunt (Rank 3) 
	[59164] = 	88, -- Haunt (Rank 4) 
	[30108] = 	88, -- Unstable Affliction (Rank 1) 
	[30404] = 	88, -- Unstable Affliction (Rank 2) 
	[30405] = 	88, -- Unstable Affliction (Rank 3) 
	[47841] = 	88, -- Unstable Affliction (Rank 4) 
	[47843] = 	88, -- Unstable Affliction (Rank 5) 

	-- Demonology Warlock [89]
	[47193] = 	89,	-- Demonic Empowerment, Rank 0
	[47241] = 	89,	-- Metamorphosis, Rank 0
	[47240] = 	89,	-- Demonic Pact, Rank 5

	-- Destruction Warlock [90]
	[977714] = 	90,	-- Shadow Crash, Rank RE (Pure Shadow)
	[81236] = 	90,	-- Searing Pain (Perilous Pain), Rank 1 (Perilous Pain)
	[81237] = 	90,	-- Searing Pain (Perilous Pain), Rank 2 (Perilous Pain)
	[81238] = 	90,	-- Searing Pain (Perilous Pain), Rank 3 (Perilous Pain)
	[81239] = 	90,	-- Searing Pain (Perilous Pain), Rank 4 (Perilous Pain)
	[81240] = 	90,	-- Searing Pain (Perilous Pain), Rank 5 (Perilous Pain)
	[81241] = 	90,	-- Searing Pain (Perilous Pain), Rank 6 (Perilous Pain)
	[81242] = 	90,	-- Searing Pain (Perilous Pain), Rank 7 (Perilous Pain)
	[81243] = 	90,	-- Searing Pain (Perilous Pain), Rank 8 (Perilous Pain)
	[81244] = 	90,	-- Searing Pain (Perilous Pain), Rank 9 (Perilous Pain)
	[81245] = 	90,	-- Searing Pain (Perilous Pain), Rank 10 (Perilous Pain)
	[6353] = 	90, -- Soul Fire (Rank 1) 
	[17924] = 	90, -- Soul Fire (Rank 2) 
	[27211] = 	90, -- Soul Fire (Rank 3) 
	[30545] = 	90, -- Soul Fire (Rank 4) 
	[47824] = 	90, -- Soul Fire (Rank 5) 
	[47825] = 	90, -- Soul Fire (Rank 6) 
	[348] = 	90, -- Immolate (Rank 1) 
	[707] = 	90, -- Immolate (Rank 2) 
	[1094] = 	90, -- Immolate (Rank 3) 
	[2941] = 	90, -- Immolate (Rank 4) 
	[11665] = 	90, -- Immolate (Rank 5) 
	[11667] = 	90, -- Immolate (Rank 6) 
	[11668] = 	90, -- Immolate (Rank 7) 
	[25309] = 	90, -- Immolate (Rank 8) 
	[27215] = 	90, -- Immolate (Rank 9) 
	[47810] = 	90, -- Immolate (Rank 10) 
	[47811] = 	90, -- Immolate (Rank 11) 
	[17962] = 	90,	-- Conflagrate, Rank 0
	[50796] = 	90, -- Chaos Bolt (Rank 1) 
	[59170] = 	90, -- Chaos Bolt (Rank 2) 
	[59171] = 	90, -- Chaos Bolt (Rank 3) 
	[59172] = 	90, -- Chaos Bolt (Rank 4) 
	[29722] = 	90, -- Incinerate (Rank 1) 
	[32231] = 	90, -- Incinerate (Rank 2) 
	[47837] = 	90, -- Incinerate (Rank 3) 
	[47838] = 	90, -- Incinerate (Rank 4) 
	[686] = 	90, -- Shadow Bolt (Rank 1) 
	[695] = 	90, -- Shadow Bolt (Rank 2) 
	[705] = 	90, -- Shadow Bolt (Rank 3) 
	[1088] = 	90, -- Shadow Bolt (Rank 4) 
	[1106] = 	90, -- Shadow Bolt (Rank 5) 
	[7641] = 	90, -- Shadow Bolt (Rank 6) 
	[11659] = 	90, -- Shadow Bolt (Rank 7) 
	[11660] = 	90, -- Shadow Bolt (Rank 8) 
	[11661] = 	90, -- Shadow Bolt (Rank 9) 
	[25307] = 	90, -- Shadow Bolt (Rank 10) 
	[27209] = 	90, -- Shadow Bolt (Rank 11) 
	[47808] = 	90, -- Shadow Bolt (Rank 12) 
	[47809] = 	90, -- Shadow Bolt (Rank 13) 	

	-- Balance Druid [91]
	[48505] = 	91,	-- Starfall (Rank 1) 
	[53199] = 	91,	-- Starfall (Rank 2) 
	[53200] = 	91,	-- Starfall (Rank 3) 
	[53201] = 	91,	-- Starfall (Rank 4)
	[2912] = 	91,	-- Starfire (Rank 1) 
	[8949] = 	91,	-- Starfire (Rank 2) 
	[8950] = 	91,	-- Starfire (Rank 3) 
	[8951] = 	91,	-- Starfire (Rank 4) 
	[9875] = 	91,	-- Starfire (Rank 5) 
	[9876] = 	91,	-- Starfire (Rank 6) 
	[25298] = 	91,	-- Starfire (Rank 7) 
	[26986] = 	91,	-- Starfire (Rank 8) 
	[48464] = 	91,	-- Starfire (Rank 9) 
	[48465] = 	91,	-- Starfire (Rank 10) 
	[5570] = 	91,	-- Insect Swarm (Rank 1) 
	[24974] = 	91,	-- Insect Swarm (Rank 2) 
	[24975] = 	91,	-- Insect Swarm (Rank 3) 
	[24976] = 	91,	-- Insect Swarm (Rank 4) 
	[24977] = 	91,	-- Insect Swarm (Rank 5) 
	[27013] = 	91,	-- Insect Swarm (Rank 6) 
	[48468] = 	91,	-- Insect Swarm (Rank 7) 

	-- Feral Druid [92]
	[977791] = 	92, -- Predator's Wrath (Rank RE)
	[5221] = 	92, -- Shred (Rank 1) 
	[6800] = 	92, -- Shred (Rank 2) 
	[8992] = 	92, -- Shred (Rank 3) 
	[9829] = 	92, -- Shred (Rank 4) 
	[9830] = 	92, -- Shred (Rank 5) 
	[27001] = 	92, -- Shred (Rank 6) 
	[27002] = 	92, -- Shred (Rank 7) 
	[48571] = 	92, -- Shred (Rank 8) 
	[48572] = 	92, -- Shred (Rank 9) 
	[33876] = 	92, -- Mangle (Cat) (Rank 1) 
	[33982] = 	92, -- Mangle (Cat) (Rank 2) 
	[33983] = 	92, -- Mangle (Cat) (Rank 3) 
	[48565] = 	92, -- Mangle (Cat) (Rank 4) 
	[48566] = 	92, -- Mangle (Cat) (Rank 5)
	[1822] = 	92, -- Rake (Rank 1) 
	[1823] = 	92, -- Rake (Rank 2) 
	[1824] = 	92, -- Rake (Rank 3) 
	[9904] = 	92, -- Rake (Rank 4) 
	[27003] = 	92, -- Rake (Rank 5) 
	[48573] = 	92, -- Rake (Rank 6) 
	[48574] = 	92, -- Rake (Rank 7) 
	[59881] = 	92, -- Rake (Rank 1) 
	[59882] = 	92, -- Rake (Rank 2) 
	[59883] = 	92, -- Rake (Rank 3) 
	[59884] = 	92, -- Rake (Rank 4) 
	[59885] = 	92, -- Rake (Rank 5) 
	[59886] = 	92, -- Rake (Rank 6) 
	[1079] = 	92, -- Rip (Rank 1) 
	[9492] = 	92, -- Rip (Rank 2) 
	[9493] = 	92, -- Rip (Rank 3) 
	[9752] = 	92, -- Rip (Rank 4) 
	[9894] = 	92, -- Rip (Rank 5) 
	[9896] = 	92, -- Rip (Rank 6) 
	[27008] = 	92, -- Rip (Rank 7) 
	[49799] = 	92, -- Rip (Rank 8) 
	[49800] = 	92, -- Rip (Rank 9) 
	[33878] = 	92, -- Mangle (Bear) (Rank 1) 
	[33986] = 	92, -- Mangle (Bear) (Rank 2) 
	[33987] = 	92, -- Mangle (Bear) (Rank 3) 
	[48563] = 	92, -- Mangle (Bear) (Rank 4) 
	[48564] = 	92, -- Mangle (Bear) (Rank 5) 
	[33745] = 	92, -- Lacerate (Rank 1) 
	[48567] = 	92, -- Lacerate (Rank 2) 
	[48568] = 	92, -- Lacerate (Rank 3) 
	[6807] = 	92, -- Maul (Rank 1) 
	[6808] = 	92, -- Maul (Rank 2) 
	[6809] = 	92, -- Maul (Rank 3) 
	[8972] = 	92, -- Maul (Rank 4) 
	[9745] = 	92, -- Maul (Rank 5) 
	[9880] = 	92, -- Maul (Rank 6) 
	[9881] = 	92, -- Maul (Rank 7) 
	[26996] = 	92, -- Maul (Rank 8) 
	[48479] = 	92, -- Maul (Rank 9) 
	[48480] = 	92, -- Maul (Rank 10) 

	-- Restoration Druid [93]
	[8936] = 	93, -- Regrowth (Rank 1) 
	[8938] = 	93, -- Regrowth (Rank 2) 
	[8939] = 	93, -- Regrowth (Rank 3) 
	[8940] = 	93, -- Regrowth (Rank 4) 
	[8941] = 	93, -- Regrowth (Rank 5) 
	[9750] = 	93, -- Regrowth (Rank 6) 
	[9856] = 	93, -- Regrowth (Rank 7) 
	[9857] = 	93, -- Regrowth (Rank 8) 
	[9858] = 	93, -- Regrowth (Rank 9) 
	[26980] = 	93, -- Regrowth (Rank 10) 
	[48442] = 	93, -- Regrowth (Rank 11) 
	[48443] = 	93, -- Regrowth (Rank 12) 
	[774] = 	93, -- Rejuvenation (Rank 1) 
	[1058] = 	93, -- Rejuvenation (Rank 2) 
	[1430] = 	93, -- Rejuvenation (Rank 3) 
	[2090] = 	93, -- Rejuvenation (Rank 4) 
	[2091] = 	93, -- Rejuvenation (Rank 5) 
	[3627] = 	93, -- Rejuvenation (Rank 6) 
	[8910] = 	93, -- Rejuvenation (Rank 7) 
	[9839] = 	93, -- Rejuvenation (Rank 8) 
	[9840] = 	93, -- Rejuvenation (Rank 9) 
	[9841] = 	93, -- Rejuvenation (Rank 10) 
	[25299] = 	93, -- Rejuvenation (Rank 11) 
	[26981] = 	93, -- Rejuvenation (Rank 12) 
	[26982] = 	93, -- Rejuvenation (Rank 13) 
	[48440] = 	93, -- Rejuvenation (Rank 14) 
	[48441] = 	93, -- Rejuvenation (Rank 15) 
	[5185] = 	93, -- Healing Touch (Rank 1) 
	[5186] = 	93, -- Healing Touch (Rank 2) 
	[5187] = 	93, -- Healing Touch (Rank 3) 
	[5188] = 	93, -- Healing Touch (Rank 4) 
	[5189] = 	93, -- Healing Touch (Rank 5) 
	[6778] = 	93, -- Healing Touch (Rank 6) 
	[8903] = 	93, -- Healing Touch (Rank 7) 
	[9758] = 	93, -- Healing Touch (Rank 8) 
	[9888] = 	93, -- Healing Touch (Rank 9) 
	[9889] = 	93, -- Healing Touch (Rank 10) 
	[25297] = 	93, -- Healing Touch (Rank 11) 
	[26978] = 	93, -- Healing Touch (Rank 12) 
	[26979] = 	93, -- Healing Touch (Rank 13) 
	[48377] = 	93, -- Healing Touch (Rank 14) 
	[48378] = 	93, -- Healing Touch (Rank 15) 
	[33763] = 	93, -- Lifebloom (Rank 1) 
	[48450] = 	93, -- Lifebloom (Rank 2) 
	[48451] = 	93, -- Lifebloom (Rank 3) 
	[18562] = 	93, -- Swiftmend

	-- Hero [94]

	-- Tactics Barbarian [1]

	-- Brutality Barbarian [2]

	-- Ancestry Barbarian [3]

	-- Shadowhunting Witch Doctor [4]

	-- Voodoo Witch Doctor [5]

	-- Brewing Witch Doctor [6]

	-- Felblood Felsworn (Demon Hunter) [7]

	-- Slaying Felsworn (Demon Hunter) [8]

	-- Demonology Felsworn (Demon Hunter) [9]

	-- Boltslinger Witch Hunter [10]

	-- Darkness Witch Hunter [11]

	-- Inquisition Witch Hunter [12]

	-- Witch Knight Witch Hunter [97]

	-- Wind Stormbringer [13]

	-- Gifts Stormbringer [14]

	-- Lightning Stormbringer [15]

	-- Hellfire Knight of Xoroth (Fleshwarden) [16]

	-- Defiance Knight of Xoroth (Fleshwarden) [17]

	-- War Knight of Xoroth (Fleshwarden) [18]

	-- Gladiator Guardian [19]
	
	-- Inspiration Guardian [20]

	-- Protection Guardian [21]

	-- Discipline Templar (Monk) [22]
	
	-- Fighting Templar (Monk) [23]

	-- Runes Templar (Monk) [24]

	-- Fleshweaver Son of Arugal [25]

	-- Blood Son of Arugal [26]

	-- Ferocity Son of Arugal [27]
	
	-- Packleader Son of Arugal [99]

	-- Archery Ranger [28]

	-- Survival Ranger [29]

	-- Dueling Ranger [30]

	-- Displacement Chronomancer [31]

	-- Duality Chronomancer [32]

	-- Time Chronomancer [33]

	-- Death Necromancer [34]

	-- Animation Necromancer [35]

	-- Rime Necromancer [36]

	-- Destruction Pyromancer [37]

	-- Incineration Pyromancer [38]

	-- Draconic Pyromancer [39]

	-- Influence Cultist [40]

	-- Corruption Cultist [41]

	-- Godblade Cultist [42]

	-- Bulwark Cultist [96]

	-- Tides Starcaller [43]

	-- Moonbow Starcaller [44]

	-- Hydromancy Starcaller [45]

	-- Astral Warfare Starcaller [100]

	-- Piety Sun Cleric [46]

	-- Valkyr Sun Cleric [47]

	-- Seraphim Sun Cleric [48]

	-- Blessings Sun Cleric [98]

	-- Mechanics Tinker [49]

	-- Invention Tinker [50]

	-- Firearms Tinker [51]

	-- Fortitude Venomancer (Prophet) [52]

	-- Stalking Venomancer (Prophet) [53]

	-- Venom Venomancer (Prophet) [54]

	-- Vizier Venomancer (Prophet) [101]

	-- Soul Reaper [55]

	-- Reaping Reaper [56]

	-- Domination Reaper [57]

	-- Life Primalist (Wildwalker) [58]

	-- Primal Primalist (Wildwalker) [59]

	-- Mountain King Primalist (Wildwalker) [60]

	-- Geomancy Primalist (Wildwalker) [95]

	-- Runic Runemaster (Spiritmage) [61]

	-- Arcane Runemaster (Spiritmage) [62]

	-- Riftblade Runemaster (Spiritmage) [63]
}

-- list of spells that map to a specific spec ID, this is used for class guessing
LIB_OPEN_RAID_CLASS_SPELL_LIST = {
	-- [spellID] = "CLASS"
	-- "HERO"

	-- "WARRIOR"

	-- "DEATHKNIGHT"

	-- "PALADIN"

	-- "PRIEST"

	-- "SHAMAN"

	-- "DRUID"

	-- "ROGUE"

	-- "MAGE"

	-- "WARLOCK"

	-- "HUNTER"

	-- "NECROMANCER"

	-- "PYROMANCER"

	-- "CULTIST"

	-- "STARCALLER"

	-- "SUNCLERIC"

	-- "TINKER"

	-- "SPIRITMAGE"

	-- "WILDWALKER"

	-- "REAPER"

	-- "PROPHET"

	-- "CHRONOMANCER"

	-- "SONOFARUGAL"

	-- "GUARDIAN"

	-- "STORMBRINGER"

	-- "DEMONHUNTER"

	-- "BARBARIAN"

	-- "WITCHDOCTOR"

	-- "WITCHHUNTER"

	-- "FLESHWARDEN"

	-- "MONK"

	-- "RANGER"

}

LIB_OPEN_RAID_DATABASE_LOADED = true
