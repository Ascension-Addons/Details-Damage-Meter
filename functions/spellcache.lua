
do
	local Details = 	_G.Details
	local Loc = LibStub("AceLocale-3.0"):GetLocale ( "Details" )
	local addonName, Details222 = ...
	local _
	local rawget = rawget
	local rawset = rawset
	local setmetatable = setmetatable
	local GetSpellInfo = GetSpellInfo
	local unpack = unpack
	local tinsert = table.insert
	local tremove = tremove
	local C_Timer = C_Timer

	--is this a timewalking exp?

	--default spell cache container
	Details.spellcache = {}
	local unknowSpell = {Loc ["STRING_UNKNOWSPELL"], _, "Interface\\Icons\\Ability_Druid_Eclipse"}

	local allSpellNames

	--build a cache with spell names poiting to their icons
	allSpellNames = {}
	local maxSpellId = 90000

	for i = 1, maxSpellId do
		local spellName, _, spellIcon = GetSpellInfo(i)
		if spellName and spellIcon and spellIcon ~= "Interface\\Icons\\trade_engineering" and not allSpellNames[spellName] then
			allSpellNames[spellName] = spellIcon
		end
	end

	local GetSpellInfoClassic = function(spell)
		local spellName, _, spellIcon

		if (spell == 0) then
			spellName = ATTACK or "It's Blizzard Fault!"
			spellIcon = [[Interface\ICONS\INV_Sword_04]]

		elseif (spell == "!Melee" or spell == 1) then
			spellName = ATTACK or "It's Blizzard Fault!"
			spellIcon = [[Interface\ICONS\INV_Sword_04]]

		elseif (spell == "!Autoshot" or spell == 2) then
			spellName = Loc ["STRING_AUTOSHOT"]
			spellIcon = [[Interface\ICONS\INV_Weapon_Bow_07]]

		else
			spellName, _, spellIcon = GetSpellInfo(spell)
		end

		if (not spellName) then
			return spell, _, (allSpellNames[spell] or [[Interface\ICONS\INV_Sword_04]])
		end

		return spellName, _, (allSpellNames[spell] or spellIcon)
	end

	--reset spell cache, called from the loaddata.lua and when the segments container get cleared
	function Details:ClearSpellCache()
		Details.spellcache = setmetatable({},
			{__index = function(spellCache, key)
				if (key) then
					do
						--check if the spell is already in the cache, if so, return it
						local spellInfo = rawget(spellCache, key)
						if (spellInfo) then
							return spellInfo
						end
					end

					local spellInfo
					spellInfo = {GetSpellInfoClassic(key)}

					spellCache[key] = spellInfo
					return spellInfo
				else
					return unknowSpell
				end
			end}
		)

		--built-in overwrites
		for spellId, spellTable in pairs(Details.SpellOverwrite) do
			local spellName, _, spellIcon = GetSpellInfo(spellId)
			rawset(Details.spellcache, spellId, {spellTable.name or spellName, 1, spellTable.icon or spellIcon})
		end

		--user overwrites
		-- [1] spellid [2] spellname [3] spellicon
		for index, spellTable in ipairs(Details.savedCustomSpells) do
			rawset(Details.spellcache, spellTable[1], {spellTable[2], 1, spellTable[3]})
		end
	end

	---@type table<number, customspellinfo>
	local defaultSpellCustomization = {}

	---@type table<number, customiteminfo>
	local customItemList = {}

	local iconSize = 14
	local coords = {0.14, 0.86, 0.14, 0.86}

	---@param itemId number
	---@return string
	local formatTextForItem = function(itemId)
		local result = ""

		local itemIcon = GetItemIconInstant(itemId)
		local itemName = GetItemName(itemId)

		if (itemIcon and itemName) then
			--limit the amount of characters of the item name
			if (GetLocale() == "zhCN" or GetLocale() == "zhTW" or GetLocale() == "koKR") then
				if (#itemName > 56) then
					itemName = string.sub(itemName, 1, 56)
				end
			else
				if (#itemName > 20) then
					itemName = string.sub(itemName, 1, 20)
				end
			end
			result = "" .. CreateTextureMarkup(itemIcon, iconSize, iconSize, iconSize, iconSize, unpack(coords)) .. " " .. itemName .. ""
		end

		return result
	end

	defaultSpellCustomization = {
		[1] = {name = _G["MELEE"], icon = [[Interface\ICONS\INV_Sword_04]]},
		[2] = {name = Loc ["STRING_AUTOSHOT"], icon = [[Interface\ICONS\INV_Weapon_Bow_07]]},
		[3] = {name = Loc ["STRING_ENVIRONMENTAL_FALLING"], icon = [[Interface\ICONS\Spell_Magic_FeatherFall]]},
		[4] = {name = Loc ["STRING_ENVIRONMENTAL_DROWNING"], icon = [[Interface\ICONS\Ability_Suffocate]]},
		[5] = {name = Loc ["STRING_ENVIRONMENTAL_FATIGUE"], icon = [[Interface\ICONS\Spell_Arcane_MindMastery]]},
		[6] = {name = Loc ["STRING_ENVIRONMENTAL_FIRE"], icon = [[Interface\ICONS\INV_SummerFest_FireSpirit]]},
		[7] = {name = Loc ["STRING_ENVIRONMENTAL_LAVA"], icon = [[Interface\ICONS\Ability_Rhyolith_Volcano]]},
		[8] = {name = Loc ["STRING_ENVIRONMENTAL_SLIME"], icon = [[Interface\ICONS\Ability_Creature_Poison_02]]},
	}

	if (LIB_OPEN_RAID_SPELL_CUSTOM_NAMES) then
		for spellId, customTable in pairs(LIB_OPEN_RAID_SPELL_CUSTOM_NAMES) do
			local customName = customTable.name
			if (customName) then
				defaultSpellCustomization[spellId] = customName
			end
		end
	end

	function Details:GetDefaultCustomSpellsList()
		return defaultSpellCustomization
	end

	function Details:GetDefaultCustomItemList()
		return customItemList
	end

	function Details:UserCustomSpellUpdate(index, spellName, spellIcon) --called from the options panel > rename spells
		---@type savedspelldata
		local savedSpellData = Details.savedCustomSpells[index]
		if (savedSpellData) then
			local spellId = savedSpellData[1]
			savedSpellData[2], savedSpellData[3] = spellName or savedSpellData[2], spellIcon or savedSpellData[3]
			rawset(Details.spellcache, spellId, {savedSpellData[2], 1, savedSpellData[3]})
			Details.userCustomSpells[spellId] = true
			return true
		else
			return false
		end
	end

	function Details:UserCustomSpellReset(index)
		---@type savedspelldata
		local savedSpellData = Details.savedCustomSpells[index]
		if (savedSpellData) then
			local spellId = savedSpellData [1]
			local spellName, _, spellIcon = GetSpellInfo(spellId)

			if (defaultSpellCustomization[spellId]) then
				spellName = defaultSpellCustomization[spellId].name
				spellIcon = defaultSpellCustomization[spellId].icon or spellIcon or [[Interface\InventoryItems\WoWUnknownItem01]]
			end

			if (not spellName) then
				spellName = "Unknown"
			end
			if (not spellIcon) then
				spellIcon = [[Interface\InventoryItems\WoWUnknownItem01]]
			end

			rawset(Details.spellcache, spellId, {spellName, 1, spellIcon})

			savedSpellData[2] = spellName
			savedSpellData[3] = spellIcon
		end
	end

	function Details:FillUserCustomSpells()
		for spellId, spellTable in pairs(defaultSpellCustomization) do
			local spellName, _, spellIcon = Details.GetSpellInfo(spellId)
			Details:UserCustomSpellAdd(spellId, spellTable.name or spellName or "Unknown", spellTable.icon or spellIcon or [[Interface\InventoryItems\WoWUnknownItem01]])
		end

		--itens
		--[381760] = {name = formatTextForItem(193786), isPassive = true, itemId = 193786, nameExtra = ""|nil},
		---@type number, customiteminfo
		for spellId, itemInfo in pairs(customItemList) do
			local bIsPassive = itemInfo.isPassive
			local itemId = itemInfo.itemId
			local nameExtra = itemInfo.nameExtra
			local spellName, _, spellIcon = GetSpellInfo(spellId)

			spellIcon = itemInfo.icon or spellIcon or [[Interface\InventoryItems\WoWUnknownItem01]]

			local itemName = formatTextForItem(itemId)
			if (itemName ~= "") then
				if (nameExtra) then
					itemName = itemName .. " " .. nameExtra
				end
				Details:UserCustomSpellAdd(spellId, itemName, spellIcon or [[Interface\InventoryItems\WoWUnknownItem01]])
			else
				if (not Details.UpdateIconsTimer or Details.UpdateIconsTimer:IsCancelled()) then
					Details.UpdateIconsTimer = C_Timer.NewTimer(3, Details.FillUserCustomSpells)
				end
			end
		end

		for i = #Details.savedCustomSpells, 1, -1 do
			---@type savedspelldata
			local savedSpellData = Details.savedCustomSpells[i]
			local spellId = savedSpellData[1]
			if (spellId > 10) then
				local doesSpellExists = GetSpellInfo(spellId)
				if (not doesSpellExists) then
					tremove(Details.savedCustomSpells, i)
				end
			end
		end
	end

	function Details:UserCustomSpellAdd(spellId, spellName, spellIcon, bAddedByUser)
		if (Details.userCustomSpells[spellId]) then
			if (not bAddedByUser) then
				return
			end
		end

		local isOverwrite = false
		for index, savedSpellData in ipairs(Details.savedCustomSpells) do
			if (savedSpellData[1] == spellId) then
				savedSpellData[2] = spellName
				savedSpellData[3] = spellIcon
				isOverwrite = true
				break
			end
		end

		if (not isOverwrite) then
			tinsert(Details.savedCustomSpells, {spellId, spellName, spellIcon})
		end

		rawset(Details.spellcache, spellId, {spellName, 1, spellIcon})

		if (bAddedByUser) then
			Details.userCustomSpells[spellId] = true
		end
	end

	function Details:UserCustomSpellRemove(index)
		---@type savedspelldata
		local savedSpellData = Details.savedCustomSpells[index]
		if (savedSpellData) then
			local spellId = savedSpellData[1]
			local spellName, _, spellIcon = GetSpellInfo(spellId)
			if (spellName) then
				rawset(Details.spellcache, spellId, {spellName, 1, spellIcon})
			end
			return tremove(Details.savedCustomSpells, index)
		end

		return false
	end

	--overwrite for API GetSpellInfo function
	Details.getspellinfo = function(spellId)
		return unpack(Details.spellcache[spellId]) --won't be nil due to the __index metatable in the spellcache table
	end
	Details.GetSpellInfo = Details.getspellinfo

	function Details.GetCustomSpellInfo(spellId)
		local spellName, _, spellIcon = Details.GetSpellInfo(spellId)

		local customInfo = defaultSpellCustomization[spellId]
		if (customInfo) then
			local defaultName, bCanStack = customInfo.defaultName, customInfo.breakdownCanStack
			return spellName, _, spellIcon, defaultName, bCanStack
		end

		return spellName, _, spellIcon
	end

	function Details.GetItemSpellInfo(spellId)
		local spellInfo = customItemList[spellId]
		if (spellInfo) then
			local defaultSpellName, castSpellId, itemId, bIsPassive, bOnUse, nameExtra = spellInfo.defaultName, spellInfo.castId, spellInfo.itemId, spellInfo.onUse, spellInfo.isPassive, spellInfo.nameExtra
			return defaultSpellName, castSpellId, itemId, bIsPassive, bOnUse, nameExtra
		end
	end

	--overwrite SpellInfo if the spell is a DoT, so Details.GetSpellInfo will return the name modified
	function Details:SetAsDotSpell(spellId)
		--do nothing if this spell already has a customization
		if (defaultSpellCustomization[spellId]) then
			return
		end

		--do nothing if the spell is already cached
		local spellInfo = rawget(Details.spellcache, spellId)
		if (spellInfo) then
			return
		end

		local spellName, rank, spellIcon = Details.GetSpellInfo(spellId)
		if (not spellName) then
			spellName, rank, spellIcon = GetSpellInfo(spellId)
		end

		if (spellName) then
			rawset(Details.spellcache, spellId, {spellName .. Loc ["STRING_DOT"], rank, spellIcon})
		else
			rawset(Details.spellcache, spellId, {"Unknown DoT Spell? " .. Loc ["STRING_DOT"], rank, [[Interface\InventoryItems\WoWUnknownItem01]]})
		end
	end
end