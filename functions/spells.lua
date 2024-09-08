do

	local _detalhes = 		_G.Details
	local addonName, Details222 = ...

	local GetSpellInfo = Details222.GetSpellInfo

	--import potion list from the framework
	_detalhes.PotionList = {}
	for spellID, _ in pairs(DetailsFramework.PotionIDs) do
		_detalhes.PotionList [spellID] = true
	end

	_detalhes.SpecSpellList = LIB_OPEN_RAID_SPEC_SPELL_LIST
	_detalhes.ClassSpellList = LIB_OPEN_RAID_CLASS_SPELL_LIST

	_detalhes.SpecIDToClass = {}
	for _, class in ipairs(CLASS_SORT_ORDER) do
		local specs = C_ClassInfo.GetAllSpecs(class)
		for index, spec in ipairs(specs) do
			local specInfo = C_ClassInfo.GetSpecInfo(class, spec)
			_detalhes.SpecIDToClass[specInfo.ID] = class
		end
	end


	-- redirect AbsorbSpells to check IsAbsorbSpell
	_detalhes.AbsorbSpells = setmetatable({}, { __index = function(t,k) local isAbsorb, mask = IsAbsorbSpell(k) return isAbsorb end })

	-- checks if a spell absorbs a specific school
	_detalhes.IsAbsorbSpellSchool = function(spellID, school)
		local isAbsorb, mask = IsAbsorbSpell(spellID)
		return isAbsorb and mask and (mask == 127 or bit.contains(mask, school))
	end

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
