
local DF = _G ["DetailsFramework"]
if (not DF or not DetailsFrameworkCanLoad) then
	return 
end

DF_COOLDOWN_RAID = 4
DF_COOLDOWN_EXTERNAL = 3

DF.CooldownsInfo = LIB_OPEN_RAID_COOLDOWNS_INFO
DF.CooldownsBySpec = {}
for spellID, info in pairs(LIB_OPEN_RAID_COOLDOWNS_INFO) do
	for _, specID in ipairs(info.specs) do
		if not DF.CooldownsBySpec[specID] then
			DF.CooldownsBySpec[specID] = {}
		end
		DF.CooldownsBySpec[specID][spellID] = info.type
	end
end

-- {cooldown = , duration = , talent = false, charges = 1}
DF.CrowdControlSpells = {}


DF.MageFireWardSpells = {
	[543] = 30 , -- Fire Ward (Mage) Rank 1
	[8457] = 30,
	[8458] = 30,
	[10223] = 30,
	[10225] = 30,
	[27128] = 30,
	[43010] = 30, -- Rank 7
}

DF.MageFrostWardSpells = {
	[6143] = 30, -- Frost Ward (Mage) Rank 1
	[8461] = 30,
	[8462] = 30,
	[10177] = 30,
	[28609] = 30,
	[32796] = 30,
	[43012] = 30, -- Rank 7
}

DF.WarlockShadowWardSpells = {
	[6229] = 30, -- Shadow Ward (warlock) Rank 1
	[11739] = 30,
	[11740] = 30,
	[28610] = 30,
	[47890] = 30,
	[47891] = 30, -- Rank 6
}

DF.MageIceBarrierSpells = {
	[11426] = 60, -- Ice Barrier (Mage) Rank 1
	[13031] = 60,
	[13032] = 60,
	[13033] = 60,
	[27134] = 60,
	[33405] = 60,
	[43038] = 60,
	[43039] = 60, -- Rank 8
}

DF.WarlockSacrificeSpells = {
	[7812] = 30, -- Sacrifice (warlock) Rank 1
	[19438] = 30,
	[19440] = 30,
	[19441] = 30,
	[19442] = 30,
	[19443] = 30,
	[27273] = 30,
	[47985] = 30,
	[47986] = 30, -- rank 9
}

DF.SpecIds = {}
DF.ClassSpecIds = {}

for _, class in ipairs(CLASS_SORT_ORDER) do
    local specs = C_ClassInfo.GetAllSpecs(class)
	DF.ClassSpecIds[class] = {}
    for _, spec in ipairs(specs) do
        local specInfo = C_ClassInfo.GetSpecInfo(class, spec)
		DF.SpecIds[specInfo.ID] = class
		DF.ClassSpecIds[specInfo.ID] = true
    end
end

DF.CooldownToClass = {}

DF.CooldownsAttack = {}
DF.CooldownsDeffense = {}
DF.CooldownsExternals = {}
DF.CooldownsRaid = {}

DF.CooldownsAllDeffensive = {}

for specId, cooldownTable in pairs(DF.CooldownsBySpec) do
	
	for spellId, cooldownType in pairs(cooldownTable) do
		
		if (cooldownType == 1) then
			DF.CooldownsAttack [spellId] = true
			
		elseif (cooldownType == 2) then
			DF.CooldownsDeffense [spellId] = true
			DF.CooldownsAllDeffensive [spellId] = true
			
		elseif (cooldownType == 3) then
			DF.CooldownsExternals [spellId] = true
			DF.CooldownsAllDeffensive [spellId] = true
			
		elseif (cooldownType == 4) then
			DF.CooldownsRaid [spellId] = true
			DF.CooldownsAllDeffensive [spellId] = true
			
		elseif (cooldownType == 5) then
			
			
		end
		
		DF.CooldownToClass [spellId] = DF.SpecIds [specId]
	end
end

function DF:FindClassForCooldown (spellId)
	for specId, cooldownTable in pairs(DF.CooldownsBySpec) do
		local hasCooldown = cooldownTable [spellId]
		if (hasCooldown) then
			return DF.SpecIds [specId]
		end
	end
end

