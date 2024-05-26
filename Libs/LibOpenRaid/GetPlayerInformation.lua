--[=[
    This file has the functions to get player information
    Dumping them here, make the code of the main file smaller
--]=]



if (not LIB_OPEN_RAID_CAN_LOAD) then
	return
end

local openRaidLib = LibStub:GetLibrary("LibOpenRaid-1.0")

local CONST_ISITEM_BY_TYPEID = {
    [10] = true, --healing items
    [11] = true, --attack items
    [12] = true, --utility items
}

local GetInventoryItemLink = GetInventoryItemLink

--information about the player character to send, each expansion has its own system and data can be different
--it's always a number
function openRaidLib.UnitInfoManager.GetPlayerInfo1()
    return 0
end

--information about the player character to send, each expansion has its own system and data can be different
--it's always a number
function openRaidLib.UnitInfoManager.GetPlayerInfo2()
    return 0
end

--creates two tables, one with indexed talents and another with pairs values ([talentId] = true)
function openRaidLib.UnitInfoManager.GetPlayerTalentsAsPairsTable()
    local talentsPairs = {}
    return talentsPairs
end

function openRaidLib.UnitInfoManager.GetPlayerTalents()
    local talents = {}
    return talents
end

function openRaidLib.UnitInfoManager.GetPlayerPvPTalents()
    -- todo: coa will use these eventually
    return {}

    -- expected format
    -- local talentsPvP = {0, 0, 0}
    -- talentsPvP[index] = talentID
end

function openRaidLib.UnitInfoManager.GetPlayerLegendaryEnchant()
    return IsHeroClass("player") and MysticEnchantUtil.GetLegendaryEnchantID("player") or 0
end

--return the current specId of the player
function openRaidLib.GetPlayerSpecId()
    return GetSpecialization() or 1
end

function openRaidLib.GearManager.GetPlayerItemLevel()
    local itemLevel = UnitAverageItemLevel("player")
    return floor(itemLevel)
end

--return an integer between zero and one hundret indicating the player gear durability
function openRaidLib.GearManager.GetPlayerGearDurability()
    local durabilityTotalPercent, totalItems = 0, 0
    --hold the lowest item durability of all the player gear
    --this prevent the case where the player has an average of 80% durability but an item with 15% durability
    local lowestGearDurability = 100

    for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
        local durability, maxDurability = GetInventoryItemDurability(i)
        if (durability and maxDurability) then
            local itemDurability = durability / maxDurability * 100

            if (itemDurability < lowestGearDurability) then
                lowestGearDurability = itemDurability
            end

            durabilityTotalPercent = durabilityTotalPercent + itemDurability
            totalItems = totalItems + 1
        end
    end

    if (totalItems == 0) then
        return 100, lowestGearDurability
    end

    return floor(durabilityTotalPercent / totalItems), lowestGearDurability
end

function openRaidLib.GearManager.GetPlayerWeaponEnchant()
    if not GetWeaponTempEnchantInfo then
        return 0, 0, 0
    end
    local weaponEnchant = 0
    local _, mainHandEnchantId = GetWeaponTempEnchantInfo(INVSLOT_MAINHAND)
    local _, offHandEnchantId = GetWeaponTempEnchantInfo(INVSLOT_OFFHAND)
    if (mainHandEnchantId and LIB_OPEN_RAID_WEAPON_ENCHANT_IDS[mainHandEnchantId]) then
        weaponEnchant = 1

    elseif( offHandEnchantId and LIB_OPEN_RAID_WEAPON_ENCHANT_IDS[offHandEnchantId]) then
        weaponEnchant = 1
    end
    return weaponEnchant, mainHandEnchantId or 0, offHandEnchantId or 0
end

function openRaidLib.GearManager.GetPlayerRangedWeaponEnchant()
    if not GetWeaponTempEnchantInfo then
        return 0, 0
    end
    local weaponEnchant = 0
    local _, rangedEnchantId = GetWeaponTempEnchantInfo(INVSLOT_RANGED)
    if (rangedEnchantId and LIB_OPEN_RAID_WEAPON_ENCHANT_IDS[rangedEnchantId]) then
        weaponEnchant = 1
    end
    return weaponEnchant, rangedEnchantId or 0
end

