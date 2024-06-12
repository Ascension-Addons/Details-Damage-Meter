
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
	-- [Classless]
	[6552] =	 {class = "WARRIOR",	specs = {64, 65, 66},	cooldown = 12, silence = 4, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Pummel
	[2139] =	 {class = "MAGE",		specs = {85, 86, 87},	cooldown = 40, silence = 5, talent = false, cooldownWithTalent = 30, 	cooldownTalentId = 435,   type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Counterspell
	[955071] =	 {class = "MAGE",		specs = {85, 86, 87},	cooldown = 35, silence = 2, talent = false, cooldownWithTalent = 25, 	cooldownTalentId = 435,   type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Fizzle
	[15487] =	 {class = "PRIEST",		specs = {78},			cooldown = 45, silence = 4, talent = 552, 	cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Silence (shadow)
	[1766] =	 {class = "ROGUE",		specs = {73, 74, 75},	cooldown = 12, silence = 4, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Kick
	[955070] =	 {class = "PALADIN",	specs = {67, 68, 69},	cooldown = 22, silence = 3, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Rebuke
	[57994] =	 {class = "SHAMAN",		specs = {82, 83, 84},	cooldown = 22, silence = 2, talent = false, cooldownWithTalent = 16, 	cooldownTalentId = 1143,  type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Wind Shear
	[47528] =	 {class = "DEATHKNIGHT",specs = {79, 80, 81},	cooldown = 15, silence = 3, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Mind Freeze
	[47476] =	 {class = "DEATHKNIGHT",specs = {79, 80, 81},	cooldown = 120,silence = 5, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Strangulate
	[954523] =	 {class = "DRUID",		specs = {91},			cooldown = 50, silence = 6, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Solar Beam (balance)
	[34490] =	 {class = "HUNTER",		specs = {71},			cooldown = 30, silence = 2, talent = 926,	cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Silencing Shot (Marksmanship)
	[19647] =	 {class = "WARLOCK",	specs = {88, 89, 90},	cooldown = 24, silence = 6, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = 417	}, --Spell Lock (pet felhunter ability)

	-- [Reborn]
	[1106552] =	 {class = "WARRIOR",	specs = {64, 65, 66},	cooldown = 10, silence = 4, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Pummel
	[1102139] =	 {class = "MAGE",		specs = {85, 86, 87},	cooldown = 24, silence = 8, talent = false, cooldownWithTalent = false,	cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Counterspell
	[1115487] =	 {class = "PRIEST",		specs = {78},			cooldown = 45, silence = 5, talent = false,	cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Silence (shadow)
	[1101766] =	 {class = "ROGUE",		specs = {73, 74, 75},	cooldown = 10, silence = 5, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Kick
	[1157994] =	 {class = "SHAMAN",		specs = {82, 83, 84},	cooldown = 6,  silence = 2, talent = false, cooldownWithTalent = false,	cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Wind Shear
	[1147528] =	 {class = "DEATHKNIGHT",specs = {79, 80, 81},	cooldown = 10, silence = 4, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Mind Freeze
	[1147476] =	 {class = "DEATHKNIGHT",specs = {79, 80, 81},	cooldown = 120,silence = 5, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Strangulate
	[2304523] =	 {class = "DRUID",		specs = {91},			cooldown = 50, silence = 6, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Solar Beam (balance)
	[1134490] =	 {class = "HUNTER",		specs = {71},			cooldown = 20, silence = 3, talent = false,	cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = false}, --Silencing Shot (Marksmanship)
	[1119647] =	 {class = "WARLOCK",	specs = {88, 89, 90},	cooldown = 24, silence = 6, talent = false, cooldownWithTalent = false, cooldownTalentId = false, type = ENUM_SPELL_TYPE.Interrupt, charges = 1, pet = 417	}, --Spell Lock (pet felhunter ability)
	
	--paladin
	-- 67 - Holy
	-- 68 - Protection
	-- 69 - Retribution

	-- [Classless]
	[31884] = 	{cooldown = 120, 	duration = 15, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.AttackCooldown}, --Avenging Wrath [Classless]
	[498] = 	{cooldown = 180, 	duration = 8, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Divine Protection [Classless]
	[642] = 	{cooldown = 300, 	duration = 4, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Divine Shield [Classless]
	[1022] = 	{cooldown = 300, 	duration = 6, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Hand of Protection [Classless]
	[6940] = 	{cooldown = 120, 	duration = 12, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Hand of Sacrifice [Classless]
	[31821] = 	{cooldown = 60, 	duration = 6, 		specs = {67},		 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.RaidDefensive}, --Aura Mastery [Classless]
	[1044] = 	{cooldown = 35, 	duration = 6, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalUtility}, --Hand of Freedom [Classless]
	[38152] = 	{cooldown = 120, 	duration = false, 	specs = {68}, 			talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Ardent Defender [Classless]
	[31842] = 	{cooldown = 90, 	duration = 15, 		specs = {67}, 			talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalUtility}, --Divine Illumination [Classless]

	-- [Reborn]
	[1131884] = {cooldown = 180, 	duration = 20, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.AttackCooldown}, --Avenging Wrath
	[1100498] = {cooldown = 180, 	duration = 12, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Divine Protection
	[1100642] = {cooldown = 300, 	duration = 12, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Divine Shield
	[1101022] = {cooldown = 300, 	duration = 6, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Hand of Protection
	[1106940] = {cooldown = 120, 	duration = 12, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.ExternalDefensive}, --Hand of Sacrifice
	[1131821] = {cooldown = 120, 	duration = 6, 		specs = {67},		 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.RaidDefensive}, --Aura Mastery
	[1101044] = {cooldown = 25, 	duration = 6, 		specs = {68,67,69}, 	talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalUtility}, --Hand of Freedom
	[1138152] = {cooldown = 120, 	duration = false, 	specs = {68}, 			talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Ardent Defender 
	[1131842] = {cooldown = 180, 	duration = 15, 		specs = {67}, 			talent =false, charges = 1, class = "PALADIN", type = ENUM_SPELL_TYPE.PersonalUtility}, --Divine Illumination 
	
	--warrior
	-- 64 - Arms
	-- 65 - Fury
	-- 66 - Protection

	-- [Classless]
	[46924] = 	{cooldown = 60, 	duration = 6, 		specs = {64},	 		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Bladestorm [Classless]
	[1719] = 	{cooldown = 180, 	duration = 8, 		specs = {64,65,66},		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Recklessness [Classless]
	[55694] = 	{cooldown = 180, 	duration = 10, 		specs = {64,65,66},		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Enraged Regeneration [Classless]
	[12975] = 	{cooldown = 120, 	duration = 20, 		specs = {66}, 			talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Last Stand [Classless]
	[871] = 	{cooldown = 300, 	duration = 12, 		specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Shield Wall [Classless]
	[64382]  = 	{cooldown = 60, 	duration = false, 	specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalUtility}, --Shattering Throw [Classless]
	[5246]  = 	{cooldown = 30, 	duration = 5, 		specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalUtility}, --Intimidating Shout [Classless]
	[886380] = 	{cooldown = 180, 	duration = 12, 		specs = {64,65,66},	 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Avatar [Classless]
	[955062] = 	{cooldown = 60, 	duration = 15, 		specs = {64,65,66},	 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.RaidDefensive}, --Demoralizing Banner [Classless]
	[954514] = 	{cooldown = 180, 	duration = 10, 		specs = {64,65,66},	 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Skull Banner [Classless]

	-- [Reborn]
	[1146924] = {cooldown = 60, 	duration = 6, 		specs = {64},	 		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Bladestorm
	[1101719] = {cooldown = 300, 	duration = 12, 		specs = {64,65,66},		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.AttackCooldown}, --Recklessness 
	[1155694] = {cooldown = 180, 	duration = 10, 		specs = {64,65,66},		talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Enraged Regeneration
	[1112975] = {cooldown = 180, 	duration = 20, 		specs = {66}, 			talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Last Stand
	[1100871] = {cooldown = 300, 	duration = 12, 		specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalDefensive}, --Shield Wall
	[1164382] = {cooldown = 300, 	duration = false, 	specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalUtility}, --Shattering Throw
	[1105246] = {cooldown = 120, 	duration = 8, 		specs = {64,65,66}, 	talent =false, charges = 1, class = "WARRIOR", type = ENUM_SPELL_TYPE.PersonalUtility}, --Intimidating Shout 

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
	-- [Classless]
	[6552] = LIB_OPEN_RAID_COOLDOWNS_INFO[6552], --Pummel
	[2139] = LIB_OPEN_RAID_COOLDOWNS_INFO[2139], --Counterspell
	[955071] = LIB_OPEN_RAID_COOLDOWNS_INFO[955071], -- Fizzle
	[15487] = LIB_OPEN_RAID_COOLDOWNS_INFO[15487], --Silence (shadow)
	[1766] = LIB_OPEN_RAID_COOLDOWNS_INFO[1766], --Kick
	[955070] = LIB_OPEN_RAID_COOLDOWNS_INFO[955070], --Rebuke
	[57994] = LIB_OPEN_RAID_COOLDOWNS_INFO[57994], --Wind Shear
	[47528] = LIB_OPEN_RAID_COOLDOWNS_INFO[47528], --Mind Freeze
	[47476] = LIB_OPEN_RAID_COOLDOWNS_INFO[47476], --Strangulate
	[78675] = LIB_OPEN_RAID_COOLDOWNS_INFO[78675], --Solar Beam (balance)
	[34490] = LIB_OPEN_RAID_COOLDOWNS_INFO[34490], --Silencing Shot
	[19647] = LIB_OPEN_RAID_COOLDOWNS_INFO[19647], --Spell Lock (pet felhunter ability)

	-- [Reborn]
	[1106552] = LIB_OPEN_RAID_COOLDOWNS_INFO[1106552], --Pummel
	[1102139] = LIB_OPEN_RAID_COOLDOWNS_INFO[1102139], --Counterspell
	[1115487] = LIB_OPEN_RAID_COOLDOWNS_INFO[1115487], --Silence (shadow)
	[1101766] = LIB_OPEN_RAID_COOLDOWNS_INFO[1101766], --Kick
	[1157994] = LIB_OPEN_RAID_COOLDOWNS_INFO[1157994], --Wind Shear
	[1147528] = LIB_OPEN_RAID_COOLDOWNS_INFO[1147528], --Mind Freeze
	[1147476] = LIB_OPEN_RAID_COOLDOWNS_INFO[1147476], --Strangulate
	[1178675] = LIB_OPEN_RAID_COOLDOWNS_INFO[1178675], --Solar Beam (balance)
	[1134490] = LIB_OPEN_RAID_COOLDOWNS_INFO[1134490], --Silencing Shot
	[1119647] = LIB_OPEN_RAID_COOLDOWNS_INFO[1119647], --Spell Lock (pet felhunter ability)
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
	[7384] = 	64, -- Overpower [Classless]
	[12294]   = 64, -- Mortal Strike (Rank 1) [Classless]
	[21551]   = 64, -- Mortal Strike (Rank 2) [Classless]
	[21552]   = 64, -- Mortal Strike (Rank 3) [Classless]
	[21553]   = 64, -- Mortal Strike (Rank 4) [Classless]
	[25248]   = 64, -- Mortal Strike (Rank 5) [Classless]
	[30330]   = 64, -- Mortal Strike (Rank 6) [Classless]
	[47485]   = 64, -- Mortal Strike (Rank 7) [Classless]
	[47486]   = 64, -- Mortal Strike (Rank 8) [Classless]
	[56636] = 	64, -- Taste for Blood, Rank 1 [Classless]
	[56637] = 	64, -- Taste for Blood, Rank 2 [Classless]
	[56638] = 	64, -- Taste for Blood, Rank 3 [Classless]
	[1107384] = 64, -- Overpower
	[1112294] = 64, -- Mortal Strike (Rank 1)
	[1121551] = 64, -- Mortal Strike (Rank 2)
	[1121552] = 64, -- Mortal Strike (Rank 3)
	[1121553] = 64, -- Mortal Strike (Rank 4)
	[1125248] = 64, -- Mortal Strike (Rank 5)
	[1130330] = 64, -- Mortal Strike (Rank 6)
	[1147485] = 64, -- Mortal Strike (Rank 7)
	[1147486] = 64, -- Mortal Strike (Rank 8)
	[1156636] = 64, -- Taste for Blood, Rank 1
	[1156637] = 64, -- Taste for Blood, Rank 2
	[1156638] = 64, -- Taste for Blood, Rank 3
	
	-- Fury Warrior [65]
	[977813] = 	65,	-- Titanic Strike, Rank RE (Titanic Strike)
	[977812] = 	65,	-- Titanic Strike (Off Hand), Rank RE (Titanic Strike)
	[954066] = 	65,	-- Titanic Mutilate, Rank RE (Titanic Mutilate)
	[954065] = 	65,	-- Titanic Mutilate (Off Hand), Rank RE (Titanic Mutilate)
	[977774] = 	65,	-- Dominant Strike, Rank RE (Ambidextrous)
	[977775] = 	65,	-- Southpaw Strike, Rank RE (Ambidextrous)
	[1003052] = 65,	-- Slam (Off-hand), Rank 0
	[1464] = 	65, -- Slam (Rank 1) [Classless] 
	[8820] = 	65, -- Slam (Rank 2) [Classless] 
	[11604] = 	65, -- Slam (Rank 3) [Classless] 
	[11605] = 	65, -- Slam (Rank 4) [Classless] 
	[25241] = 	65, -- Slam (Rank 5) [Classless] 
	[25242] = 	65, -- Slam (Rank 6) [Classless] 
	[47474] = 	65, -- Slam (Rank 7) [Classless] 
	[47475] = 	65, -- Slam (Rank 8) [Classless] 
	[23881] = 	65, -- Bloodthirst [Classless]
	[46917] = 	65, -- Titan's Grip [Classless]
	[49152] = 	65, -- Titan's Grip Effect [Classless]
	[1101464] = 65, -- Slam (Rank 1)
	[1108820] = 65, -- Slam (Rank 2)
	[1111604] = 65, -- Slam (Rank 3)
	[1111605] = 65, -- Slam (Rank 4)
	[1125241] = 65, -- Slam (Rank 5)
	[1125242] = 65, -- Slam (Rank 6)
	[1147474] = 65, -- Slam (Rank 7)
	[1147475] = 65, -- Slam (Rank 8)
	[1123881] = 65, -- Bloodthirst
	[1146917] = 65, -- Titan's Grip
	[1149152] = 65, -- Titan's Grip Effect


	-- Protection Warrior [66]
	[871] = 	66, -- Shield Wall [Classless]
	[12975] = 	66, -- Last Stand [Classless]
	[6572] = 	66, -- Revenge (Rank 1) [Classless]
	[6574] = 	66, -- Revenge (Rank 2) [Classless]
	[7379] = 	66, -- Revenge (Rank 3) [Classless]
	[11600] = 	66, -- Revenge (Rank 4) [Classless]
	[11601] = 	66, -- Revenge (Rank 5) [Classless]
	[25288] = 	66, -- Revenge (Rank 6) [Classless]
	[25269] = 	66, -- Revenge (Rank 7) [Classless]
	[30357] = 	66, -- Revenge (Rank 8) [Classless]
	[57823] = 	66, -- Revenge (Rank 9) [Classless]
	[20243] = 	66, -- Devastate (Rank 1) [Classless]
	[30016] = 	66, -- Devastate (Rank 2) [Classless]
	[30022] = 	66, -- Devastate (Rank 3) [Classless]
	[47497] = 	66, -- Devastate (Rank 4) [Classless]
	[47498] = 	66, -- Devastate (Rank 5) [Classless]
	[23922] = 	66, -- Shield Slam (Rank 1) [Classless]
	[23923] = 	66, -- Shield Slam (Rank 2) [Classless]
	[23924] = 	66, -- Shield Slam (Rank 3) [Classless]
	[23925] = 	66, -- Shield Slam (Rank 4) [Classless]
	[25258] = 	66, -- Shield Slam (Rank 5) [Classless]
	[30356] = 	66, -- Shield Slam (Rank 6) [Classless]
	[47487] = 	66, -- Shield Slam (Rank 7) [Classless]
	[47488] = 	66, -- Shield Slam (Rank 8) [Classless]
	[46953] = 	66, -- Sword and Board [Classless]
	[50227] = 	66, -- Sword and Board Trigger [Classless]
	[1100871] = 66, -- Shield Wall
	[1112975] = 66, -- Last Stand
	[1106572] = 66, -- Revenge (Rank 1) 
	[1106574] = 66, -- Revenge (Rank 2) 
	[1107379] = 66, -- Revenge (Rank 3) 
	[1111600] = 66, -- Revenge (Rank 4) 
	[1111601] = 66, -- Revenge (Rank 5) 
	[1125288] = 66, -- Revenge (Rank 6) 
	[1125269] = 66, -- Revenge (Rank 7) 
	[1130357] = 66, -- Revenge (Rank 8) 
	[1157823] = 66, -- Revenge (Rank 9) 
	[1120243] = 66, -- Devastate (Rank 1) 
	[1130016] = 66, -- Devastate (Rank 2) 
	[1130022] = 66, -- Devastate (Rank 3) 
	[1147497] = 66, -- Devastate (Rank 4) 
	[1147498] = 66, -- Devastate (Rank 5) 
	[1123922] = 66, -- Shield Slam (Rank 1) 
	[1123923] = 66, -- Shield Slam (Rank 2) 
	[1123924] = 66, -- Shield Slam (Rank 3) 
	[1123925] = 66, -- Shield Slam (Rank 4) 
	[1125258] = 66, -- Shield Slam (Rank 5) 
	[1130356] = 66, -- Shield Slam (Rank 6) 
	[1147487] = 66, -- Shield Slam (Rank 7) 
	[1147488] = 66, -- Shield Slam (Rank 8) 
	[1146953] = 66, -- Sword and Board
	[1150227] = 66, -- Sword and Board Trigger

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
	[1125914] =	67, -- Holy Shock (Rank 1) [Classless]
	[1125913] =	67, -- Holy Shock (Rank 2) [Classless]
	[1125903] =	67, -- Holy Shock (Rank 3) [Classless]
	[1127175] =	67, -- Holy Shock (Rank 4) [Classless]
	[1133074] =	67, -- Holy Shock (Rank 5) [Classless]
	[1148820] =	67, -- Holy Shock (Rank 6) [Classless]
	[1148821] =	67, -- Holy Shock (Rank 7) [Classless]
	[1100635] =	67, -- Holy Light (Rank 1) [Classless]
	[1100639] =	67, -- Holy Light (Rank 2) [Classless]
	[1100647] =	67, -- Holy Light (Rank 3) [Classless]
	[1101026] =	67, -- Holy Light (Rank 4) [Classless]
	[1101042] =	67, -- Holy Light (Rank 5) [Classless]
	[1103472] =	67, -- Holy Light (Rank 6) [Classless]
	[1110328] =	67, -- Holy Light (Rank 7) [Classless]
	[1110329] =	67, -- Holy Light (Rank 8) [Classless]
	[1125292] =	67, -- Holy Light (Rank 9) [Classless]
	[1127135] =	67, -- Holy Light (Rank 10) [Classless]
	[1127136] =	67, -- Holy Light (Rank 11) [Classless]
	[1148781] =	67, -- Holy Light (Rank 12) [Classless]
	[1148782] =	67, -- Holy Light (Rank 13) [Classless]

	-- Protection Paladin [68]
	[53595] = 	68, -- Hammer of the Righteous [Classless]
	[31935] = 	68, -- Avenger's Shield (Rank 1) [Classless]
	[32699] = 	68, -- Avenger's Shield (Rank 2) [Classless]
	[32700] = 	68, -- Avenger's Shield (Rank 3) [Classless]
	[48826] = 	68, -- Avenger's Shield (Rank 4) [Classless]
	[48827] = 	68, -- Avenger's Shield (Rank 5) [Classless]
	[20925] = 	68, -- Holy Shield (Rank 1) [Classless]
	[20927] = 	68, -- Holy Shield (Rank 2) [Classless]
	[20928] = 	68, -- Holy Shield (Rank 3) [Classless]
	[27179] = 	68, -- Holy Shield (Rank 4) [Classless]
	[48951] = 	68, -- Holy Shield (Rank 5) [Classless]
	[48952] = 	68, -- Holy Shield (Rank 6) [Classless]
	[1153595] = 68, -- Hammer of the Righteous
	[1131935] = 68, -- Avenger's Shield (Rank 1) 
	[1132699] = 68, -- Avenger's Shield (Rank 2) 
	[1132700] = 68, -- Avenger's Shield (Rank 3) 
	[1148826] = 68, -- Avenger's Shield (Rank 4) 
	[1148827] = 68, -- Avenger's Shield (Rank 5) 
	[1120925] = 68, -- Holy Shield (Rank 1) 
	[1120927] = 68, -- Holy Shield (Rank 2) 
	[1120928] = 68, -- Holy Shield (Rank 3) 
	[1127179] = 68, -- Holy Shield (Rank 4) 
	[1148951] = 68, -- Holy Shield (Rank 5) 
	[1148952] = 68, -- Holy Shield (Rank 6) 

	-- Retribution Paladin [69]
	[935395] = 	69,	-- Crusader Strike (One With The Light), Rank RE
	[953385] = 	69,	-- Divine Storm (One With The Light), Rank RE
	[53385] = 	69,	-- Divine Storm [Classless]
	[35395] = 	69,	-- Crusader Strike [Classless]
	[24275] = 	69,	-- Hammer of Wrath (Rank 1) [Classless]
	[24274] = 	69,	-- Hammer of Wrath (Rank 2) [Classless]
	[24239] = 	69,	-- Hammer of Wrath (Rank 3) [Classless]
	[27180] = 	69,	-- Hammer of Wrath (Rank 4) [Classless]
	[48805] = 	69,	-- Hammer of Wrath (Rank 5) [Classless]
	[48806] = 	69,	-- Hammer of Wrath (Rank 6) [Classless]
	[1153385] = 69,	-- Divine Storm
	[1135395] = 69,	-- Crusader Strike
	[1124275] = 69,	-- Hammer of Wrath (Rank 1) 
	[1124274] = 69,	-- Hammer of Wrath (Rank 2) 
	[1124239] = 69,	-- Hammer of Wrath (Rank 3) 
	[1127180] = 69,	-- Hammer of Wrath (Rank 4) 
	[1148805] = 69,	-- Hammer of Wrath (Rank 5) 
	[1148806] = 69,	-- Hammer of Wrath (Rank 6) 

	-- Beast Mastery Hunter [70]
	[34026] = 70, 	-- Kill Command Rank 0
	[19574] = 70, 	-- Bestial Wrath

	-- Marksmanship Hunter [71]
	[965941] = 	71,	-- Expunge, Rank RE
	[978762] = 	71,	-- Multi-Shot (Focused Burst), Rank RE
	[978761] = 	71,	-- Focused Burst, Rank RE
	[954052] = 	71,	-- Locust Shot, Rank RE
	[53209] =	71, -- Chimera Shot [Classless]
	[19434] =	71, -- Aimed Shot (Rank 1)  [Classless]
	[20900] =	71, -- Aimed Shot (Rank 2)  [Classless]
	[20901] =	71, -- Aimed Shot (Rank 3)  [Classless]
	[20902] =	71, -- Aimed Shot (Rank 4)  [Classless]
	[20903] =	71, -- Aimed Shot (Rank 5)  [Classless]
	[20904] =	71, -- Aimed Shot (Rank 6)  [Classless]
	[27065] =	71, -- Aimed Shot (Rank 7)  [Classless]
	[49049] =	71, -- Aimed Shot (Rank 8)  [Classless]
	[49050] =	71, -- Aimed Shot (Rank 9)  [Classless]
	[53254] =	71, -- Wild Quiver [Classless]
	[1153209] =	71, -- Chimera Shot
	[1119434] =	71, -- Aimed Shot (Rank 1) 
	[1120900] =	71, -- Aimed Shot (Rank 2) 
	[1120901] =	71, -- Aimed Shot (Rank 3) 
	[1120902] =	71, -- Aimed Shot (Rank 4) 
	[1120903] =	71, -- Aimed Shot (Rank 5) 
	[1120904] =	71, -- Aimed Shot (Rank 6) 
	[1127065] =	71, -- Aimed Shot (Rank 7) 
	[1149049] =	71, -- Aimed Shot (Rank 8) 
	[1149050] =	71, -- Aimed Shot (Rank 9) 
	[1153254] =	71, -- Wild Quiver

	-- Survival Hunter [72]
	[81449] = 	72, -- Explosive Shot (Aimed) (Rank 1) 
	[81450] = 	72, -- Explosive Shot (Aimed) (Rank 2) 
	[81451] = 	72, -- Explosive Shot (Aimed) (Rank 3) 
	[81452] = 	72, -- Explosive Shot (Aimed) (Rank 4) 
	[81278] = 	72,	-- Arrows of Fire, Rank RE
	[965408] = 	72,	-- Deadly Bite, Rank RE
	[53301] =	72, -- Explosive Shot (Rank 1) [Classless]
	[60051] =	72, -- Explosive Shot (Rank 2) [Classless]
	[60052] =	72, -- Explosive Shot (Rank 3) [Classless]
	[60053] =	72, -- Explosive Shot (Rank 4) [Classless]
	[1153301] =	72, -- Explosive Shot (Rank 1) 
	[1160051] =	72, -- Explosive Shot (Rank 2) 
	[1160052] =	72, -- Explosive Shot (Rank 3) 
	[1160053] =	72, -- Explosive Shot (Rank 4) 

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
	[32645] = 	73, -- Envenom (Rank 1) [Classless]
	[32684] = 	73, -- Envenom (Rank 2) [Classless]
	[57992] = 	73, -- Envenom (Rank 3) [Classless]
	[57993] = 	73, -- Envenom (Rank 4) [Classless]
	[1329] = 	73, -- Mutilate [Classless]
	[5374] = 	73, -- Mutilate [Classless]
	[27576] = 	73, -- Mutilate Off-Hand [Classless]
	[1132645] = 73, -- Envenom (Rank 1) 
	[1132684] = 73, -- Envenom (Rank 2) 
	[1157992] = 73, -- Envenom (Rank 3) 
	[1157993] = 73, -- Envenom (Rank 4) 
	[1101329] = 73, -- Mutilate
	[1105374] = 73, -- Mutilate
	[1127576] = 73, -- Mutilate Off-Hand

	-- Combat Rogue [74]
	[980050] = 	74,	-- Master of Shadow, Rank RE
	[978743] = 	74,	-- Double Down, Rank RE
	[51690] =	74,	-- Killing Spree [Classless]
	[1752] = 	74, -- Sinister Strike (Rank 1) [Classless]
	[1757] = 	74, -- Sinister Strike (Rank 2) [Classless]
	[1758] = 	74, -- Sinister Strike (Rank 3) [Classless]
	[1759] = 	74, -- Sinister Strike (Rank 4) [Classless]
	[1760] = 	74, -- Sinister Strike (Rank 5) [Classless]
	[8621] = 	74, -- Sinister Strike (Rank 6) [Classless]
	[11293] = 	74, -- Sinister Strike (Rank 7) [Classless]
	[11294] = 	74, -- Sinister Strike (Rank 8) [Classless]
	[26861] = 	74, -- Sinister Strike (Rank 9) [Classless]
	[26862] = 	74, -- Sinister Strike (Rank 10) [Classless]
	[48637] = 	74, -- Sinister Strike (Rank 11) [Classless]
	[48638] = 	74, -- Sinister Strike (Rank 12) [Classless]
	[1151690] =	74,	-- Killing Spree
	[1101752] = 74, -- Sinister Strike (Rank 1)
	[1101757] = 74, -- Sinister Strike (Rank 2)
	[1101758] = 74, -- Sinister Strike (Rank 3)
	[1101759] = 74, -- Sinister Strike (Rank 4)
	[1101760] = 74, -- Sinister Strike (Rank 5)
	[1108621] = 74, -- Sinister Strike (Rank 6)
	[1111293] = 74, -- Sinister Strike (Rank 7)
	[1111294] = 74, -- Sinister Strike (Rank 8)
	[1126861] = 74, -- Sinister Strike (Rank 9)
	[1126862] = 74, -- Sinister Strike (Rank 10)
	[1148637] = 74, -- Sinister Strike (Rank 11)
	[1148638] = 74, -- Sinister Strike (Rank 12)

	-- Subtlety Rogue [75]
	[53] = 		75, -- Backstab (Rank 1) [Classless]
	[2589] = 	75, -- Backstab (Rank 2) [Classless]
	[2590] = 	75, -- Backstab (Rank 3) [Classless]
	[2591] = 	75, -- Backstab (Rank 4) [Classless]
	[8721] = 	75, -- Backstab (Rank 5) [Classless]
	[11279] = 	75, -- Backstab (Rank 6) [Classless]
	[11280] = 	75, -- Backstab (Rank 7) [Classless]
	[11281] = 	75, -- Backstab (Rank 8) [Classless]
	[25300] = 	75, -- Backstab (Rank 9) [Classless]
	[26863] = 	75, -- Backstab (Rank 10) [Classless]
	[48656] = 	75, -- Backstab (Rank 11) [Classless]
	[48657] = 	75, -- Backstab (Rank 12) [Classless]
	[8676] = 	75, -- Ambush (Rank 1) [Classless]
	[8724] = 	75, -- Ambush (Rank 2) [Classless]
	[8725] = 	75, -- Ambush (Rank 3) [Classless]
	[11267] = 	75, -- Ambush (Rank 4) [Classless]
	[11268] = 	75, -- Ambush (Rank 5) [Classless]
	[11269] = 	75, -- Ambush (Rank 6) [Classless]
	[27441] = 	75, -- Ambush (Rank 7) [Classless]
	[48689] = 	75, -- Ambush (Rank 8) [Classless]
	[48690] = 	75, -- Ambush (Rank 9) [Classless]
	[48691] = 	75, -- Ambush (Rank 10) [Classless]
	[51713] = 	75, -- Shadow Dance [Classless]
	[1100053] = 75, -- Backstab (Rank 1)
	[1102589] = 75, -- Backstab (Rank 2)
	[1102590] = 75, -- Backstab (Rank 3)
	[1102591] = 75, -- Backstab (Rank 4)
	[1108721] = 75, -- Backstab (Rank 5)
	[1111279] = 75, -- Backstab (Rank 6)
	[1111280] = 75, -- Backstab (Rank 7)
	[1111281] = 75, -- Backstab (Rank 8)
	[1125300] = 75, -- Backstab (Rank 9)
	[1126863] = 75, -- Backstab (Rank 10)
	[1148656] = 75, -- Backstab (Rank 11)
	[1148657] = 75, -- Backstab (Rank 12)
	[1108676] = 75, -- Ambush (Rank 1)
	[1108724] = 75, -- Ambush (Rank 2)
	[1108725] = 75, -- Ambush (Rank 3)
	[1111267] = 75, -- Ambush (Rank 4)
	[1111268] = 75, -- Ambush (Rank 5)
	[1111269] = 75, -- Ambush (Rank 6)
	[1127441] = 75, -- Ambush (Rank 7)
	[1148689] = 75, -- Ambush (Rank 8)
	[1148690] = 75, -- Ambush (Rank 9)
	[1148691] = 75, -- Ambush (Rank 10)
	[1151713] = 75, -- Shadow Dance

	-- Discipline Priest [76]
	[17] = 		76, -- Power Word: Shield (Rank 1) [Classless]
	[592] = 	76, -- Power Word: Shield (Rank 2) [Classless]
	[600] = 	76, -- Power Word: Shield (Rank 3) [Classless]
	[3747] = 	76, -- Power Word: Shield (Rank 4) [Classless]
	[6065] = 	76, -- Power Word: Shield (Rank 5) [Classless]
	[6066] = 	76, -- Power Word: Shield (Rank 6) [Classless]
	[10898] = 	76, -- Power Word: Shield (Rank 7) [Classless]
	[10899] = 	76, -- Power Word: Shield (Rank 8) [Classless]
	[10900] = 	76, -- Power Word: Shield (Rank 9) [Classless]
	[10901] = 	76, -- Power Word: Shield (Rank 10) [Classless]
	[25217] = 	76, -- Power Word: Shield (Rank 11) [Classless]
	[25218] = 	76, -- Power Word: Shield (Rank 12) [Classless]
	[48065] = 	76, -- Power Word: Shield (Rank 13) [Classless]
	[48066] = 	76, -- Power Word: Shield (Rank 14) [Classless]
	[47750] = 	76, -- Penance (Rank 1) [Classless]
	[52983] = 	76, -- Penance (Rank 2) [Classless]
	[52984] = 	76, -- Penance (Rank 3) [Classless]
	[52985] = 	76, -- Penance (Rank 4) [Classless]
	[1100017] = 76, -- Power Word: Shield (Rank 1) 
	[1100592] = 76, -- Power Word: Shield (Rank 2) 
	[1100600] = 76, -- Power Word: Shield (Rank 3) 
	[1103747] = 76, -- Power Word: Shield (Rank 4) 
	[1106065] = 76, -- Power Word: Shield (Rank 5) 
	[1106066] = 76, -- Power Word: Shield (Rank 6) 
	[1110898] = 76, -- Power Word: Shield (Rank 7) 
	[1110899] = 76, -- Power Word: Shield (Rank 8) 
	[1110900] = 76, -- Power Word: Shield (Rank 9) 
	[1110901] = 76, -- Power Word: Shield (Rank 10) 
	[1125217] = 76, -- Power Word: Shield (Rank 11) 
	[1125218] = 76, -- Power Word: Shield (Rank 12) 
	[1148065] = 76, -- Power Word: Shield (Rank 13) 
	[1148066] = 76, -- Power Word: Shield (Rank 14) 
	[1147750] = 76, -- Penance (Rank 1) 
	[1152983] = 76, -- Penance (Rank 2) 
	[1152984] = 76, -- Penance (Rank 3) 
	[1152985] = 76, -- Penance (Rank 4) 

	-- Holy Priest [77]
	[2050] = 	77, -- Greater Heal (Rank 1) [Classless]
	[2052] = 	77, -- Greater Heal (Rank 2) [Classless]
	[2053] = 	77, -- Greater Heal (Rank 3) [Classless]
	[2054] = 	77, -- Greater Heal (Rank 4) [Classless]
	[2055] = 	77, -- Greater Heal (Rank 5) [Classless]
	[6063] = 	77, -- Greater Heal (Rank 6) [Classless]
	[6064] = 	77, -- Greater Heal (Rank 7) [Classless]
	[2060] = 	77, -- Greater Heal (Rank 8) [Classless]
	[10963] = 	77, -- Greater Heal (Rank 9) [Classless]
	[10964] = 	77, -- Greater Heal (Rank 10) [Classless]
	[10965] = 	77, -- Greater Heal (Rank 11) [Classless]
	[25314] = 	77, -- Greater Heal (Rank 12) [Classless]
	[25210] = 	77, -- Greater Heal (Rank 13) [Classless]
	[25213] = 	77, -- Greater Heal (Rank 14) [Classless]
	[48062] = 	77, -- Greater Heal (Rank 15) [Classless]
	[48063] = 	77, -- Greater Heal (Rank 16) [Classless]
	[34861] = 	77, -- Circle of Healing (Rank 1) [Classless]
	[34863] = 	77, -- Circle of Healing (Rank 2) [Classless]
	[34864] = 	77, -- Circle of Healing (Rank 3) [Classless]
	[34865] = 	77, -- Circle of Healing (Rank 4) [Classless]
	[34866] = 	77, -- Circle of Healing (Rank 5) [Classless]
	[48088] = 	77, -- Circle of Healing (Rank 6) [Classless]
	[48089] = 	77, -- Circle of Healing (Rank 7) [Classless]
	[596] = 	77, -- Prayer of Healing (Rank 1) [Classless]
	[996] = 	77, -- Prayer of Healing (Rank 2) [Classless]
	[10960] = 	77, -- Prayer of Healing (Rank 3) [Classless]
	[10961] = 	77, -- Prayer of Healing (Rank 4) [Classless]
	[25316] = 	77, -- Prayer of Healing (Rank 5) [Classless]
	[25308] = 	77, -- Prayer of Healing (Rank 6) [Classless]
	[48072] = 	77, -- Prayer of Healing (Rank 7) [Classless]
	[585] = 	77, -- Smite (Rank 1) [Classless]
	[591] = 	77, -- Smite (Rank 2) [Classless]
	[598] = 	77, -- Smite (Rank 3) [Classless]
	[984] = 	77, -- Smite (Rank 4) [Classless]
	[1004] = 	77, -- Smite (Rank 5) [Classless]
	[6060] = 	77, -- Smite (Rank 6) [Classless]
	[10933] = 	77, -- Smite (Rank 7) [Classless]
	[10934] = 	77, -- Smite (Rank 8) [Classless]
	[25363] = 	77, -- Smite (Rank 9) [Classless]
	[25364] = 	77, -- Smite (Rank 10) [Classless]
	[48122] = 	77, -- Smite (Rank 11) [Classless]
	[48123] = 	77, -- Smite (Rank 12) [Classless]
	[14914] = 	77, -- Holy Fire (Rank 1) [Classless]
	[15262] = 	77, -- Holy Fire (Rank 2) [Classless]
	[15263] = 	77, -- Holy Fire (Rank 3) [Classless]
	[15264] = 	77, -- Holy Fire (Rank 4) [Classless]
	[15265] = 	77, -- Holy Fire (Rank 5) [Classless]
	[15266] = 	77, -- Holy Fire (Rank 6) [Classless]
	[15267] = 	77, -- Holy Fire (Rank 7) [Classless]
	[15261] = 	77, -- Holy Fire (Rank 8) [Classless]
	[25384] = 	77, -- Holy Fire (Rank 9) [Classless]
	[48134] = 	77, -- Holy Fire (Rank 10) [Classless]
	[48135] = 	77, -- Holy Fire (Rank 11) [Classless]
	[1102050] = 77, -- Greater Heal (Rank 1) 
	[1102052] = 77, -- Greater Heal (Rank 2) 
	[1102053] = 77, -- Greater Heal (Rank 3) 
	[1102054] = 77, -- Greater Heal (Rank 4) 
	[1102055] = 77, -- Greater Heal (Rank 5) 
	[1106063] = 77, -- Greater Heal (Rank 6) 
	[1106064] = 77, -- Greater Heal (Rank 7) 
	[1102060] = 77, -- Greater Heal (Rank 8) 
	[1110963] = 77, -- Greater Heal (Rank 9) 
	[1110964] = 77, -- Greater Heal (Rank 10) 
	[1110965] = 77, -- Greater Heal (Rank 11) 
	[1125314] = 77, -- Greater Heal (Rank 12) 
	[1125210] = 77, -- Greater Heal (Rank 13) 
	[1125213] = 77, -- Greater Heal (Rank 14) 
	[1148062] = 77, -- Greater Heal (Rank 15) 
	[1148063] = 77, -- Greater Heal (Rank 16) 
	[1134861] = 77, -- Circle of Healing (Rank 1) 
	[1134863] = 77, -- Circle of Healing (Rank 2) 
	[1134864] = 77, -- Circle of Healing (Rank 3) 
	[1134865] = 77, -- Circle of Healing (Rank 4) 
	[1134866] = 77, -- Circle of Healing (Rank 5) 
	[1148088] = 77, -- Circle of Healing (Rank 6) 
	[1148089] = 77, -- Circle of Healing (Rank 7) 
	[1100596] = 77, -- Prayer of Healing (Rank 1) 
	[1100996] = 77, -- Prayer of Healing (Rank 2) 
	[1110960] = 77, -- Prayer of Healing (Rank 3) 
	[1110961] = 77, -- Prayer of Healing (Rank 4) 
	[1125316] = 77, -- Prayer of Healing (Rank 5) 
	[1125308] = 77, -- Prayer of Healing (Rank 6) 
	[1148072] = 77, -- Prayer of Healing (Rank 7) 
	[1100585] = 77, -- Smite (Rank 1) 
	[1100591] = 77, -- Smite (Rank 2) 
	[1100598] = 77, -- Smite (Rank 3) 
	[1100984] = 77, -- Smite (Rank 4) 
	[1101004] = 77, -- Smite (Rank 5) 
	[1106060] = 77, -- Smite (Rank 6) 
	[1110933] = 77, -- Smite (Rank 7) 
	[1110934] = 77, -- Smite (Rank 8) 
	[1125363] = 77, -- Smite (Rank 9) 
	[1125364] = 77, -- Smite (Rank 10) 
	[1148122] = 77, -- Smite (Rank 11) 
	[1148123] = 77, -- Smite (Rank 12) 
	[1114914] = 77, -- Holy Fire (Rank 1) 
	[1115262] = 77, -- Holy Fire (Rank 2) 
	[1115263] = 77, -- Holy Fire (Rank 3) 
	[1115264] = 77, -- Holy Fire (Rank 4) 
	[1115265] = 77, -- Holy Fire (Rank 5) 
	[1115266] = 77, -- Holy Fire (Rank 6) 
	[1115267] = 77, -- Holy Fire (Rank 7) 
	[1115261] = 77, -- Holy Fire (Rank 8) 
	[1125384] = 77, -- Holy Fire (Rank 9) 
	[1148134] = 77, -- Holy Fire (Rank 10) 
	[1148135] = 77, -- Holy Fire (Rank 11) 


	-- Shadow Priest [78]
	[81371] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 1) 
	[81372] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 2) 
	[81373] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 3) 
	[81374] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 4) 
	[81375] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 5) 
	[81376] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 6) 
	[81377] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 7) 
	[81378] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 8) 
	[81379] = 	78, -- Mind Flay (Unbounded Mind Flay) (Rank 9) 
	[977850] = 	78, -- Twilight Treason (Unbounded Mind Flay) (Rank RE) 
	[977851] = 	78, -- Twilight Treason (Unbounded Mind Flay) (Rank RE) 
	[760148] = 	78, -- Void Eruption
	[15407] = 	78,	-- Mind Flay (Rank 1) [Classless]
	[17311] = 	78, -- Mind Flay (Rank 2) [Classless]
	[17312] = 	78, -- Mind Flay (Rank 3) [Classless]
	[17313] = 	78,	-- Mind Flay (Rank 4) [Classless]
	[17314] = 	78, -- Mind Flay (Rank 5) [Classless]
	[18807] = 	78, -- Mind Flay (Rank 6) [Classless]
	[25387] = 	78, -- Mind Flay (Rank 7) [Classless]
	[48155] = 	78, -- Mind Flay (Rank 8) [Classless]
	[48156] = 	78, -- Mind Flay (Rank 9) [Classless]
	[1115407] = 78,	-- Mind Flay (Rank 1)
	[1117311] = 78, -- Mind Flay (Rank 2)
	[1117312] = 78, -- Mind Flay (Rank 3)
	[1117313] = 78,	-- Mind Flay (Rank 4)
	[1117314] = 78, -- Mind Flay (Rank 5)
	[1118807] = 78, -- Mind Flay (Rank 6)
	[1125387] = 78, -- Mind Flay (Rank 7)
	[1148155] = 78, -- Mind Flay (Rank 8)
	[1148156] = 78, -- Mind Flay (Rank 9)

	-- Blood Death Knight [79]
	[49028] = 	79, -- Dancing Rune Weapon [Classless]
	[55050] = 	79, -- Heart Strike [Classless]
	[1149028] = 79, -- Dancing Rune Weapon
	[1155050] = 79, -- Heart Strike

	-- Frost Death Knight [80]
	[49184] = 	80, -- Howling Blast [Classless]
	[49143] = 	80, -- Frost Strike [Classless]
	[49020] = 	80, -- Obliterate [Classless]
	[1149184] = 80, -- Howling Blast
	[1149143] = 80, -- Frost Strike
	[1149020] = 80, -- Obliterate

	-- Unholy Death Knight [81]
	[55090] = 	81, -- Scourge Strike [Classless]
	[45462] = 	81, -- Plague Strike [Classless]
	[47541] = 	81, -- Death Coil [Classless]
	[1155090] = 81, -- Scourge Strike
	[1145462] = 81, -- Plague Strike
	[1147541] = 81, -- Death Coil

	-- Elemental Shaman [82]
	[403] = 	82, -- Lightning Bolt (Rank 1) [Classless]
	[529] = 	82, -- Lightning Bolt (Rank 2) [Classless]
	[548] = 	82, -- Lightning Bolt (Rank 3) [Classless]
	[915] = 	82, -- Lightning Bolt (Rank 4) [Classless]
	[943] = 	82, -- Lightning Bolt (Rank 5) [Classless]
	[6041] = 	82, -- Lightning Bolt (Rank 6) [Classless]
	[10391] = 	82, -- Lightning Bolt (Rank 7) [Classless]
	[10392] = 	82, -- Lightning Bolt (Rank 8) [Classless]
	[15207] = 	82, -- Lightning Bolt (Rank 9) [Classless]
	[15208] = 	82, -- Lightning Bolt (Rank 10) [Classless]
	[25448] = 	82, -- Lightning Bolt (Rank 11) [Classless]
	[25449] = 	82, -- Lightning Bolt (Rank 12) [Classless]
	[49237] = 	82, -- Lightning Bolt (Rank 13) [Classless]
	[49238] = 	82, -- Lightning Bolt (Rank 14) [Classless]
	[421] = 	82, -- Chain Lightning (Rank 1) [Classless]
	[930] = 	82, -- Chain Lightning (Rank 2) [Classless]
	[2860] = 	82, -- Chain Lightning (Rank 3) [Classless]
	[10605] = 	82, -- Chain Lightning (Rank 4) [Classless]
	[25439] = 	82, -- Chain Lightning (Rank 5) [Classless]
	[25442] = 	82, -- Chain Lightning (Rank 6) [Classless]
	[49270] = 	82, -- Chain Lightning (Rank 7) [Classless]
	[49271] = 	82, -- Chain Lightning (Rank 8) [Classless]
	[1100403] = 82, -- Lightning Bolt (Rank 1) 
	[1100529] = 82, -- Lightning Bolt (Rank 2) 
	[1100548] = 82, -- Lightning Bolt (Rank 3) 
	[1100915] = 82, -- Lightning Bolt (Rank 4) 
	[1100943] = 82, -- Lightning Bolt (Rank 5) 
	[1106041] = 82, -- Lightning Bolt (Rank 6) 
	[1110391] = 82, -- Lightning Bolt (Rank 7) 
	[1110392] = 82, -- Lightning Bolt (Rank 8) 
	[1115207] = 82, -- Lightning Bolt (Rank 9) 
	[1115208] = 82, -- Lightning Bolt (Rank 10) 
	[1125448] = 82, -- Lightning Bolt (Rank 11) 
	[1125449] = 82, -- Lightning Bolt (Rank 12) 
	[1149237] = 82, -- Lightning Bolt (Rank 13) 
	[1149238] = 82, -- Lightning Bolt (Rank 14) 
	[1100421] = 82, -- Chain Lightning (Rank 1) 
	[1100930] = 82, -- Chain Lightning (Rank 2) 
	[1102860] = 82, -- Chain Lightning (Rank 3) 
	[1110605] = 82, -- Chain Lightning (Rank 4) 
	[1125439] = 82, -- Chain Lightning (Rank 5) 
	[1125442] = 82, -- Chain Lightning (Rank 6) 
	[1149270] = 82, -- Chain Lightning (Rank 7) 
	[1149271] = 82, -- Chain Lightning (Rank 8) 

	-- Enhancement Shaman [83]
	[860103] = 	83,	-- Ice Lash, Rank RE
	[60103] = 	83,	-- Lava Lash [Classless]
	[17364] = 	83,	-- Stormstrike [Classless]
	[1160103] = 83,	-- Lava Lash
	[1117364] = 83,	-- Stormstrike

	-- Restoration Shaman [84]
	[331] = 	84, -- Healing Wave (Rank 1) [Classless]
	[332] = 	84, -- Healing Wave (Rank 2) [Classless]
	[547] = 	84, -- Healing Wave (Rank 3) [Classless]
	[913] = 	84, -- Healing Wave (Rank 4) [Classless]
	[939] = 	84, -- Healing Wave (Rank 5) [Classless]
	[959] = 	84, -- Healing Wave (Rank 6) [Classless]
	[8005] = 	84, -- Healing Wave (Rank 7) [Classless]
	[10395] = 	84, -- Healing Wave (Rank 8) [Classless]
	[10396] = 	84, -- Healing Wave (Rank 9) [Classless]
	[25357] = 	84, -- Healing Wave (Rank 10) [Classless]
	[25391] = 	84, -- Healing Wave (Rank 11) [Classless]
	[25396] = 	84, -- Healing Wave (Rank 12) [Classless]
	[49272] = 	84, -- Healing Wave (Rank 13) [Classless]
	[49273] = 	84, -- Healing Wave (Rank 14) [Classless]
	[8004] = 	84, -- Lesser Healing Wave (Rank 1) [Classless]
	[8008] = 	84, -- Lesser Healing Wave (Rank 2) [Classless]
	[8010] = 	84, -- Lesser Healing Wave (Rank 3) [Classless]
	[10466] = 	84, -- Lesser Healing Wave (Rank 4) [Classless]
	[10467] = 	84, -- Lesser Healing Wave (Rank 5) [Classless]
	[10468] = 	84, -- Lesser Healing Wave (Rank 6) [Classless]
	[25420] = 	84, -- Lesser Healing Wave (Rank 7) [Classless]
	[49275] = 	84, -- Lesser Healing Wave (Rank 8) [Classless]
	[49276] = 	84, -- Lesser Healing Wave (Rank 9) [Classless]
	[1064] = 	84, -- Chain Heal (Rank 1) [Classless]
	[10622] = 	84, -- Chain Heal (Rank 2) [Classless]
	[10623] = 	84, -- Chain Heal (Rank 3) [Classless]
	[25422] = 	84, -- Chain Heal (Rank 4) [Classless]
	[25423] = 	84, -- Chain Heal (Rank 5) [Classless]
	[55458] = 	84, -- Chain Heal (Rank 6) [Classless]
	[55459] = 	84, -- Chain Heal (Rank 7) [Classless]
	[974] = 	84, -- Earth Shield (Rank 1) [Classless]
	[32593] = 	84, -- Earth Shield (Rank 2) [Classless]
	[32594] = 	84, -- Earth Shield (Rank 3) [Classless]
	[49283] = 	84, -- Earth Shield (Rank 4) [Classless]
	[49284] = 	84, -- Earth Shield (Rank 5) [Classless]
	[61295] = 	84, -- Riptide (Rank 1) [Classless]
	[61299] = 	84, -- Riptide (Rank 2) [Classless]
	[61300] = 	84, -- Riptide (Rank 3) [Classless]
	[61301] = 	84, -- Riptide (Rank 4) [Classless]
	[1100331] = 84, -- Healing Wave (Rank 1) 
	[1100332] = 84, -- Healing Wave (Rank 2) 
	[1100547] = 84, -- Healing Wave (Rank 3) 
	[1100913] = 84, -- Healing Wave (Rank 4) 
	[1100939] = 84, -- Healing Wave (Rank 5) 
	[1100959] = 84, -- Healing Wave (Rank 6) 
	[1108005] = 84, -- Healing Wave (Rank 7) 
	[1110395] = 84, -- Healing Wave (Rank 8) 
	[1110396] = 84, -- Healing Wave (Rank 9) 
	[1125357] = 84, -- Healing Wave (Rank 10) 
	[1125391] = 84, -- Healing Wave (Rank 11) 
	[1125396] = 84, -- Healing Wave (Rank 12) 
	[1149272] = 84, -- Healing Wave (Rank 13) 
	[1149273] = 84, -- Healing Wave (Rank 14) 
	[1108004] = 84, -- Lesser Healing Wave (Rank 1) 
	[1108008] = 84, -- Lesser Healing Wave (Rank 2) 
	[1108010] = 84, -- Lesser Healing Wave (Rank 3) 
	[1110466] = 84, -- Lesser Healing Wave (Rank 4) 
	[1110467] = 84, -- Lesser Healing Wave (Rank 5) 
	[1110468] = 84, -- Lesser Healing Wave (Rank 6) 
	[1125420] = 84, -- Lesser Healing Wave (Rank 7) 
	[1149275] = 84, -- Lesser Healing Wave (Rank 8) 
	[1149276] = 84, -- Lesser Healing Wave (Rank 9) 
	[1101064] = 84, -- Chain Heal (Rank 1) 
	[1110622] = 84, -- Chain Heal (Rank 2) 
	[1110623] = 84, -- Chain Heal (Rank 3) 
	[1125422] = 84, -- Chain Heal (Rank 4) 
	[1125423] = 84, -- Chain Heal (Rank 5) 
	[1155458] = 84, -- Chain Heal (Rank 6) 
	[1155459] = 84, -- Chain Heal (Rank 7) 
	[1100974] = 84, -- Earth Shield (Rank 1) 
	[1132593] = 84, -- Earth Shield (Rank 2) 
	[1132594] = 84, -- Earth Shield (Rank 3) 
	[1149283] = 84, -- Earth Shield (Rank 4) 
	[1149284] = 84, -- Earth Shield (Rank 5)
	[1161295] = 84, -- Riptide (Rank 1) 
	[1161299] = 84, -- Riptide (Rank 2) 
	[1161300] = 84, -- Riptide (Rank 3) 
	[1161301] = 84, -- Riptide (Rank 4) 

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
	[44425] =	85, -- Arcane Barrage (Rank 1) [Classless]
	[44780] =	85, -- Arcane Barrage (Rank 2) [Classless]
	[44781] =	85, -- Arcane Barrage (Rank 3) [Classless]
	[30451] =	85, -- Arcane Blast (Rank 1) [Classless]
	[42894] =	85, -- Arcane Blast (Rank 2) [Classless]
	[42896] =	85, -- Arcane Blast (Rank 3) [Classless]
	[42897] =	85, -- Arcane Blast (Rank 4) [Classless]
	[1144425] =	85, -- Arcane Barrage (Rank 1) 
	[1144780] =	85, -- Arcane Barrage (Rank 2) 
	[1144781] =	85, -- Arcane Barrage (Rank 3) 
	[1130451] =	85, -- Arcane Blast (Rank 1) 
	[1142894] =	85, -- Arcane Blast (Rank 2) 
	[1142896] =	85, -- Arcane Blast (Rank 3) 
	[1142897] =	85, -- Arcane Blast (Rank 4) 

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
	[133] = 	86, -- Fireball (Rank 1) [Classless]
	[143] = 	86, -- Fireball (Rank 2) [Classless]
	[145] = 	86, -- Fireball (Rank 3) [Classless]
	[3140] = 	86, -- Fireball (Rank 4) [Classless]
	[8400] = 	86, -- Fireball (Rank 5) [Classless]
	[8401] = 	86, -- Fireball (Rank 6) [Classless]
	[8402] = 	86, -- Fireball (Rank 7) [Classless]
	[10148] = 	86, -- Fireball (Rank 8) [Classless]
	[10149] = 	86, -- Fireball (Rank 9) [Classless]
	[10150] = 	86, -- Fireball (Rank 10) [Classless]
	[10151] = 	86, -- Fireball (Rank 11) [Classless]
	[25306] = 	86, -- Fireball (Rank 12) [Classless]
	[27070] = 	86, -- Fireball (Rank 13) [Classless]
	[38692] = 	86, -- Fireball (Rank 14) [Classless]
	[42832] = 	86, -- Fireball (Rank 15) [Classless]
	[42833] = 	86, -- Fireball (Rank 16) [Classless]
	[1811] = 	86, -- Scorch (Rank 1) [Classless]
	[8447] = 	86, -- Scorch (Rank 2) [Classless]
	[8448] = 	86, -- Scorch (Rank 3) [Classless]
	[8449] = 	86, -- Scorch (Rank 4) [Classless]
	[10208] = 	86, -- Scorch (Rank 5) [Classless]
	[10209] = 	86, -- Scorch (Rank 6) [Classless]
	[10210] = 	86, -- Scorch (Rank 7) [Classless]
	[27375] = 	86, -- Scorch (Rank 8) [Classless]
	[27376] = 	86, -- Scorch (Rank 9) [Classless]
	[42858] = 	86, -- Scorch (Rank 10) [Classless]
	[42859] = 	86, -- Scorch (Rank 11) [Classless]
	[11366] =   86, -- Pyroblast (Rank 1) [Classless]
	[12505] =   86, -- Pyroblast (Rank 2) [Classless]
	[12522] =   86, -- Pyroblast (Rank 3) [Classless]
	[12523] =   86, -- Pyroblast (Rank 4) [Classless]
	[12524] =   86, -- Pyroblast (Rank 5) [Classless]
	[12525] =   86, -- Pyroblast (Rank 6) [Classless]
	[12526] =   86, -- Pyroblast (Rank 7) [Classless]
	[18809] =   86, -- Pyroblast (Rank 8) [Classless]
	[27132] =   86, -- Pyroblast (Rank 9) [Classless]
	[33938] =   86, -- Pyroblast (Rank 10) [Classless]
	[42890] =   86, -- Pyroblast (Rank 11) [Classless]
	[42891] =   86, -- Pyroblast (Rank 12) [Classless]
	[1100133] = 86, -- Fireball (Rank 1) 
	[1100143] = 86, -- Fireball (Rank 2) 
	[1100145] = 86, -- Fireball (Rank 3) 
	[1103140] = 86, -- Fireball (Rank 4) 
	[1108400] = 86, -- Fireball (Rank 5) 
	[1108401] = 86, -- Fireball (Rank 6) 
	[1108402] = 86, -- Fireball (Rank 7) 
	[1110148] = 86, -- Fireball (Rank 8) 
	[1110149] = 86, -- Fireball (Rank 9) 
	[1110150] = 86, -- Fireball (Rank 10) 
	[1110151] = 86, -- Fireball (Rank 11) 
	[1125306] = 86, -- Fireball (Rank 12) 
	[1127070] = 86, -- Fireball (Rank 13) 
	[1138692] = 86, -- Fireball (Rank 14) 
	[1142832] = 86, -- Fireball (Rank 15) 
	[1142833] = 86, -- Fireball (Rank 16) 
	[1101811] = 86, -- Scorch (Rank 1) 
	[1108447] = 86, -- Scorch (Rank 2) 
	[1108448] = 86, -- Scorch (Rank 3) 
	[1108449] = 86, -- Scorch (Rank 4) 
	[1110208] = 86, -- Scorch (Rank 5) 
	[1110209] = 86, -- Scorch (Rank 6) 
	[1110210] = 86, -- Scorch (Rank 7) 
	[1127375] = 86, -- Scorch (Rank 8) 
	[1127376] = 86, -- Scorch (Rank 9) 
	[1142858] = 86, -- Scorch (Rank 10) 
	[1142859] = 86, -- Scorch (Rank 11) 
	[1111366] = 86, -- Pyroblast (Rank 1) 
	[1112505] = 86, -- Pyroblast (Rank 2) 
	[1112522] = 86, -- Pyroblast (Rank 3) 
	[1112523] = 86, -- Pyroblast (Rank 4) 
	[1112524] = 86, -- Pyroblast (Rank 5) 
	[1112525] = 86, -- Pyroblast (Rank 6) 
	[1112526] = 86, -- Pyroblast (Rank 7) 
	[1118809] = 86, -- Pyroblast (Rank 8) 
	[1127132] = 86, -- Pyroblast (Rank 9) 
	[1133938] = 86, -- Pyroblast (Rank 10) 
	[1142890] = 86, -- Pyroblast (Rank 11) 
	[1142891] = 86, -- Pyroblast (Rank 12) 

	-- Frost Mage [87]
	[953313] = 	87,	-- Evoker, Rank RE
	[30455] = 	87,	-- Ice Lance (Rank 1) [Classless]
	[42913] = 	87,	-- Ice Lance (Rank 2) [Classless]
	[42914] = 	87,	-- Ice Lance (Rank 3) [Classless]
	[1130455] = 87,	-- Ice Lance (Rank 1) 
	[1142913] = 87,	-- Ice Lance (Rank 2) 
	[1142914] = 87,	-- Ice Lance (Rank 3) 

	-- Affliction Warlock [88]
	[978426] = 	88,	-- Shadow Lance, Rank RE (Fingers of Death)
	[48181] = 	88, -- Haunt (Rank 1) [Classless]
	[59161] = 	88, -- Haunt (Rank 2) [Classless]
	[59163] = 	88, -- Haunt (Rank 3) [Classless]
	[59164] = 	88, -- Haunt (Rank 4) [Classless]
	[30108] = 	88, -- Unstable Affliction (Rank 1) [Classless]
	[30404] = 	88, -- Unstable Affliction (Rank 2) [Classless]
	[30405] = 	88, -- Unstable Affliction (Rank 3) [Classless]
	[47841] = 	88, -- Unstable Affliction (Rank 4) [Classless]
	[47843] = 	88, -- Unstable Affliction (Rank 5) [Classless]
	[1148181] = 88, -- Haunt (Rank 1) 
	[1159161] = 88, -- Haunt (Rank 2) 
	[1159163] = 88, -- Haunt (Rank 3) 
	[1159164] = 88, -- Haunt (Rank 4) 
	[1130108] = 88, -- Unstable Affliction (Rank 1) 
	[1130404] = 88, -- Unstable Affliction (Rank 2) 
	[1130405] = 88, -- Unstable Affliction (Rank 3) 
	[1147841] = 88, -- Unstable Affliction (Rank 4) 
	[1147843] = 88, -- Unstable Affliction (Rank 5) 

	-- Demonology Warlock [89]
	[50581] = 	89,	-- Shadow Cleave [Classless]
	[47241] = 	89,	-- Metamorphosis [Classless]
	[1150581] = 89,	-- Shadow Cleave
	[1147241] = 89,	-- Metamorphosis

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
	[6353] = 	90, -- Soul Fire (Rank 1) [Classless]
	[17924] = 	90, -- Soul Fire (Rank 2) [Classless]
	[27211] = 	90, -- Soul Fire (Rank 3) [Classless]
	[30545] = 	90, -- Soul Fire (Rank 4) [Classless]
	[47824] = 	90, -- Soul Fire (Rank 5) [Classless]
	[47825] = 	90, -- Soul Fire (Rank 6) [Classless]
	[348] = 	90, -- Immolate (Rank 1) [Classless]
	[707] = 	90, -- Immolate (Rank 2) [Classless]
	[1094] = 	90, -- Immolate (Rank 3) [Classless]
	[2941] = 	90, -- Immolate (Rank 4) [Classless]
	[11665] = 	90, -- Immolate (Rank 5) [Classless]
	[11667] = 	90, -- Immolate (Rank 6) [Classless]
	[11668] = 	90, -- Immolate (Rank 7) [Classless]
	[25309] = 	90, -- Immolate (Rank 8) [Classless]
	[27215] = 	90, -- Immolate (Rank 9) [Classless]
	[47810] = 	90, -- Immolate (Rank 10) [Classless]
	[47811] = 	90, -- Immolate (Rank 11) [Classless]
	[17962] = 	90,	-- Conflagrate [Classless]
	[50796] = 	90, -- Chaos Bolt (Rank 1) [Classless]
	[59170] = 	90, -- Chaos Bolt (Rank 2) [Classless]
	[59171] = 	90, -- Chaos Bolt (Rank 3) [Classless]
	[59172] = 	90, -- Chaos Bolt (Rank 4) [Classless]
	[29722] = 	90, -- Incinerate (Rank 1) [Classless]
	[32231] = 	90, -- Incinerate (Rank 2) [Classless]
	[47837] = 	90, -- Incinerate (Rank 3) [Classless]
	[47838] = 	90, -- Incinerate (Rank 4) [Classless]
	[686] = 	90, -- Shadow Bolt (Rank 1) [Classless]
	[695] = 	90, -- Shadow Bolt (Rank 2) [Classless]
	[705] = 	90, -- Shadow Bolt (Rank 3) [Classless]
	[1088] = 	90, -- Shadow Bolt (Rank 4) [Classless]
	[1106] = 	90, -- Shadow Bolt (Rank 5) [Classless]
	[7641] = 	90, -- Shadow Bolt (Rank 6) [Classless]
	[11659] = 	90, -- Shadow Bolt (Rank 7) [Classless]
	[11660] = 	90, -- Shadow Bolt (Rank 8) [Classless]
	[11661] = 	90, -- Shadow Bolt (Rank 9) [Classless]
	[25307] = 	90, -- Shadow Bolt (Rank 10) [Classless]
	[27209] = 	90, -- Shadow Bolt (Rank 11) [Classless]
	[47808] = 	90, -- Shadow Bolt (Rank 12) [Classless]
	[47809] = 	90, -- Shadow Bolt (Rank 13) [Classless]
	[1106353] =	90, -- Soul Fire (Rank 1) 
	[1117924] =	90, -- Soul Fire (Rank 2) 
	[1127211] =	90, -- Soul Fire (Rank 3) 
	[1130545] =	90, -- Soul Fire (Rank 4) 
	[1147824] =	90, -- Soul Fire (Rank 5) 
	[1147825] =	90, -- Soul Fire (Rank 6) 
	[1100348] =	90, -- Immolate (Rank 1) 
	[1100707] =	90, -- Immolate (Rank 2) 
	[1101094] =	90, -- Immolate (Rank 3) 
	[1102941] =	90, -- Immolate (Rank 4) 
	[1111665] =	90, -- Immolate (Rank 5) 
	[1111667] =	90, -- Immolate (Rank 6) 
	[1111668] =	90, -- Immolate (Rank 7) 
	[1125309] =	90, -- Immolate (Rank 8) 
	[1127215] =	90, -- Immolate (Rank 9) 
	[1147810] =	90, -- Immolate (Rank 10) 
	[1147811] =	90, -- Immolate (Rank 11) 
	[1117962] =	90,	-- Conflagrate
	[1150796] =	90, -- Chaos Bolt (Rank 1) 
	[1159170] =	90, -- Chaos Bolt (Rank 2) 
	[1159171] =	90, -- Chaos Bolt (Rank 3) 
	[1159172] =	90, -- Chaos Bolt (Rank 4) 
	[1129722] =	90, -- Incinerate (Rank 1) 
	[1132231] =	90, -- Incinerate (Rank 2) 
	[1147837] =	90, -- Incinerate (Rank 3) 
	[1147838] =	90, -- Incinerate (Rank 4) 
	[1100686] =	90, -- Shadow Bolt (Rank 1) 
	[1100695] =	90, -- Shadow Bolt (Rank 2) 
	[1100705] =	90, -- Shadow Bolt (Rank 3) 
	[1101088] =	90, -- Shadow Bolt (Rank 4) 
	[1101106] =	90, -- Shadow Bolt (Rank 5) 
	[1107641] =	90, -- Shadow Bolt (Rank 6) 
	[1111659] =	90, -- Shadow Bolt (Rank 7) 
	[1111660] =	90, -- Shadow Bolt (Rank 8) 
	[1111661] =	90, -- Shadow Bolt (Rank 9) 
	[1125307] =	90, -- Shadow Bolt (Rank 10) 
	[1127209] =	90, -- Shadow Bolt (Rank 11) 
	[1147808] =	90, -- Shadow Bolt (Rank 12) 
	[1147809] =	90, -- Shadow Bolt (Rank 13) 	

	-- Balance Druid [91]
	[48505] = 	91,	-- Starfall (Rank 1) [Classless]
	[53199] = 	91,	-- Starfall (Rank 2) [Classless]
	[53200] = 	91,	-- Starfall (Rank 3) [Classless]
	[53201] = 	91,	-- Starfall (Rank 4) [Classless]
	[2912] = 	91,	-- Starfire (Rank 1) [Classless]
	[8949] = 	91,	-- Starfire (Rank 2) [Classless]
	[8950] = 	91,	-- Starfire (Rank 3) [Classless]
	[8951] = 	91,	-- Starfire (Rank 4) [Classless]
	[9875] = 	91,	-- Starfire (Rank 5) [Classless]
	[9876] = 	91,	-- Starfire (Rank 6) [Classless]
	[25298] = 	91,	-- Starfire (Rank 7) [Classless]
	[26986] = 	91,	-- Starfire (Rank 8) [Classless]
	[48464] = 	91,	-- Starfire (Rank 9) [Classless]
	[48465] = 	91,	-- Starfire (Rank 10) [Classless]
	[5570] = 	91,	-- Insect Swarm (Rank 1) [Classless]
	[24974] = 	91,	-- Insect Swarm (Rank 2) [Classless]
	[24975] = 	91,	-- Insect Swarm (Rank 3) [Classless]
	[24976] = 	91,	-- Insect Swarm (Rank 4) [Classless]
	[24977] = 	91,	-- Insect Swarm (Rank 5) [Classless]
	[27013] = 	91,	-- Insect Swarm (Rank 6) [Classless]
	[48468] = 	91,	-- Insect Swarm (Rank 7) [Classless]
	[1148505] = 91,	-- Starfall (Rank 1) 
	[1153199] = 91,	-- Starfall (Rank 2) 
	[1153200] = 91,	-- Starfall (Rank 3) 
	[1153201] = 91,	-- Starfall (Rank 4)
	[1102912] = 91,	-- Starfire (Rank 1) 
	[1108949] = 91,	-- Starfire (Rank 2) 
	[1108950] = 91,	-- Starfire (Rank 3) 
	[1108951] = 91,	-- Starfire (Rank 4) 
	[1109875] = 91,	-- Starfire (Rank 5) 
	[1109876] = 91,	-- Starfire (Rank 6) 
	[1125298] = 91,	-- Starfire (Rank 7) 
	[1126986] = 91,	-- Starfire (Rank 8) 
	[1148464] = 91,	-- Starfire (Rank 9) 
	[1148465] = 91,	-- Starfire (Rank 10) 
	[1105570] = 91,	-- Insect Swarm (Rank 1) 
	[1124974] = 91,	-- Insect Swarm (Rank 2) 
	[1124975] = 91,	-- Insect Swarm (Rank 3) 
	[1124976] = 91,	-- Insect Swarm (Rank 4) 
	[1124977] = 91,	-- Insect Swarm (Rank 5) 
	[1127013] = 91,	-- Insect Swarm (Rank 6) 
	[1148468] = 91,	-- Insect Swarm (Rank 7) 

	-- Feral Druid [92]
	[977791] = 	92, -- Predator's Wrath (Rank RE)
	[5221] = 	92, -- Shred (Rank 1) [Classless]
	[6800] = 	92, -- Shred (Rank 2) [Classless]
	[8992] = 	92, -- Shred (Rank 3) [Classless]
	[9829] = 	92, -- Shred (Rank 4) [Classless]
	[9830] = 	92, -- Shred (Rank 5) [Classless]
	[27001] = 	92, -- Shred (Rank 6) [Classless]
	[27002] = 	92, -- Shred (Rank 7) [Classless]
	[48571] = 	92, -- Shred (Rank 8) [Classless]
	[48572] = 	92, -- Shred (Rank 9) [Classless]
	[33876] = 	92, -- Mangle (Cat) (Rank 1) [Classless]
	[33982] = 	92, -- Mangle (Cat) (Rank 2) [Classless]
	[33983] = 	92, -- Mangle (Cat) (Rank 3) [Classless]
	[48565] = 	92, -- Mangle (Cat) (Rank 4) [Classless]
	[48566] = 	92, -- Mangle (Cat) (Rank 5) [Classless]
	[1822] = 	92, -- Rake (Rank 1) [Classless]
	[1823] = 	92, -- Rake (Rank 2) [Classless]
	[1824] = 	92, -- Rake (Rank 3) [Classless]
	[9904] = 	92, -- Rake (Rank 4) [Classless]
	[27003] = 	92, -- Rake (Rank 5) [Classless]
	[48573] = 	92, -- Rake (Rank 6) [Classless]
	[48574] = 	92, -- Rake (Rank 7) [Classless]
	[59881] = 	92, -- Rake (Rank 1) [Classless]
	[59882] = 	92, -- Rake (Rank 2) [Classless]
	[59883] = 	92, -- Rake (Rank 3) [Classless]
	[59884] = 	92, -- Rake (Rank 4) [Classless]
	[59885] = 	92, -- Rake (Rank 5) [Classless]
	[59886] = 	92, -- Rake (Rank 6) [Classless]
	[1079] = 	92, -- Rip (Rank 1) [Classless]
	[9492] = 	92, -- Rip (Rank 2) [Classless]
	[9493] = 	92, -- Rip (Rank 3) [Classless]
	[9752] = 	92, -- Rip (Rank 4) [Classless]
	[9894] = 	92, -- Rip (Rank 5) [Classless]
	[9896] = 	92, -- Rip (Rank 6) [Classless]
	[27008] = 	92, -- Rip (Rank 7) [Classless]
	[49799] = 	92, -- Rip (Rank 8) [Classless]
	[49800] = 	92, -- Rip (Rank 9) [Classless]
	[33878] = 	92, -- Mangle (Bear) (Rank 1) [Classless]
	[33986] = 	92, -- Mangle (Bear) (Rank 2) [Classless]
	[33987] = 	92, -- Mangle (Bear) (Rank 3) [Classless]
	[48563] = 	92, -- Mangle (Bear) (Rank 4) [Classless]
	[48564] = 	92, -- Mangle (Bear) (Rank 5) [Classless]
	[33745] = 	92, -- Lacerate (Rank 1) [Classless]
	[48567] = 	92, -- Lacerate (Rank 2) [Classless]
	[48568] = 	92, -- Lacerate (Rank 3) [Classless]
	[6807] = 	92, -- Maul (Rank 1) [Classless]
	[6808] = 	92, -- Maul (Rank 2) [Classless]
	[6809] = 	92, -- Maul (Rank 3) [Classless]
	[8972] = 	92, -- Maul (Rank 4) [Classless]
	[9745] = 	92, -- Maul (Rank 5) [Classless]
	[9880] = 	92, -- Maul (Rank 6) [Classless]
	[9881] = 	92, -- Maul (Rank 7) [Classless]
	[26996] = 	92, -- Maul (Rank 8) [Classless]
	[48479] = 	92, -- Maul (Rank 9) [Classless]
	[48480] = 	92, -- Maul (Rank 10) [Classless]
	[1105221] = 	92, -- Shred (Rank 1) 
	[1106800] = 	92, -- Shred (Rank 2) 
	[1108992] = 	92, -- Shred (Rank 3) 
	[1109829] = 	92, -- Shred (Rank 4) 
	[1109830] = 	92, -- Shred (Rank 5) 
	[1127001] = 	92, -- Shred (Rank 6) 
	[1127002] = 	92, -- Shred (Rank 7) 
	[1148571] = 	92, -- Shred (Rank 8) 
	[1148572] = 	92, -- Shred (Rank 9) 
	[1133876] = 	92, -- Mangle (Cat) (Rank 1) 
	[1133982] = 	92, -- Mangle (Cat) (Rank 2) 
	[1133983] = 	92, -- Mangle (Cat) (Rank 3) 
	[1148565] = 	92, -- Mangle (Cat) (Rank 4) 
	[1148566] = 	92, -- Mangle (Cat) (Rank 5)
	[1101822] = 	92, -- Rake (Rank 1) 
	[1101823] = 	92, -- Rake (Rank 2) 
	[1101824] = 	92, -- Rake (Rank 3) 
	[1109904] = 	92, -- Rake (Rank 4) 
	[1127003] = 	92, -- Rake (Rank 5) 
	[1148573] = 	92, -- Rake (Rank 6) 
	[1148574] = 	92, -- Rake (Rank 7) 
	[1159881] = 	92, -- Rake (Rank 1) 
	[1159882] = 	92, -- Rake (Rank 2) 
	[1159883] = 	92, -- Rake (Rank 3) 
	[1159884] = 	92, -- Rake (Rank 4) 
	[1159885] = 	92, -- Rake (Rank 5) 
	[1159886] = 	92, -- Rake (Rank 6) 
	[1101079] = 	92, -- Rip (Rank 1) 
	[1109492] = 	92, -- Rip (Rank 2) 
	[1109493] = 	92, -- Rip (Rank 3) 
	[1109752] = 	92, -- Rip (Rank 4) 
	[1109894] = 	92, -- Rip (Rank 5) 
	[1109896] = 	92, -- Rip (Rank 6) 
	[1127008] = 	92, -- Rip (Rank 7) 
	[1149799] = 	92, -- Rip (Rank 8) 
	[1149800] = 	92, -- Rip (Rank 9) 
	[1133878] = 	92, -- Mangle (Bear) (Rank 1) 
	[1133986] = 	92, -- Mangle (Bear) (Rank 2) 
	[1133987] = 	92, -- Mangle (Bear) (Rank 3) 
	[1148563] = 	92, -- Mangle (Bear) (Rank 4) 
	[1148564] = 	92, -- Mangle (Bear) (Rank 5) 
	[1133745] = 	92, -- Lacerate (Rank 1) 
	[1148567] = 	92, -- Lacerate (Rank 2) 
	[1148568] = 	92, -- Lacerate (Rank 3) 
	[1106807] = 	92, -- Maul (Rank 1) 
	[1106808] = 	92, -- Maul (Rank 2) 
	[1106809] = 	92, -- Maul (Rank 3) 
	[1108972] = 	92, -- Maul (Rank 4) 
	[1109745] = 	92, -- Maul (Rank 5) 
	[1109880] = 	92, -- Maul (Rank 6) 
	[1109881] = 	92, -- Maul (Rank 7) 
	[1126996] = 	92, -- Maul (Rank 8) 
	[1148479] = 	92, -- Maul (Rank 9) 
	[1148480] = 	92, -- Maul (Rank 10) 

	-- Restoration Druid [93]
	[8936] = 	93, -- Regrowth (Rank 1) [Classless]
	[8938] = 	93, -- Regrowth (Rank 2) [Classless]
	[8939] = 	93, -- Regrowth (Rank 3) [Classless]
	[8940] = 	93, -- Regrowth (Rank 4) [Classless]
	[8941] = 	93, -- Regrowth (Rank 5) [Classless]
	[9750] = 	93, -- Regrowth (Rank 6) [Classless]
	[9856] = 	93, -- Regrowth (Rank 7) [Classless]
	[9857] = 	93, -- Regrowth (Rank 8) [Classless]
	[9858] = 	93, -- Regrowth (Rank 9) [Classless]
	[26980] = 	93, -- Regrowth (Rank 10) [Classless]
	[48442] = 	93, -- Regrowth (Rank 11) [Classless]
	[48443] = 	93, -- Regrowth (Rank 12) [Classless]
	[774] = 	93, -- Rejuvenation (Rank 1) [Classless]
	[1058] = 	93, -- Rejuvenation (Rank 2) [Classless]
	[1430] = 	93, -- Rejuvenation (Rank 3) [Classless]
	[2090] = 	93, -- Rejuvenation (Rank 4) [Classless]
	[2091] = 	93, -- Rejuvenation (Rank 5) [Classless]
	[3627] = 	93, -- Rejuvenation (Rank 6) [Classless]
	[8910] = 	93, -- Rejuvenation (Rank 7) [Classless]
	[9839] = 	93, -- Rejuvenation (Rank 8) [Classless]
	[9840] = 	93, -- Rejuvenation (Rank 9) [Classless]
	[9841] = 	93, -- Rejuvenation (Rank 10) [Classless]
	[25299] = 	93, -- Rejuvenation (Rank 11) [Classless]
	[26981] = 	93, -- Rejuvenation (Rank 12) [Classless]
	[26982] = 	93, -- Rejuvenation (Rank 13) [Classless]
	[48440] = 	93, -- Rejuvenation (Rank 14) [Classless]
	[48441] = 	93, -- Rejuvenation (Rank 15) [Classless]
	[5185] = 	93, -- Healing Touch (Rank 1) [Classless]
	[5186] = 	93, -- Healing Touch (Rank 2) [Classless]
	[5187] = 	93, -- Healing Touch (Rank 3) [Classless]
	[5188] = 	93, -- Healing Touch (Rank 4) [Classless]
	[5189] = 	93, -- Healing Touch (Rank 5) [Classless]
	[6778] = 	93, -- Healing Touch (Rank 6) [Classless]
	[8903] = 	93, -- Healing Touch (Rank 7) [Classless]
	[9758] = 	93, -- Healing Touch (Rank 8) [Classless]
	[9888] = 	93, -- Healing Touch (Rank 9) [Classless]
	[9889] = 	93, -- Healing Touch (Rank 10) [Classless]
	[25297] = 	93, -- Healing Touch (Rank 11) [Classless]
	[26978] = 	93, -- Healing Touch (Rank 12) [Classless]
	[26979] = 	93, -- Healing Touch (Rank 13) [Classless]
	[48377] = 	93, -- Healing Touch (Rank 14) [Classless]
	[48378] = 	93, -- Healing Touch (Rank 15) [Classless]
	[33763] = 	93, -- Lifebloom (Rank 1) [Classless]
	[48450] = 	93, -- Lifebloom (Rank 2) [Classless]
	[48451] = 	93, -- Lifebloom (Rank 3) [Classless]
	[18562] = 	93, -- Swiftmend [Classless]
	[118936] = 	93, -- Regrowth (Rank 1) 
	[118938] = 	93, -- Regrowth (Rank 2) 
	[118939] = 	93, -- Regrowth (Rank 3) 
	[118940] = 	93, -- Regrowth (Rank 4) 
	[118941] = 	93, -- Regrowth (Rank 5) 
	[119750] = 	93, -- Regrowth (Rank 6) 
	[119856] = 	93, -- Regrowth (Rank 7) 
	[119857] = 	93, -- Regrowth (Rank 8) 
	[119858] = 	93, -- Regrowth (Rank 9) 
	[1126980] = 93, -- Regrowth (Rank 10) 
	[1148442] = 93, -- Regrowth (Rank 11) 
	[1148443] = 93, -- Regrowth (Rank 12) 
	[1100774] = 93, -- Rejuvenation (Rank 1) 
	[1101058] = 93, -- Rejuvenation (Rank 2) 
	[1101430] = 93, -- Rejuvenation (Rank 3) 
	[1102090] = 93, -- Rejuvenation (Rank 4) 
	[1102091] = 93, -- Rejuvenation (Rank 5) 
	[1103627] = 93, -- Rejuvenation (Rank 6) 
	[1108910] = 93, -- Rejuvenation (Rank 7) 
	[1109839] = 93, -- Rejuvenation (Rank 8) 
	[1109840] = 93, -- Rejuvenation (Rank 9) 
	[1109841] = 93, -- Rejuvenation (Rank 10) 
	[1125299] = 93, -- Rejuvenation (Rank 11) 
	[1126981] = 93, -- Rejuvenation (Rank 12) 
	[1126982] = 93, -- Rejuvenation (Rank 13) 
	[1148440] = 93, -- Rejuvenation (Rank 14) 
	[1148441] = 93, -- Rejuvenation (Rank 15) 
	[1105185] = 93, -- Healing Touch (Rank 1) 
	[1105186] = 93, -- Healing Touch (Rank 2) 
	[1105187] = 93, -- Healing Touch (Rank 3) 
	[1105188] = 93, -- Healing Touch (Rank 4) 
	[1105189] = 93, -- Healing Touch (Rank 5) 
	[1106778] = 93, -- Healing Touch (Rank 6) 
	[1108903] = 93, -- Healing Touch (Rank 7) 
	[1109758] = 93, -- Healing Touch (Rank 8) 
	[1109888] = 93, -- Healing Touch (Rank 9) 
	[1109889] = 93, -- Healing Touch (Rank 10) 
	[1125297] = 93, -- Healing Touch (Rank 11) 
	[1126978] = 93, -- Healing Touch (Rank 12) 
	[1126979] = 93, -- Healing Touch (Rank 13) 
	[1148377] = 93, -- Healing Touch (Rank 14) 
	[1148378] = 93, -- Healing Touch (Rank 15) 
	[1133763] = 93, -- Lifebloom (Rank 1) 
	[1148450] = 93, -- Lifebloom (Rank 2) 
	[1148451] = 93, -- Lifebloom (Rank 3) 
	[1118562] = 93, -- Swiftmend

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