function DF:GetCooldownInfo (spellId)
	return DF.CooldownsInfo [spellId]
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--consumables
DF.WeaponEnchantIds = {
	[5400] = true, --flametongue
	[5401] = true, --windfury
}
DF.FlaskIDs = {
	[46377] = true, -- Flask of Endless Rage
	[46376] = true, -- Flask of the Frost Wyrm
	[54213] = true, -- Flask of Pure Mojo
	[46379] = true, -- Flask of Stoneblood
	[53899] = true, -- Lesser Flask of Toughness
}
DF.FoodIDs = {
	[57367] = true, --(Agi +40, Stam +40) Blackended Dragonfin
	[57294] = true, --(AP +60, SP +35, Stam +30) Dalaran Clam Chowder / Great Feast
	[57365] = true, --(Spirit +40, Stam +40) Cuttlesteak
	[57360] = true, --(Hit+40, Stam +40) Worg Tartare / Snapper Extreme
	[57358] = true, --(ArmorPen +40, Stam +40) Hearty Rhino
	[57356] = true, --(Expertise +40, Stam +40) Rhinolicious Wormsteak
	[57334] = true, --(Mana per 5s +20, Stam +40) Spicy Fried Herring / Mighty Rhino Dogs
	[57332] = true, --(Haste +40, Stam +40) Imperial Manta Steak / Very Burnt Worg
	[57329] = true, --(Crit +40, Stam +40) Spicy Blue Nettlefish / Spicy Worm Burger
	[57327] = true, --(SP +46, Stam +40) Firecracker Salmon / Tender Shoveltusk Steak
	[57325] = true, --(AP +80, Stam +40) Poached Northern Sculpin / Mega Mammoth Head
	[57291] = true, --(Mana per 5s +15, Stam +30) Rhino Dogs / Pickled Fangtooth
	[57288] = true, --(Haste +30, Stam +30) Baked Manta Ray / Roasted Worg
	[57286] = true, --(Crit +30, Stam +30) Poached Nettlefish / Worm Delight
	[57139] = true, --(SP +35, Stam +30) Smoked Salmon / Shoveltusk Steak
	[57111] = true, --(AP +60, Stam +30) Grilled Sculpin / Mammoth Meal
}

DF.PotionIDs = {
	[53762] = true, --Indestructable Potion
	[53908] = true, --Potion of Speed
	[53909] = true, --Potion of Wild Magic
	[53753] = true, --Potion of Nightmares
	[43185] = true, -- Runic Healing Potion
	[67489] = true, -- Runic Healing Injector
	[53761] = true, -- Powerful Rejuvenation Potion
	[53750] = true, -- Crazy Alchemist's Potion
	[43186] = true, -- Runic Mana Potion
	[67490] = true, -- Runic Mana Injector
}
DF.FeastIDs = {}
DF.RuneIDs = {}

--	/dump UnitAura ("player", 1)
--	/dump UnitAura ("player", 2)

function DF:GetSpellsForEncounterFromJournal (instanceEJID, encounterEJID)

	DetailsFramework.EncounterJournal.EJ_SelectInstance (instanceEJID) 
	local name, description, encounterID, rootSectionID, link = DetailsFramework.EncounterJournal.EJ_GetEncounterInfo (encounterEJID) --taloc (primeiro boss de Uldir)
	
	if (not name) then
		print("DetailsFramework: Encounter Info Not Found!", instanceEJID, encounterEJID)
		return {}
	end
	
	local spellIDs = {}
	
	--overview
	local sectionInfo = C_EncounterJournal.GetSectionInfo (rootSectionID)
	local nextID = {sectionInfo.siblingSectionID}
	
	while (nextID [1]) do
		--get the deepest section in the hierarchy
		local ID = tremove(nextID)
		local sectionInfo = C_EncounterJournal.GetSectionInfo (ID)
		
		if (sectionInfo) then
			if (sectionInfo.spellID and type(sectionInfo.spellID) == "number" and sectionInfo.spellID ~= 0) then
				tinsert(spellIDs, sectionInfo.spellID)
			end
			
			local nextChild, nextSibling = sectionInfo.firstChildSectionID, sectionInfo.siblingSectionID
			if (nextSibling) then
				tinsert(nextID, nextSibling)
			end
			if (nextChild) then
				tinsert(nextID, nextChild)
			end
		else
			break
		end
	end
	
	return spellIDs
end

--default spells to use in the range check
-- [specID] = spellID
DF.SpellRangeCheckListBySpec = {}