function openRaidLib.GearManager.GetPlayerGemsAndEnchantInfo()
    --hold equipmentSlotId of equipment with a gem socket but it's empty
    local slotsWithoutGems = {}
    --hold equipmentSlotId of equipments without an enchant
    local slotsWithoutEnchant = {}

    local gearWithEnchantIds = {}

    for equipmentSlotId = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
        local itemLink = GetInventoryItemLink("player", equipmentSlotId)
        if (itemLink) then
            --get the information from the item
            local _, itemId, enchantId, gemId1, gemId2, gemId3, gemId4 = strsplit(":", itemLink)
            local gemsIds = {gemId1, gemId2, gemId3, gemId4}

            --enchant
            --check if the slot can receive enchat and if the equipment has an enchant
            local enchantAttribute = LIB_OPEN_RAID_ENCHANT_SLOTS[equipmentSlotId]
            local nEnchantId = 0

            if (enchantAttribute) then --this slot can receive an enchant
                if (enchantId and enchantId ~= "") then
                    local number = tonumber(enchantId)
                    nEnchantId = number
                    gearWithEnchantIds[#gearWithEnchantIds+1] = nEnchantId
                else
                    gearWithEnchantIds[#gearWithEnchantIds+1] = 0
                    slotsWithoutEnchant[#slotsWithoutEnchant+1] = equipmentSlotId
                end
            end

            --gems
            --local itemStatsTable = {}
            --fill the table above with information about the item
            --GetItemStats(itemLink, itemStatsTable)
            local itemStatsTable = GetItemStats(itemLink)

            --check if the item has a socket
            if (itemStatsTable) then
                local numSockets = (itemStatsTable.EMPTY_SOCKET_RED or 0) + (itemStatsTable.EMPTY_SOCKET_YELLOW or 0) + (itemStatsTable.EMPTY_SOCKET_BLUE or 0)
                if numSockets > 0 then
                    --check if the socket is empty
                    for i = 1, numSockets do
                        local gemId = tonumber(gemsIds[i])
                        if (not gemId or gemId == 0) then
                            slotsWithoutGems[#slotsWithoutGems+1] = equipmentSlotId
                        end
                    end
                end
            end
        end
    end

    return slotsWithoutGems, slotsWithoutEnchant
end

function openRaidLib.GearManager.BuildPlayerEquipmentList()
    local equipmentList = {}
    local debug
    for equipmentSlotId = 1, 17 do
        local itemLink = GetInventoryItemLink("player", equipmentSlotId)
        if (itemLink) then
            --local itemStatsTable = {}
            local itemID = select(2, strsplit(":", itemLink))
            itemID = tonumber(itemID)

            local _, _, _, effectiveILvl = GetItemInfo(itemID)
            if (not effectiveILvl) then
                openRaidLib.mainControl.scheduleUpdatePlayerData()
                effectiveILvl = 0
                openRaidLib.__errors[#openRaidLib.__errors+1] = "Fail to get Item Level: " .. (itemID or "invalid itemID") .. " " .. (itemLink and itemLink:gsub("|H", "") or "invalid itemLink")
            end

            local itemStatsTable = GetItemStats(itemLink)
            --GetItemStats(itemLink, itemStatsTable)
            local gemSlotsAvailable = itemStatsTable and (itemStatsTable.EMPTY_SOCKET_RED or 0) + (itemStatsTable.EMPTY_SOCKET_YELLOW or 0) + (itemStatsTable.EMPTY_SOCKET_BLUE or 0)

            local noPrefixItemLink = itemLink : gsub("^|c%x%x%x%x%x%x%x%x|Hitem", "")
            local linkTable = {strsplit(":", noPrefixItemLink)}
            local numModifiers = linkTable[14]
            numModifiers = numModifiers and tonumber(numModifiers) or 0

            for i = #linkTable, 14 + numModifiers + 1, -1 do
                tremove(linkTable, i)
            end

            local newItemLink = table.concat(linkTable, ":")
            newItemLink = newItemLink
            equipmentList[#equipmentList+1] = {equipmentSlotId, gemSlotsAvailable, effectiveILvl, newItemLink}

            if (equipmentSlotId == 2) then
                debug = {itemLink:gsub("|H", ""), newItemLink}
            end
        end
    end

    --[[ debug
    local str = ""
    for i = 1, #equipmentList do
        local t = equipmentList[i]
        local s = t[1] .. "," .. t[2] .. "," .. t[3] .. "," .. t[4]
        str = str .. s
    end

    table.insert(debug, str)
    dumpt(debug)
    --]]

    return equipmentList
end

local playerHasPetOfNpcId = function(npcId)
   return false -- 3.3.5 cant get if a pet GUID is a specific npc or not.
end

local addCooldownToTable = function(cooldowns, cooldownsHash, cooldownSpellId, timeNow)
    local timeLeft, charges, startTimeOffset, duration, auraDuration = openRaidLib.CooldownManager.GetPlayerCooldownStatus(cooldownSpellId)

    cooldowns[#cooldowns+1] = cooldownSpellId
    cooldowns[#cooldowns+1] = timeLeft
    cooldowns[#cooldowns+1] = charges
    cooldowns[#cooldowns+1] = startTimeOffset
    cooldowns[#cooldowns+1] = duration
    cooldowns[#cooldowns+1] = auraDuration

    cooldownsHash[cooldownSpellId] = {timeLeft, charges, startTimeOffset, duration, timeNow, auraDuration}
end

local canAddCooldown = function(cooldownInfo)
    local petNpcIdNeeded = cooldownInfo.pet
    if (petNpcIdNeeded) then
        if (not playerHasPetOfNpcId(petNpcIdNeeded)) then
            return false
        end
    end
    return true
end

local getSpellListAsHashTableFromSpellBook = function()
    local completeListOfSpells = {}

    -- find spells in spellbook
    for tab = 2, GetNumSpellTabs() do
        local name, _, offset, numSpells = GetSpellTabInfo(tab)

        if name and name ~= "Internal" and name ~= "Ascension Vanity Items" then
            for i = offset + 1, offset + numSpells do
                local spellName, rank = GetSpellInfo(i, BOOKTYPE_SPELL)

                if spellName then
                    local link = GetSpellLink(spellName, rank)
                    if link then
                        local spellID = tonumber(link:match("spell:(%d*)"))
                        if spellID and not IsPassiveSpellID(spellID) then
                            if LIB_OPEN_RAID_MULTI_OVERRIDE_SPELLS and LIB_OPEN_RAID_MULTI_OVERRIDE_SPELLS[spellID] then
                                for _, overrideSpellID in pairs(LIB_OPEN_RAID_MULTI_OVERRIDE_SPELLS[spellID]) do
                                    completeListOfSpells[overrideSpellID] = true
                                end
                            else
                                completeListOfSpells[spellID] = true
                            end
                        end
                    end
                end
            end
        end
    end
    --get pet spells from the pet spellbook 
    local numPetSpells = HasPetSpells()
    if (numPetSpells) then
        for i = 1, numPetSpells do
            local spellName, rank, unmaskedSpellId = GetSpellInfo(i, "pet")
            if spellName then
                local link = GetSpellLink(spellName, rank)
                if link then
                    local spellID = tonumber(link:match("spell:(%d*)"))
                    if spellID and not IsPassiveSpellID(spellID) then
                        if LIB_OPEN_RAID_MULTI_OVERRIDE_SPELLS and LIB_OPEN_RAID_MULTI_OVERRIDE_SPELLS[spellID] then
                            for _, overrideSpellID in pairs(LIB_OPEN_RAID_MULTI_OVERRIDE_SPELLS[spellID]) do
                                completeListOfSpells[overrideSpellID] = true
                            end
                        else
                            completeListOfSpells[spellID] = true
                        end
                    end
                end
            end
        end
    end

    return completeListOfSpells
end

local updateCooldownAvailableList = function()
    table.wipe(LIB_OPEN_RAID_PLAYERCOOLDOWNS)
    local _, playerClass = UnitClass("player")
    local locPlayerRace, playerRace, playerRaceId = UnitRace("player")
    local spellBookSpellList = getSpellListAsHashTableFromSpellBook()

    --build a list of all spells assigned as cooldowns for the player class
    for spellID, spellData in pairs(LIB_OPEN_RAID_COOLDOWNS_INFO) do
        --type 10 is an item cooldown and does not have a class or race id

        local passRaceId = false
        local raceId = spellData.raceid
        if (raceId) then
            if (type(raceId) == "table") then
                if (raceId[playerRaceId]) then
                    passRaceId = true
                end
            elseif (type(raceId) == "number") then
                if (raceId == playerRaceId) then
                    passRaceId = true
                end
            end
        end

        if (spellData.class == playerClass or passRaceId or CONST_ISITEM_BY_TYPEID[spellData.type]) then --need to implement here to get the racial as racial cooldowns does not carry a class
            --type 10 is an item cooldown and does not have a spellbook entry
            if (spellBookSpellList[spellID] or CONST_ISITEM_BY_TYPEID[spellData.type]) then
                LIB_OPEN_RAID_PLAYERCOOLDOWNS[spellID] = spellData
            end
        end
    end
end

--build a list with the local player cooldowns
--called only from SendAllPlayerCooldowns()
function openRaidLib.CooldownManager.GetPlayerCooldownList()
    --this fill the global LIB_OPEN_RAID_PLAYERCOOLDOWNS
    updateCooldownAvailableList()
    --get the player specId
    local specId = openRaidLib.GetPlayerSpecId()
    if (specId) then
        --get the cooldowns for the specializationid
        local playerCooldowns = LIB_OPEN_RAID_PLAYERCOOLDOWNS
        if (not playerCooldowns) then
            openRaidLib.DiagnosticError("CooldownManager|GetPlayerCooldownList|LIB_OPEN_RAID_PLAYERCOOLDOWNS is nil")
            return {}, {}
        end
        local cooldowns = {} --table to ship on comm
        local cooldownsHash = {} --table with [spellId] = cooldownInfo
        local talentsHash = openRaidLib.UnitInfoManager.GetPlayerTalentsAsPairsTable()
        local timeNow = GetTime()
        for cooldownSpellId, cooldownInfo in pairs(playerCooldowns) do
            --does this cooldown is based on a talent?
            local talentId = cooldownInfo.talent
            --check if the player has a talent which makes this cooldown unavailable
            local ignoredByTalentId = cooldownInfo.ignoredIfTalent
            local bIsIgnoredByTalentId = false
            if (ignoredByTalentId) then
                if (talentsHash[ignoredByTalentId]) then
                    bIsIgnoredByTalentId = true
                end
            end
            if (not bIsIgnoredByTalentId) then
                if (talentId) then
                    --check if the player has the talent selected
                    if (talentsHash[talentId]) then
                        if (canAddCooldown(cooldownInfo)) then
                            addCooldownToTable(cooldowns, cooldownsHash, cooldownSpellId, timeNow)
                        end
                    end
                else
                    if (canAddCooldown(cooldownInfo)) then
                        addCooldownToTable(cooldowns, cooldownsHash, cooldownSpellId, timeNow)
                    end
                end
            end
        end
        return cooldowns, cooldownsHash
    else
        return {}, {}
    end
end

---check if a player cooldown is ready or if is in cooldown
---@spellId: the spellId to check for cooldown
---@return number timeLeft
---@return number charges
---@return number startTimeOffset
---@return number duration
---@return number buffDuration
function openRaidLib.CooldownManager.GetPlayerCooldownStatus(spellId)
    --check if is a charge spell
    local spellData = LIB_OPEN_RAID_COOLDOWNS_INFO[spellId]
    if (spellData) then
        local chargesAvailable, chargesTotal, start, duration = GetSpellCharges(spellId)
        if chargesAvailable then
            if (chargesAvailable == chargesTotal) then
                return 0, chargesTotal, 0, 0, 0 --all charges are ready to use
            else
                --return the time to the next charge
                local timeLeft = start + duration - GetTime()
                local startTimeOffset = start - GetTime()
                return ceil(timeLeft), chargesAvailable, startTimeOffset, duration
            end
        else
            local start, duration = GetSpellCooldown(spellId)
            if (start == 0) then --cooldown is ready
                return 0, 1, 0, 0, 0 --time left, charges, startTime
            else
                local timeLeft = start + duration - GetTime()
                local startTimeOffset = start - GetTime()
                return ceil(timeLeft), 0, ceil(startTimeOffset), duration --time left, charges, startTime, duration
            end
        end
    else
        return openRaidLib.DiagnosticError("CooldownManager|GetPlayerCooldownStatus()|cooldownInfo not found|", spellId)
    end
end


do
    openRaidLib.AuraTracker = {}

	local getUnitName = function(unitId)
		local unitName, realmName = UnitName(unitId)
		if (unitName) then
			if (realmName and realmName ~= "") then
				unitName = unitName .. "-" .. realmName
			end
			return unitName
		end
	end

    local predicateFunc = function(spellIdToFind, casterName, _, name, rank, icon, applications, dispelName, duration, expirationTime, sourceUnitId, isStealable, spellId)
		if (spellIdToFind == spellId and UnitExists(sourceUnitId)) then
			if (casterName == getUnitName(sourceUnitId)) then
				return true
			end
		end
	end

    ---find the duration of a debuff by passing the spellId and the caster name
    ---@param unitId unit
    ---@param spellId spellid
    ---@param casterName actorname
    ---@return auraduration|nil auraDuration
    ---@return number|nil expirationTime
    function openRaidLib.AuraTracker.FindBuffDuration(unitId, casterName, spellId)
        local name, rank, icon, count, buffType, duration, expirationTime = AuraUtil.FindAura(predicateFunc, unitId, "HELPFUL", spellId, casterName)
        if (name) then
            return duration, expirationTime
        end
    end

    ---find the duration of a buff placed by a unit
    ---@param targetString string
    ---@param casterString string
    ---@param spellId number
    function openRaidLib.AuraTracker.FindBuffDurationByUnitName(targetString, casterString, spellId)
        local targetName = Ambiguate(targetString, "none")
        local casterName = Ambiguate(casterString, "none")
        return openRaidLib.AuraTracker.FindBuffDuration(targetName, casterName, spellId)
    end
end

openRaidLib.specAttribute = {}
for _, class in ipairs(CLASS_SORT_ORDER) do
    local specs = C_ClassInfo.GetAllSpecs(class)
    openRaidLib.specAttribute[class] = {}
    for index, spec in ipairs(specs) do
        local specInfo = C_ClassInfo.GetSpecInfo(class, spec)
        openRaidLib.specAttribute[class][specInfo.ID] = Enum.PrimaryStat[specInfo.PrimaryStats[1] or "Strength"]
    end
end