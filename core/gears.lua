
local Details = 		_G.Details
local addonName, Details222 = ...
local Loc = LibStub("AceLocale-3.0"):GetLocale( "Details" )
local _

local UnitGUID = UnitGUID
local UnitGroupRolesAssigned = DetailsFramework.UnitGroupRolesAssigned
local GetNumGroupMembers = GetNumGroupMembers
local GetSpellInfo = Details222.GetSpellInfo
local select = select
local floor = floor

local CONST_INSPECT_ACHIEVEMENT_DISTANCE = 1 --Compare Achievements, 28 yards
local CONST_SPELLBOOK_GENERAL_TABID = 1
local CONST_SPELLBOOK_CLASSSPELLS_TABID = 2

local storageDebug = false --remember to turn this to false!

function Details:UpdateGears()
	Details:UpdateParser()
	Details:UpdateControl()
	Details:UpdateCombat()
end

---@alias raid_difficulty_eng_name_lowercase "normal" | "heroic" | "mythic" | "ascended"

------------------------------------------------------------------------------------------------------------
--chat hooks

	Details.chat_embed = Details:CreateEventListener()
	Details.chat_embed.startup = true

	Details.chat_embed.hook_settabname = function(frame, name, doNotSave)
		if (not doNotSave) then
			if (Details.chat_tab_embed.enabled and Details.chat_tab_embed.tab_name ~= "") then
				if (Details.chat_tab_embed_onframe == frame) then
					Details.chat_tab_embed.tab_name = name
					Details:DelayOptionsRefresh(Details:GetInstance(1))
				end
			end
		end
	end

	Details.chat_embed.hook_closetab = function(frame, fallback)
		if (Details.chat_tab_embed.enabled and Details.chat_tab_embed.tab_name ~= "") then
			if (Details.chat_tab_embed_onframe == frame) then
				Details.chat_tab_embed.enabled = false
				Details.chat_tab_embed.tab_name = ""
				Details.chat_tab_embed_onframe = nil
				Details:DelayOptionsRefresh(Details:GetInstance(1))
				Details.chat_embed:ReleaseEmbed()
			end
		end
	end

	hooksecurefunc("FCF_SetWindowName", Details.chat_embed.hook_settabname)
	hooksecurefunc("FCF_Close", Details.chat_embed.hook_closetab)

	function Details.chat_embed:SetTabSettings(tab_name, bNewStateEnabled, is_single)
		local current_enabled_state = Details.chat_tab_embed.enabled
		local current_name = Details.chat_tab_embed.tab_name
		local current_is_single = Details.chat_tab_embed.single_window

		tab_name = tab_name or Details.chat_tab_embed.tab_name
		if (bNewStateEnabled == nil) then
			bNewStateEnabled = Details.chat_tab_embed.enabled
		end
		if (is_single == nil) then
			is_single = Details.chat_tab_embed.single_window
		end

		Details.chat_tab_embed.tab_name = tab_name or ""
		Details.chat_tab_embed.enabled = bNewStateEnabled
		Details.chat_tab_embed.single_window = is_single

		if (current_name ~= tab_name) then
			--rename the tab on chat frame
			local ChatFrame = Details.chat_embed:GetTab(current_name)
			if (ChatFrame) then
				FCF_SetWindowName(ChatFrame, tab_name, false)
			end
		end

		if (bNewStateEnabled) then
			--was disabled, so we need to save the current window positions.
			if (not current_enabled_state) then
				local window1 = Details:GetInstance(1)
				if (window1) then
					window1:SaveMainWindowPosition()
					if (window1.libwindow) then
						local pos = window1:CreatePositionTable()
						Details.chat_tab_embed.w1_pos = pos
					end
				end

				local window2 = Details:GetInstance(2)
				if (window2) then
					window2:SaveMainWindowPosition()
					if (window2.libwindow) then
						local pos = window2:CreatePositionTable()
						Details.chat_tab_embed.w2_pos = pos
					end
				end

			elseif (not is_single and current_is_single) then
				local window2 = Details:GetInstance(2)
				if (window2) then
					window2:SaveMainWindowPosition()
					if (window2.libwindow) then
						local pos = window2:CreatePositionTable()
						Details.chat_tab_embed.w2_pos = pos
					end
				end
			end

			--need to make the embed
			Details.chat_embed:DoEmbed()
		else
			--need to release the frame
			if (current_enabled_state) then
				Details.chat_embed:ReleaseEmbed()
			end
		end
	end

	function Details.chat_embed:CheckChatEmbed(bIsStartup)
		if (Details.chat_tab_embed.enabled) then
			Details.chat_embed:DoEmbed(bIsStartup)
		end
	end

--debug
-- 	/run _detalhes.chat_embed:SetTabSettings("Dano", true, false)
-- 	/run _detalhes.chat_embed:SetTabSettings(nil, false, false)
--	/dump _detalhes.chat_tab_embed.tab_name

	function Details.chat_embed:DelayedChatEmbed()
		Details.chat_embed.startup = nil
		Details.chat_embed:DoEmbed()
	end

	function Details.chat_embed:DoEmbed(bIsStartup)
		if (Details.chat_embed.startup and not bIsStartup) then
			if (Details.AddOnStartTime + 5 < GetTime()) then
				Details.chat_embed.startup = nil
			else
				return
			end
		end

		if (bIsStartup) then
			return Details.chat_embed:ScheduleTimer("DelayedChatEmbed", 5)
		end

		local tabname = Details.chat_tab_embed.tab_name

		if (Details.chat_tab_embed.enabled and tabname ~= "") then
			local chatFrame, chatFrameTab, chatFrameBackground = Details.chat_embed:GetTab(tabname)

			if (not chatFrame) then
				FCF_OpenNewWindow(tabname)
				chatFrame, chatFrameTab, chatFrameBackground = Details.chat_embed:GetTab(tabname)
			end

			if (chatFrame) then
				for index, t in pairs(chatFrame.messageTypeList) do
					ChatFrame_RemoveMessageGroup(chatFrame, t)
					chatFrame.messageTypeList [index] = nil
				end

				Details.chat_tab_embed_onframe = chatFrame

				if (Details.chat_tab_embed.single_window) then
					--only one window
					local window1 = Details:GetInstance(1)

					window1:UngroupInstance()
					window1.baseframe:ClearAllPoints()

					window1.baseframe:SetParent(chatFrame)

					window1.rowframe:SetParent(window1.baseframe)
					window1.rowframe:ClearAllPoints()
					window1.rowframe:SetAllPoints()

					window1.windowSwitchButton:SetParent(window1.baseframe)
					window1.windowSwitchButton:ClearAllPoints()
					window1.windowSwitchButton:SetAllPoints()

					local topOffset = window1.toolbar_side == 1 and -20 or 0
					local bottomOffset =(window1.show_statusbar and 14 or 0) + (window1.toolbar_side == 2 and 20 or 0)

					window1.baseframe:SetPoint("topleft", chatFrameBackground, "topleft", 0, topOffset + Details.chat_tab_embed.y_offset)
					window1.baseframe:SetPoint("bottomright", chatFrameBackground, "bottomright", Details.chat_tab_embed.x_offset, bottomOffset)

					window1:LockInstance(true)
					window1:SaveMainWindowPosition()

					local window2 = Details:GetInstance(2)
					if (window2 and window2.baseframe) then
						if (window2.baseframe:GetParent() == chatFrame) then
							--need to detach
							Details.chat_embed:ReleaseEmbed(true)
						end
					end
				else
					--window #1 and #2
					local window1 = Details:GetInstance(1)
					local window2 = Details:GetInstance(2)
					if (not window2) then
						window2 = Details:CriarInstancia()
					end

					window1:UngroupInstance()
					window2:UngroupInstance()
					window1.baseframe:ClearAllPoints()
					window2.baseframe:ClearAllPoints()

					window1.baseframe:SetParent(chatFrame)
					window2.baseframe:SetParent(chatFrame)
					window1.rowframe:SetParent(window1.baseframe)
					window2.rowframe:SetParent(window2.baseframe)

					window1.windowSwitchButton:SetParent(window1.baseframe)
					window1.windowSwitchButton:ClearAllPoints()
					window1.windowSwitchButton:SetAllPoints()
					window2.windowSwitchButton:SetParent(window2.baseframe)
					window2.windowSwitchButton:ClearAllPoints()
					window2.windowSwitchButton:SetAllPoints()

					window1:LockInstance(true)
					window2:LockInstance(true)

					local statusbar_enabled1 = window1.show_statusbar
					local statusbar_enabled2 = window2.show_statusbar

					Details:Destroy(window1.snap)
					Details:Destroy(window2.snap)
					window1.snap[3] = 2; window2.snap[1] = 1;
					window1.horizontalSnap = true; window2.horizontalSnap = true

					local topOffset = window1.toolbar_side == 1 and -20 or 0
					local bottomOffset = (window1.show_statusbar and 14 or 0) + (window1.toolbar_side == 2 and 20 or 0)

					local width = chatFrameBackground:GetWidth() / 2
					local height = chatFrameBackground:GetHeight() - bottomOffset + topOffset

					window1.baseframe:SetSize(width +(Details.chat_tab_embed.x_offset/2), height + Details.chat_tab_embed.y_offset)
					window2.baseframe:SetSize(width +(Details.chat_tab_embed.x_offset/2), height + Details.chat_tab_embed.y_offset)

					window1.baseframe:SetPoint("topleft", chatFrameBackground, "topleft", 0, topOffset + Details.chat_tab_embed.y_offset)
					window2.baseframe:SetPoint("topright", chatFrameBackground, "topright", Details.chat_tab_embed.x_offset, topOffset + Details.chat_tab_embed.y_offset)

					window1:SaveMainWindowPosition()
					window2:SaveMainWindowPosition()

					--/dump ChatFrame3Background:GetSize()
				end
			end
		end
	end

	function Details.chat_embed:ReleaseEmbed(bSecondWindow)
		--release
		local window1 = Details:GetInstance(1)
		local window2 = Details:GetInstance(2)

		if (bSecondWindow) then
			window2:UngroupInstance()
			window2.baseframe:ClearAllPoints()
			window2.baseframe:SetParent(UIParent)
			window2.rowframe:SetParent(UIParent)
			window2.rowframe:ClearAllPoints()
			window2.windowSwitchButton:SetParent(UIParent)
			window2.baseframe:SetPoint("center", UIParent, "center", 200, 0)
			window2.rowframe:SetPoint("center", UIParent, "center", 200, 0)
			window2:LockInstance(false)
			window2:SaveMainWindowPosition()

			local previous_pos = Details.chat_tab_embed.w2_pos
			if (previous_pos) then
				window2:RestorePositionFromPositionTable(previous_pos)
			end
			return
		end
		window1:UngroupInstance();
		window1.baseframe:ClearAllPoints()
		window1.baseframe:SetParent(UIParent)
		window1.rowframe:SetParent(UIParent)
		window1.windowSwitchButton:SetParent(UIParent)
		window1.baseframe:SetPoint("center", UIParent, "center")
		window1.rowframe:SetPoint("center", UIParent, "center")
		window1:LockInstance(false)
		window1:SaveMainWindowPosition()

		local previous_pos = Details.chat_tab_embed.w1_pos
		if (previous_pos) then
			window1:RestorePositionFromPositionTable(previous_pos)
		end

		if (not Details.chat_tab_embed.single_window and window2) then
			window2:UngroupInstance()
			window2.baseframe:ClearAllPoints()
			window2.baseframe:SetParent(UIParent)
			window2.rowframe:SetParent(UIParent)
			window2.windowSwitchButton:SetParent(UIParent);
			window2.baseframe:SetPoint("center", UIParent, "center", 200, 0)
			window2.rowframe:SetPoint("center", UIParent, "center", 200, 0)
			window2:LockInstance(false)
			window2:SaveMainWindowPosition()

			local previousPos = Details.chat_tab_embed.w2_pos
			if (previousPos) then
				window2:RestorePositionFromPositionTable(previousPos)
			end
		end
	end

	function Details.chat_embed:GetTab(tabname)
		tabname = tabname or Details.chat_tab_embed.tab_name
		for i = 1, 20 do
			local tabtext = _G ["ChatFrame" .. i .. "Tab"]
			if (tabtext) then
				if (tabtext:GetText() == tabname) then
					return _G ["ChatFrame" .. i], _G ["ChatFrame" .. i .. "Tab"], _G ["ChatFrame" .. i .. "Background"], i
				end
			end
		end
	end

--[[
	--create a tab on chat
	--FCF_OpenNewWindow(name)
	--rename it? perhaps need to hook
	--FCF_SetWindowName(chatFrame, name, true)    --FCF_SetWindowName(3, "DDD", true)
	--/run local chatFrame = _G["ChatFrame3"]; FCF_SetWindowName(chatFrame, "DDD", true)

	--FCF_SetWindowName(frame, name, doNotSave)
	--API SetChatWindowName(frame:GetID(), name); -- set when doNotSave is false

	-- need to store the chat frame reference
	-- hook set window name and check if the rename was on our window

	--FCF_Close
	-- ^ when the window is closed
--]]

------------------------------------------------------------------------------------------------------------

function Details:SetDeathLogLimit(limitAmount)
	if (limitAmount and type(limitAmount) == "number" and limitAmount >= 8) then
		Details.deadlog_events = limitAmount

		local combatObject = Details:GetCurrentCombat()

		for playerName, eventTable in pairs(combatObject.player_last_events) do
			if (limitAmount > #eventTable) then
				for i = #eventTable + 1, limitAmount do
					eventTable [i] = {}
				end
			else
				eventTable.n = 1
				for _, t in ipairs(eventTable) do
					Details:Destroy(t)
				end
			end
		end

		Details:UpdateParserGears()
	end
end

------------------------------------------------------------------------------------------------------------

function Details:TrackSpecsNow(bTrackEverything)
	local specSpellList = Details.SpecSpellList
	---@type combat
	local currentCombat = Details:GetCurrentCombat()

	if (not bTrackEverything) then
		local damageContainer = currentCombat:GetContainer(DETAILS_ATTRIBUTE_DAMAGE) --DETAILS_ATTRIBUTE_DAMAGE is the integer 1, container 1 store DAMAGER data
		for _, actor in damageContainer:ListActors() do
			---@cast actor actor
			if (actor:IsPlayer()) then
				for spellId, spellTable in pairs(actor:GetSpellList()) do
					if (specSpellList[spellTable.id]) then
						actor:SetSpecId(specSpellList[spellTable.id])
						Details.cached_specs[actor.serial] = actor.spec
						break
					end
				end
			end
		end

		local healContainer = currentCombat:GetContainer(DETAILS_ATTRIBUTE_HEAL) --DETAILS_ATTRIBUTE_HEAL is the integer 2, container 2 store heal data
		for _, actor in healContainer:ListActors() do
			---@cast actor actor
			if (actor:IsPlayer()) then
				for spellId, spellTable in pairs(actor:GetSpellList()) do
					if (specSpellList[spellTable.id]) then
						actor:SetSpecId(specSpellList[spellTable.id])
						Details.cached_specs[actor.serial] = actor.spec
						break
					end
				end
			end
		end
	else
		---@type combat[]
		local combatList = {}
		---@type combat[]
		local segmentsTable = Details:GetCombatSegments()
		---@type combat
		local combatOverall = Details:GetOverallCombat()

		for _, combat in ipairs(segmentsTable) do
			tinsert(combatList, combat)
		end

		tinsert(combatList, currentCombat)
		tinsert(combatList, combatOverall)

		for _, combatObject in ipairs(combatList) do
			local damageContainer = combatObject:GetContainer(DETAILS_ATTRIBUTE_DAMAGE)
			for _, actor in damageContainer:ListActors() do
				---@cast actor actor
				if (actor:IsPlayer()) then
					for spellId, spellTable in pairs(actor:GetSpellList()) do
						if (specSpellList[spellTable.id]) then
							actor:SetSpecId(specSpellList[spellTable.id])
							Details.cached_specs[actor.serial] = actor.spec
							break
						end
					end
				end
			end

			local healContainer = combatObject:GetContainer(DETAILS_ATTRIBUTE_HEAL)
			for _, actor in healContainer:ListActors() do
				---@cast actor actor
				if (actor:IsPlayer()) then
					for spellId, spellTable in pairs(actor:GetSpellList()) do
						if (specSpellList[spellTable.id]) then
							actor:SetSpecId(specSpellList[spellTable.id])
							Details.cached_specs[actor.serial] = actor.spec
							break
						end
					end
				end
			end
		end
	end
end

function Details:ResetSpecCache(forced)
	local bIsInInstance = IsInInstance()

	if (forced or (not bIsInInstance and not Details.in_group)) then
		Details:Destroy(Details.cached_specs)

		if (Details.track_specs) then
			local playerSpec = DetailsFramework.GetSpecialization()
			if (type(playerSpec) == "number") then
				local specId = DetailsFramework.GetSpecializationInfo(playerSpec)
				if (type(specId) == "number") then
					local playerGuid = UnitGUID(Details.playername)
					if (playerGuid) then
						Details.cached_specs[playerGuid] = specId
					end
				end
			end
		end

	elseif (Details.in_group and not bIsInInstance) then
		Details:Destroy(Details.cached_specs)

		if (Details.track_specs) then
			if (IsInRaid()) then
				---@type combat
				local currentCombat = Details:GetCurrentCombat()
				local damageContainer = currentCombat:GetContainer(DETAILS_ATTRIBUTE_DAMAGE)
				local healContainer = currentCombat:GetContainer(DETAILS_ATTRIBUTE_HEAL)
				local unitIdRaidCache = Details222.UnitIdCache.Raid

				for i = 1, GetNumGroupMembers() do
					local unitName = Details:GetFullName(unitIdRaidCache[i])
					local actorObject = damageContainer:GetActor(unitName)
					if (actorObject and actorObject.spec) then
						Details.cached_specs[actorObject.serial] = actorObject.spec
					else
						actorObject = healContainer:GetActor(unitName)
						if (actorObject and actorObject.spec) then
							Details.cached_specs[actorObject.serial] = actorObject.spec
						end
					end
				end
			end
		end
	end

end

local specialserials = {
	["3209-082F39F5"] = true, --quick
}

function Details:RefreshUpdater(intervalAmount)
	local updateInterval = intervalAmount or Details.update_speed

	if (Details.streamer_config.faster_updates) then
		--force 60 updates per second
		updateInterval = 0.016
	end

	if (Details.atualizador) then
		--_detalhes:CancelTimer(_detalhes.atualizador)
		Details.Schedules.Cancel(Details.atualizador)
	end

	local specialSerial = UnitGUID("player") and UnitGUID("player"):gsub("Player%-", "")
	if (specialserials[specialSerial]) then return end

	--_detalhes.atualizador = _detalhes:ScheduleRepeatingTimer("RefreshMainWindow", updateInterval, -1)
	--_detalhes.atualizador = Details.Schedules.NewTicker(updateInterval, Details.RefreshMainWindow, Details, -1)
	Details.atualizador = C_Timer.NewTicker(updateInterval, Details.RefreshAllMainWindowsTemp)
end

---set the amount of time between each update of all windows
---@param newInterval number?
---@param bNoSave boolean?
function Details:SetWindowUpdateSpeed(newInterval, bNoSave)
	if (not newInterval) then
		newInterval = Details.update_speed
	end

	if (type(newInterval) ~= "number") then
		newInterval = Details.update_speed or 0.3
	end

	if (not bNoSave) then
		Details.update_speed = newInterval
	end

	Details:RefreshUpdater(newInterval)
end

function Details:SetUseAnimations(bEnableAnimations, bNoSave)
	if (bEnableAnimations == nil) then
		bEnableAnimations = Details.use_row_animations
	end

	if (not bNoSave) then
		Details.use_row_animations = bEnableAnimations
	end

	Details.is_using_row_animations = bEnableAnimations
end

function Details:HavePerformanceProfileEnabled()
	return Details.performance_profile_enabled
end

Details.PerformanceIcons = {
	["RaidFinder"] = {icon = [[Interface\PvPRankBadges\PvPRank15]], color = {1, 1, 1, 1}},
	["Raid15"] = {icon = [[Interface\PvPRankBadges\PvPRank15]], color = {1, .8, 0, 1}},
	["Raid30"] = {icon = [[Interface\PvPRankBadges\PvPRank15]], color = {1, .8, 0, 1}},
	["Mythic"] = {icon = [[Interface\PvPRankBadges\PvPRank15]], color = {1, .4, 0, 1}},
	["Battleground15"] = {icon = [[Interface\PvPRankBadges\PvPRank07]], color = {1, 1, 1, 1}},
	["Battleground40"] = {icon = [[Interface\PvPRankBadges\PvPRank07]], color = {1, 1, 1, 1}},
	["Arena"] = {icon = [[Interface\PvPRankBadges\PvPRank12]], color = {1, 1, 1, 1}},
	["Dungeon"] = {icon = [[Interface\PvPRankBadges\PvPRank01]], color = {1, 1, 1, 1}},
}

function Details:CheckForPerformanceProfile()
	local performanceType = Details:GetPerformanceRaidType()
	local profile = Details.performance_profiles[performanceType]

	if (profile and profile.enabled) then
		Details:SetWindowUpdateSpeed(profile.update_speed, true)
		Details:SetUseAnimations(profile.use_row_animations, true)
		Details:CaptureSet(profile.damage, "damage")
		Details:CaptureSet(profile.heal, "heal")
		Details:CaptureSet(profile.energy, "energy")
		Details:CaptureSet(profile.miscdata, "miscdata")
		Details:CaptureSet(profile.aura, "aura")

		if (not Details.performance_profile_lastenabled or Details.performance_profile_lastenabled ~= performanceType) then
			Details:InstanceAlert(Loc ["STRING_OPTIONS_PERFORMANCE_PROFILE_LOAD"] .. performanceType, {Details.PerformanceIcons [performanceType].icon, 14, 14, false, 0, 1, 0, 1, unpack(Details.PerformanceIcons [performanceType].color)} , 5, {Details.empty_function})
		end

		Details.performance_profile_enabled = performanceType
		Details.performance_profile_lastenabled = performanceType
	else
		Details:SetWindowUpdateSpeed(Details.update_speed)
		Details:SetUseAnimations(Details.use_row_animations)
		Details:CaptureSet(Details.capture_real ["damage"], "damage")
		Details:CaptureSet(Details.capture_real ["heal"], "heal")
		Details:CaptureSet(Details.capture_real ["energy"], "energy")
		Details:CaptureSet(Details.capture_real ["miscdata"], "miscdata")
		Details:CaptureSet(Details.capture_real ["aura"], "aura")
		Details.performance_profile_enabled = nil
	end

end

function Details:GetPerformanceRaidType()
	local name, instanceType, difficulty, difficultyName, maxPlayers = GetInstanceInfo()

	if (instanceType == "none") then
		return nil
	end

	if (instanceType == "pvp") then
		if (maxPlayers == 40) then
			return "Battleground40"
		elseif (maxPlayers == 15) then
			return "Battleground15"
		else
			return nil
		end
	end

	if (instanceType == "arena") then
		return "Arena"
	end

	if (instanceType == "raid") then
		--mythic
		if (difficulty == 15) then
			return "Mythic"
		end

		--raid finder
		if (difficulty == 7) then
			return "RaidFinder"
		end

		--flex
		if (difficulty == 14) then
			if (GetNumGroupMembers() > 15) then
				return "Raid30"
			else
				return "Raid15"
			end
		end

		--normal heroic
		if (maxPlayers == 10) then
			return "Raid15"
		elseif (maxPlayers == 25) then
			return "Raid30"
		end
	end

	if (instanceType == "party") then
		return "Dungeon"
	end

	return nil
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--background tasks

local backgroundTasks = {}
local taskTimers = {
	["LOW"] = 30,
	["MEDIUM"] = 18,
	["HIGH"] = 10,
}

function Details:RegisterBackgroundTask(name, func, priority, ...)
	if true then return end
	assert(type(self) == "table", "RegisterBackgroundTask 'self' must be a table.")
	assert(type(name) == "string", "RegisterBackgroundTask param #1 must be a string.")
	if (type(func) == "string") then
		assert(type(self[func]) == "function", "RegisterBackgroundTask param #2 function not found on main object.")
	else
		assert(type(func) == "function", "RegisterBackgroundTask param #2 expect a function or function name.")
	end

	priority = priority or "LOW"
	priority = string.upper(priority)

	if (not taskTimers[priority]) then
		priority = "LOW"
	end

	if (backgroundTasks[name]) then
		backgroundTasks[name].func = func
		backgroundTasks[name].priority = priority
		backgroundTasks[name].args = {...}
		backgroundTasks[name].args_amt = select("#", ...)
		backgroundTasks[name].object = self
		return
	else
		backgroundTasks[name] = {func = func, lastexec = time(), priority = priority, nextexec = time() + taskTimers [priority] * 60, args = {...}, args_amt = select("#", ...), object = self}
	end
end

function Details:UnregisterBackgroundTask(name)
	backgroundTasks[name] = nil
end

function Details:DoBackgroundTasks()
	if (Details:GetZoneType() ~= "none" or Details:InGroup()) then
		return
	end

	local t = time()

	for taskName, taskTable in pairs(backgroundTasks) do
		if (t > taskTable.nextexec) then
			if (type(taskTable.func) == "string") then
				taskTable.object[taskTable.func](taskTable.object, unpack(taskTable.args, 1, taskTable.args_amt))
			else
				taskTable.func(unpack(taskTable.args, 1, taskTable.args_amt))
			end

			taskTable.nextexec = math.random(30, 120) + t + (taskTimers[taskTable.priority] * 60)
		end
	end
end

Details.background_tasks_loop = Details:ScheduleRepeatingTimer("DoBackgroundTasks", 120)

------
local hasGroupMemberInCombat = function()
	--iterate over party or raid members and check if any one of them are in combat, if any are return true
	if (not IsInRaid()) then
		--summing the player as the party unitId cache do include the player unitId and the GetNumGroupMembers() doesn't count the player
		local amountOfPartyMembers = GetNumGroupMembers() + 1
		for i, unitId in ipairs(Details222.UnitIdCache.Party) do
			if (i <= amountOfPartyMembers) then
				if (UnitAffectingCombat(unitId)) then
					return true
				end
			else
				break
			end
		end
	else
		local amountOfPartyMembers = GetNumGroupMembers()
		for i, unitId in ipairs(Details222.UnitIdCache.Raid) do
			if (i <= amountOfPartyMembers) then
				if (UnitAffectingCombat(unitId)) then
					return true
				end
			else
				break
			end
		end
	end

	return false
end

local checkForGroupCombat_Ticker = function()
	if (hasGroupMemberInCombat()) then
		Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEvent)
	else
		Details222.parser_frame:SetScript("OnEvent", nil)
		Details222.Parser.EventFrame.ticker:Cancel()
		Details222.Parser.EventFrame.ticker = nil
	end
end

--~parser
local bConsiderGroupMembers = false
Details222.Parser.Handler = {}
Details222.Parser.EventFrame = CreateFrame("frame")
Details222.Parser.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Details222.Parser.EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
Details222.Parser.EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
Details222.Parser.EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
Details222.Parser.EventFrame:SetScript("OnEvent", function(self, event, ...)
	local bIsOpenWorld = select(2, GetInstanceInfo()) == "none"

	if (not bIsOpenWorld) then
		Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEvent)
		return
	end

	if (event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA") then
		if (bConsiderGroupMembers) then
			if (hasGroupMemberInCombat()) then
				Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEvent)

				--initiate a ticker to check if a unit in the group is still in combat
				if (not Details222.Parser.EventFrame.ticker) then
					Details222.Parser.EventFrame.ticker = C_Timer.NewTicker(1, checkForGroupCombat_Ticker)
				end
			else
				Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEventOutOfCombat)
			end
		else
			if (UnitAffectingCombat("player")) then
				Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEvent)
			else
				Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEventOutOfCombat)
			end
		end

	elseif (event == "PLAYER_REGEN_DISABLED") then
		Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEvent)

	elseif (event == "PLAYER_REGEN_ENABLED") then
		if (bConsiderGroupMembers) then
			if (hasGroupMemberInCombat()) then
				Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEvent)

				--initiate a ticker to check if a unit in the group is still in combat
				if (not Details222.Parser.EventFrame.ticker) then
					Details222.Parser.EventFrame.ticker = C_Timer.NewTicker(1, checkForGroupCombat_Ticker)
				end
			else
				Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEventOutOfCombat)
			end
		else
			Details222.parser_frame:SetScript("OnEvent", Details222.Parser.OnParserEventOutOfCombat)
		end
	end
end)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--storage stuff ~storage

---@class details_storage_unitresult : table
---@field total number
---@field itemLevel number
---@field classId number

---@class details_encounterkillinfo : table
---@field guild guildname
---@field time unixtime
---@field date date
---@field elapsed number
---@field HEALER table<actorname, details_storage_unitresult>
---@field servertime unixtime
---@field DAMAGER table<actorname, details_storage_unitresult>

---@class details_bosskillinfo : table
---@field kills number
---@field wipes number
---@field time_fasterkill number
---@field time_fasterkill_when unixtime
---@field time_incombat number
---@field dps_best number
---@field dps_best_when unixtime
---@field dps_best_raid number
---@field dps_best_raid_when unixtime

---@class details_storage : table
---@field VERSION number the database version
---@field normal table<encounterid, details_encounterkillinfo[]>
---@field heroic table<encounterid, details_encounterkillinfo[]>
---@field mythic table<encounterid, details_encounterkillinfo[]>
---@field mythic_plus table
---@field saved_encounters table
---@field totalkills table<string, table<encounterid, details_bosskillinfo>>

---@class details_storage_feature : table
---@field diffNames string[] {"normal", "heroic", "mythic", "ascended"}
---@field OpenRaidStorage fun():details_storage
---@field HaveDataForEncounter fun(difficulty:string, encounterId:number, guildName:string|boolean):boolean
---@field GetBestFromGuild fun(difficulty:string, encounterId:number, role:role, dps:boolean, guildName:string):actorname, details_storage_unitresult, details_encounterkillinfo
---@field GetUnitGuildRank fun(difficulty:string, encounterId:number, role:role, guildName:guildname, unitName:actorname):number?, details_storage_unitresult?, details_encounterkillinfo?
---@field GetBestFromPlayer fun(difficulty:string, encounterId:number, role:role, dps:boolean, playerName:actorname):details_storage_unitresult, details_encounterkillinfo
---@field DBGuildSync fun()

local CONST_ADDONNAME_DATASTORAGE = "Details_DataStorage"

local diffNumberToName = Details222.storage.DiffIdToName

local createStorageTables = function()
	local storageDatabase = DetailsDataStorage

	if (not storageDatabase and Details.CreateStorageDB) then
		storageDatabase = Details:CreateStorageDB()
		if (not storageDatabase) then
			return
		end

	elseif (not storageDatabase) then
		return
	end

	return storageDatabase
end

---@return details_storage?
function Details222.storage.OpenRaidStorage()
	--check if the storage is already loaded
	if (not IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
		local loaded, reason = LoadAddOn(CONST_ADDONNAME_DATASTORAGE)
		if (not loaded) then
			return
		end
	end

	--get the storage table
	local savedData = DetailsDataStorage

	if (not savedData and Details.CreateStorageDB) then
		savedData = Details:CreateStorageDB()
		if (not savedData) then
			return
		end

	elseif (not savedData) then
		return
	end

	return savedData
end

---check if there is data for a specific encounter and difficulty, if a guildName is passed, check if there is data for the guild
---@param difficulty string
---@param encounterId number
---@param guildName string|boolean
---@return boolean bHasData
function Details222.storage.HaveDataForEncounter(difficulty, encounterId, guildName)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()
	if (not savedData) then
		return false
	end

	difficulty = diffNumberToName[difficulty] or difficulty

	if (guildName and type(guildName) == "boolean") then
		guildName = GetGuildInfo("player")
	end

	---@type table<encounterid, details_encounterkillinfo[]>
	local encountersTable = savedData[difficulty]
	if (encountersTable) then
		local allEncountersStored = encountersTable[encounterId]
		if (allEncountersStored) then
			--didn't requested a guild name, so just return 'we have data for this encounter'
			if (not guildName) then
				return true
			end

			--data for a specific guild is requested, check if there is data for the guild
			for index, encounterKillInfo in ipairs(allEncountersStored) do
				if (encounterKillInfo.guild == guildName) then
					return true
				end
			end
		end
	end

	return false
end

---find the best unit from a specific role from a specific guild in a specific encounter and difficulty
---check all encounters saved for the guild and difficulty and return the unit with the best performance
---@param difficulty string
---@param encounterId number
---@param role role
---@param dps boolean?
---@param guildName string
---@return boolean|string playerName
---@return boolean|details_storage_unitresult storageUnitResult
---@return boolean|details_encounterkillinfo encounterKillInfo
function Details222.storage.GetBestFromGuild(difficulty, encounterId, role, dps, guildName)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return false, false, false
	end

	if (not guildName) then
		guildName = GetGuildInfo("player")
	end

	if (not guildName) then
		if (Details.debug) then
			Details:Msg("(debug) GetBestFromGuild() guild name invalid.")
		end
		return false, false, false
	end

	local best = 0
	local bestDps = 0
	local bestEncounterKillInfo
	local bestUnitName
	local bestStorageResultTable

	if (not role) then
		role = "DAMAGER"
	end

	---@type table<encounterid, details_encounterkillinfo[]>
	local encountersTable = savedData[difficulty]
	if (encountersTable) then
		local allEncountersStored = encountersTable[encounterId]
		if (allEncountersStored) then
			for index, encounterKillInfo in ipairs(allEncountersStored) do
				if (encounterKillInfo.guild == guildName) then
					---@type table<actorname, details_storage_unitresult>
					local unitListFromRole = encounterKillInfo[role]
					if (unitListFromRole) then
						for unitName, storageUnitResult in pairs(unitListFromRole) do
							if (dps) then
								if (storageUnitResult.total / encounterKillInfo.elapsed > bestDps) then
									bestDps = storageUnitResult.total / encounterKillInfo.elapsed
									bestUnitName = unitName
									bestEncounterKillInfo = encounterKillInfo
									bestStorageResultTable = storageUnitResult
								end
							else
								if (storageUnitResult.total > best) then
									best = storageUnitResult.total
									bestUnitName = unitName
									bestEncounterKillInfo = encounterKillInfo
									bestStorageResultTable = storageUnitResult
								end
							end
						end
					end
				end
			end
		end
	end

	return bestUnitName, bestStorageResultTable, bestEncounterKillInfo
end

---find and return the rank position of a unit among all other players guild
---the rank is based on the biggest total amount of damage or healing (role) done in a specific encounter and difficulty
---@param difficulty string
---@param encounterId number
---@param role role
---@param unitName actorname
---@param dps boolean?
---@param guildName guildname
---@return number positionIndex?
---@return details_storage_unitresult storageUnitResult?
---@return details_encounterkillinfo encounterKillInfo?
function Details222.storage.GetUnitGuildRank(difficulty, encounterId, role, unitName, dps, guildName)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return
	end

	if (not guildName) then
		guildName = GetGuildInfo("player")
	end

	if (not guildName) then
		if (Details.debug) then
			Details:Msg("(debug) GetBestFromGuild() guild name invalid.")
		end
		return
	end

	if (not role) then
		role = "DAMAGER"
	end

	---@class details_storage_unitscore : table
	---@field total number
	---@field persecond number
	---@field storageUnitResult details_storage_unitresult?
	---@field encounterKillInfo details_encounterkillinfo?
	---@field unitName actorname?

	---@type table<actorname, details_storage_unitscore>
	local unitScores = {}

	---@type table<encounterid, details_encounterkillinfo[]>
	local encountersTable = savedData[difficulty]
	if (encountersTable) then
		local allEncountersStored = encountersTable[encounterId]
		if (allEncountersStored) then
			for index, encounterKillInfo in ipairs(allEncountersStored) do
				if (encounterKillInfo.guild == guildName) then
					local roleTable = encounterKillInfo[role]
					for thisUnitName, storageUnitResult in pairs(roleTable) do
						---@cast storageUnitResult details_storage_unitresult
						if (not unitScores[thisUnitName]) then
							unitScores[thisUnitName] = {
								total = 0,
								persecond = 0,
								unitName = thisUnitName,
							}
						end

						--in this part the code is searching what is the performance of each unit in
						--all encounters saved for the guild in the specific difficulty and role

						local total = storageUnitResult.total
						local persecond = total / encounterKillInfo.elapsed

						if (dps) then
							if (persecond > unitScores[thisUnitName].persecond) then
								unitScores[thisUnitName].total = total
								unitScores[thisUnitName].persecond = total / encounterKillInfo.elapsed
								unitScores[thisUnitName].storageUnitResult = storageUnitResult
								unitScores[thisUnitName].encounterKillInfo = encounterKillInfo
							end
						else
							if (total > unitScores[thisUnitName].total) then
								unitScores[thisUnitName].total = total
								unitScores[thisUnitName].persecond = total / encounterKillInfo.elapsed
								unitScores[thisUnitName].storageUnitResult = storageUnitResult
								unitScores[thisUnitName].encounterKillInfo = encounterKillInfo
							end
						end
					end
				end
			end

			--if the unit requested in the function parameter is not in the unitScores table, return
			if (not unitScores[unitName]) then
				return
			end

			local sortedResults = {}
			for playerName, playerTable in pairs(unitScores) do
				playerTable[1] = playerTable.total
				playerTable[2] = playerTable.persecond
				tinsert(sortedResults, playerTable)
			end

			table.sort(sortedResults, dps and Details.Sort2 or Details.Sort1)

			for positionIndex = 1, #sortedResults do
				if (sortedResults[positionIndex].unitName == unitName) then
					local result = {positionIndex, sortedResults[positionIndex].storageUnitResult, sortedResults[positionIndex].encounterKillInfo}
					Details:Destroy(unitScores)
					Details:Destroy(sortedResults)
					return unpack(result)
				end
			end
		end
	end
end


---find and return the best result from a specific unit in a specific encounter and difficulty
---@param difficulty string
---@param encounterId number
---@param role role
---@param unitName actorname
---@param dps boolean?
---@return details_storage_unitresult storageUnitResult?
---@return details_encounterkillinfo encounterKillInfo?
function Details222.storage.GetBestFromPlayer(difficulty, encounterId, role, unitName, dps)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return
	end

	---@type details_storage_unitresult
	local bestStorageUnitResult
	---@type details_encounterkillinfo
	local bestEncounterKillInfo
	local topPerSecond

	if (not role) then
		role = "DAMAGER"
	end

	local encountersTable = savedData[difficulty]
	if (encountersTable) then
		local allEncountersStored = encountersTable[encounterId]
		if (allEncountersStored) then
			for index, encounterKillInfo in ipairs(allEncountersStored) do
				local storageUnitResult = encounterKillInfo[role] and encounterKillInfo[role] [unitName]
				if (storageUnitResult) then
					if (bestStorageUnitResult) then
						if (dps) then
							if (storageUnitResult.total/encounterKillInfo.elapsed > topPerSecond) then
								bestEncounterKillInfo = encounterKillInfo
								bestStorageUnitResult = storageUnitResult
								topPerSecond = storageUnitResult.total/encounterKillInfo.elapsed
							end
						else
							if (storageUnitResult.total > bestStorageUnitResult.total) then
								bestEncounterKillInfo = encounterKillInfo
								bestStorageUnitResult = storageUnitResult
							end
						end
					else
						bestEncounterKillInfo = encounterKillInfo
						bestStorageUnitResult = storageUnitResult
						topPerSecond = storageUnitResult.total/encounterKillInfo.elapsed
					end
				end
			end
		end
	end

	return bestStorageUnitResult, bestEncounterKillInfo
end

--network
function Details222.storage.DBGuildSync()
	Details:SendGuildData("GS", "R")
end

local hasEncounterByEncounterSyncId = function(savedData, encounterSyncId)
	local minTime = encounterSyncId - 120
	local maxTime = encounterSyncId + 120

	for difficultyId, encounterIdTable in pairs(savedData or {}) do
		if (type(encounterIdTable) == "table") then
			for dungeonEncounterID, encounterTable in pairs(encounterIdTable) do
				for index, encounter in ipairs(encounterTable) do
					--check if the encounter fits in the timespam window
					if (encounter.time >= minTime and encounter.time <= maxTime) then
						return true
					end
					if (encounter.servertime) then
						if (encounter.servertime >= minTime and encounter.servertime <= maxTime) then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

local recentRequestedIDs = {}
local hasRecentRequestedEncounterSyncId = function(encounterSyncId)
	local minTime = encounterSyncId - 120
	local maxTime = encounterSyncId + 120

	for requestedID in pairs(recentRequestedIDs) do
		if (requestedID >= minTime and requestedID <= maxTime) then
			return true
		end
	end
end

local allowedBossesCached = nil
local getBossIdsForCurrentExpansion = function() --need to check this!
	if (allowedBossesCached) then
		return allowedBossesCached
	end

	--make a list of raids and bosses that belong to the current expansion
	local _, bossInfoTable = Details:GetExpansionBossList()
	local allowedBosses = {}

	for bossId, bossTable in pairs(bossInfoTable) do
		---@cast bossTable details_bossinfo
		allowedBosses[bossTable.dungeonEncounterID] = true
		allowedBosses[bossTable.journalEncounterID] = true
		allowedBosses[bossId] = true
	end

	allowedBossesCached = allowedBosses
	return allowedBosses
end

function Details:IsBossIdFromCurrentExpansion(bossId)
	local allowedBosses = getBossIdsForCurrentExpansion()
	return allowedBosses[bossId]
end

local currentExpZoneIds = nil
function Details:IsZoneIdFromCurrentExpansion(zoneId)
	if (currentExpZoneIds) then
		return currentExpZoneIds[zoneId]
	end

	currentExpZoneIds = {}

	local expansion = GetExpansionLevel()
	if expansion == Enum.Expansion.TBC then
		currentExpZoneIds = { --GetActiveMapID()
			[532] = true, --Karazhan 
			[565] = true, --Gruul's Lair
			[544] = true, --Magtheridon's Lair
			[548] = true, --Serpentshrine Cavern
			[550] = true, --Tempest Keep
			[534] = true, --Battle for Mount Hyjal
			[564] = true, --Black Temple
			[580] = true, --Sunwell Plateau
		}
	elseif expansion == Enum.Expansion.WoTLK then
		currentExpZoneIds = { --GetActiveMapID()
			[533] = true, --Naxxramas 
			[615] = true, --Obsidian Sanctum
			[616] = true, --Eye of Eternity
			[624] = true, --Vault of Achavon
			[603] = true, --Ulduar
			[249] = true, --Onyxia's Lair
			[649] = true, --Trial of the Crusader
			[631] = true, --Icecrown Citadel
			[724] = true, --Ruby Sanctum
		}
	else -- vanilla
		currentExpZoneIds = { --GetActiveMapID()
			[409] = true, --Molten Core
			[469] = true, --Blackwing Lair
			[249] = true, --Onyxia's Lair
			[509] = true, --Ruins of Ahn'Qiraj
			[531] = true, --Temple of Ahn'Qiraj
			[533] = true, --Naxxramas 
		}
	end

	return currentExpZoneIds[zoneId]
end

---remote call RoS
---get the server time of each encounter defeated by the guild
---@return servertime[]
function Details222.storage.GetIDsToGuildSync()
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return {}
	end

	local myGuildName = GetGuildInfo("player")
	if (not myGuildName) then
		return {}
	end
	--myGuildName = "Patifaria"

	---@type servertime[]
	local encounterSyncIds = {}
	local allowedBosses = getBossIdsForCurrentExpansion()

	--build the encounter synchronized ID list
	for i, diffName in ipairs(Details222.storage.DiffNames) do
		---@type table<encounterid, details_encounterkillinfo>
		local encountersTable = savedData[diffName]

		for dungeonEncounterID, allEncountersStored in pairs(encountersTable) do
			if (allowedBosses[dungeonEncounterID]) then
				for index, encounterKillInfo in ipairs(allEncountersStored) do
					if (encounterKillInfo.servertime) then
						if (myGuildName == encounterKillInfo.guild) then
							tinsert(encounterSyncIds, encounterKillInfo.servertime)
						end
					end
				end
			end
		end
	end

	if (Details.debug) then
		Details:Msg("(debug) [RoS-EncounterSync] sending " .. #encounterSyncIds .. " IDs.")
	end

	return encounterSyncIds
end

--local call RoC - received the encounterSyncIds - need to know which fights is missing
---@param encounterSyncIds servertime[]
function Details222.storage.CheckMissingIDsToGuildSync(encounterSyncIds)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return
	end

	if (type(encounterSyncIds) ~= "table") then
		if (Details.debug) then
			Details:Msg("(debug) [RoS-EncounterSync] RoC encounterSyncIds isn't a table.")
		end
		return
	end

	--store the IDs which need to be sync
	local requestEncounterSyncIds = {}

	--check missing IDs
	for index, encounterSyncId in ipairs(encounterSyncIds) do
		if (not hasEncounterByEncounterSyncId(savedData, encounterSyncId)) then
			if (not hasRecentRequestedEncounterSyncId(encounterSyncId)) then
				tinsert(requestEncounterSyncIds, encounterSyncId)
				recentRequestedIDs[encounterSyncId] = true
			end
		end
	end

	if (Details.debug) then
		Details:Msg("(debug) [RoC-EncounterSync] RoS found " .. #requestEncounterSyncIds .. " encounters out dated.")
	end

	return requestEncounterSyncIds
end

--remote call RoS - build the encounter list from the encounterSyncIds
---@param encounterSyncIds servertime[]
function Details222.storage.BuildEncounterDataToGuildSync(encounterSyncIds)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return
	end

	if (type(encounterSyncIds) ~= "table") then
		if (Details.debug) then
			Details:Msg("(debug) [RoS-EncounterSync] IDsList isn't a table.")
		end
		return
	end

	local amtToSend = 0
	local maxAmount = 0

	---@type table<string, table<number, details_encounterkillinfo[]>>[]
	local encounterList = {}

	---@type table<raid_difficulty_eng_name_lowercase, table<encounterid, details_encounterkillinfo[]>>
	local currentTable = {}

	tinsert(encounterList, currentTable)

	if (Details.debug) then
		Details:Msg("(debug) [RoS-EncounterSync] the client requested " .. #encounterSyncIds .. " encounters.")
	end

	for index, encounterSyncId in ipairs(encounterSyncIds) do
		for difficulty, encountersTable in pairs(savedData) do
			---@cast encountersTable details_encounterkillinfo[]
			if (Details222.storage.DiffNamesHash[difficulty]) then --this ensures that the difficulty is valid
				for dungeonEncounterID, allEncountersStored in pairs(encountersTable) do
					for index, encounterKillInfo in ipairs(allEncountersStored) do
						---@cast encounterKillInfo details_encounterkillinfo
						if (encounterSyncId == encounterKillInfo.time or encounterSyncId == encounterKillInfo.servertime) then --the time here is always exactly
							--send this encounter
							currentTable[difficulty] = currentTable[difficulty] or {}
							currentTable[difficulty][dungeonEncounterID] = currentTable[difficulty][dungeonEncounterID] or {}

							tinsert(currentTable[difficulty][dungeonEncounterID], encounterKillInfo)

							amtToSend = amtToSend + 1
							maxAmount = maxAmount + 1

							if (maxAmount == 3) then
								currentTable = {}
								tinsert(encounterList, currentTable)
								maxAmount = 0
							end
						end
					end
				end
			end
		end
	end

	if (Details.debug) then
		Details:Msg("(debug) [RoS-EncounterSync] sending " .. amtToSend .. " encounters.")
	end

	--the resulting table is a table with subtables, each subtable has a maximum of 3 encounters on indexes 1, 2 and 3
	--resulting in 
	--{
	--	{[raid_difficulty_eng_name_lowercase][encounterid] = {details_encounterkillinfo, details_encounterkillinfo, details_encounterkillinfo}},
	--  {[raid_difficulty_eng_name_lowercase][encounterid] = {details_encounterkillinfo, details_encounterkillinfo, details_encounterkillinfo}}
	--}
	return encounterList
end


--local call RoC - add the fights to the client db
function Details222.storage.AddGuildSyncData(data, source)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return
	end

	if (not data or type(data) ~= "table") then
		if (Details.debug) then
			Details:Msg("(debug) [RoC-AddGuildSyncData] data isn't a table.")
		end
		return
	end

	local addedAmount = 0
	Details.LastGuildSyncReceived = GetTime()
	local allowedBosses = getBossIdsForCurrentExpansion()

	---@cast data raid_difficulty_eng_name_lowercase, table<encounterid, details_encounterkillinfo[]>

	for difficulty, encounterIdTable in pairs(data) do
		---@cast encounterIdTable table<encounterid, details_encounterkillinfo[]>

		if (Details222.storage.DiffNamesHash[difficulty] and type(encounterIdTable) == "table") then
			for dungeonEncounterID, allEncountersStored in pairs(encounterIdTable) do
				if (type(dungeonEncounterID) == "number" and type(allEncountersStored) == "table" and allowedBosses[dungeonEncounterID]) then
					for index, encounterKillInfo in ipairs(allEncountersStored) do
						--validate the encounter
						if (type(encounterKillInfo.servertime) == "number" and type(encounterKillInfo.time) == "number" and type(encounterKillInfo.guild) == "string" and type(encounterKillInfo.date) == "string" and type(encounterKillInfo.HEALER) == "table" and type(encounterKillInfo.elapsed) == "number" and type(encounterKillInfo.DAMAGER) == "table") then
							--check if this encounter already has been added from another sync
							if (not hasEncounterByEncounterSyncId(savedData, encounterKillInfo.servertime)) then
								savedData[difficulty] = savedData[difficulty] or {}
								savedData[difficulty][dungeonEncounterID] = savedData[difficulty][dungeonEncounterID] or {}
								tinsert(savedData[difficulty][dungeonEncounterID], encounterKillInfo)

								if (_G.DetailsRaidHistoryWindow and _G.DetailsRaidHistoryWindow:IsShown()) then
									_G.DetailsRaidHistoryWindow:Refresh()
								end

								addedAmount = addedAmount + 1
							else
								if (Details.debug) then
									Details:Msg("(debug) [RoC-AddGuildSyncData] received a duplicated encounter table.")
								end
							end
						else
							if (Details.debug) then
								Details:Msg("(debug) [RoC-AddGuildSyncData] received an invalid encounter table.")
							end
						end
					end
				end
			end
		end
	end

	if (Details.debug) then
		Details:Msg("(debug) [RoC-AddGuildSyncData] added " .. addedAmount .. " to database.")
	end

	if (_G.DetailsRaidHistoryWindow and _G.DetailsRaidHistoryWindow:IsShown()) then
		_G.DetailsRaidHistoryWindow:UpdateDropdowns()
		_G.DetailsRaidHistoryWindow:Refresh()
	end
end

---@param difficulty string
---@return encounterid[]
function Details222.storage.ListEncounters(difficulty)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return {}
	end

	if (not difficulty) then
		return {}
	end

	---@type encounterid[]
	local resultTable = {}

	local encountersTable = savedData[difficulty]
	if (encountersTable) then
		for dungeonEncounterID in pairs(encountersTable) do
			tinsert(resultTable, dungeonEncounterID)
		end
	end

	return resultTable
end

---@param difficulty string
---@param dungeonEncounterID encounterid
---@param role role
---@param unitName actorname
---@return details_storage_unitresult[]
function Details222.storage.GetUnitData(difficulty, dungeonEncounterID, role, unitName)
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return {}
	end

	assert(type(unitName) == "string", "unitName must be a string.")
	assert(type(dungeonEncounterID) == "number", "dungeonEncounterID must be a string.")

	---@type details_storage_unitresult[]
	local resultTable = {}

	---@type details_encounterkillinfo[]
	local encountersTable = savedData[difficulty]
	if (encountersTable) then
		local allEncountersStored = encountersTable[dungeonEncounterID]
		if (allEncountersStored) then
			for i = 1, #allEncountersStored do
				---@type details_encounterkillinfo
				local encounterKillInfo = allEncountersStored[i]
				local playerData = encounterKillInfo[role][unitName]
				if (playerData) then
					tinsert(resultTable, playerData)
				end
			end
		end
	end

	return resultTable
end

---return a table with all encounters saved for a specific guild in a specific difficulty for a specific encounter
---@param difficulty string
---@param dungeonEncounterID encounterid
---@param guildName guildname
---@return details_encounterkillinfo[]
function Details222.storage.GetEncounterData(difficulty, dungeonEncounterID, guildName)
	---@type details_storage?
	local savedData = Details222.storage.OpenRaidStorage()

	if (not savedData) then
		return
	end

	local encountersTable = savedData[difficulty]

	assert(encountersTable, "Difficulty not found. Use: normal, heroic or mythic.")
	assert(type(dungeonEncounterID) == "number", "dungeonEncounterID must be a number.")

	---@type details_encounterkillinfo[]
	local allEncountersStored = encountersTable[dungeonEncounterID]

	local resultTable = {}

	if (not allEncountersStored) then
		return resultTable
	end

	for i = 1, #allEncountersStored do
		local encounterKillInfo = allEncountersStored[i]
		if (encounterKillInfo.guild == guildName) then
			tinsert(resultTable, encounterKillInfo)
		end
	end

	return resultTable
end

---load the storage addon when the player leave combat, this function is also called from the parser when the player has its regen enabled
function Details.ScheduleLoadStorage()
	--check first if the storage is already loaded
	if (IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
		Details.schedule_storage_load = nil
		Details222.storageLoaded = true
		return
	end

	if (InCombatLockdown() or UnitAffectingCombat("player")) then
		if (Details.debug) then
			print("|cFFFFFF00Details! storage scheduled to load (player in combat).")
		end
		--load when the player leave combat
		Details.schedule_storage_load = true
		return
	else
		if (not IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
			local bSuccessLoaded, reason = LoadAddOn(CONST_ADDONNAME_DATASTORAGE)
			if (not bSuccessLoaded) then
				if (Details.debug) then
					print("|cFFFFFF00Details! Storage|r: can't load storage, may be the addon is disabled.")
				end
				return
			end
			createStorageTables()
		end
	end

	if (IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
		Details.schedule_storage_load = nil
		Details222.storageLoaded = true
		if (Details.debug) then
			print("|cFFFFFF00Details! storage loaded.")
		end
	else
		if (Details.debug) then
			print("|cFFFFFF00Details! fail to load storage, scheduled once again.")
		end
		Details.schedule_storage_load = true
	end
end

function Details.GetStorage()
	return DetailsDataStorage
end

--this function is used on the breakdown window to show ranking and on the main window when hovering over the spec icon
--if the storage is not loaded, it will try to load it even if the player is in combat
function Details.OpenStorage()
	--if the player is in combat, this function return false, if failed to load by other reason it returns nil
	--check if the storage is already loaded
	if (not IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
		--can't open it during combat
		if (InCombatLockdown() or UnitAffectingCombat("player")) then
			if (Details.debug) then
				print("|cFFFFFF00Details! Storage|r: can't load storage due to combat.")
			end
			return false
		end

		local loaded, reason = LoadAddOn(CONST_ADDONNAME_DATASTORAGE)
		if (not loaded) then
			if (Details.debug) then
				print("|cFFFFFF00Details! Storage|r: can't load storage, may be the addon is disabled.")
			end
			return
		end

		local savedData = createStorageTables()

		if (savedData and IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
			Details222.storageLoaded = true
		end

		return DetailsDataStorage
	else
		return DetailsDataStorage
	end
end

Details.Database = {}

--this function is called on storewipe and storeencounter
---@return details_storage?
function Details.Database.LoadDB()
	--check if the storage is not loaded yet and try to load it
	if (not IsAddOnLoaded(CONST_ADDONNAME_DATASTORAGE)) then
		local loaded, reason = LoadAddOn(CONST_ADDONNAME_DATASTORAGE)
		if (not loaded) then
			if (Details.debug) then
				print("|cFFFFFF00Details! Storage|r: can't save the encounter, couldn't load DataStorage, may be the addon is disabled.")
			end
			return
		end
	end

	--get the storage table
	local savedData = _G.DetailsDataStorage

	if (not savedData and Details.CreateStorageDB) then
		savedData = Details:CreateStorageDB()
		if (not savedData) then
			if (Details.debug) then
				print("|cFFFFFF00Details! Storage|r: can't save the encounter, couldn't load DataStorage, may be the addon is disabled.")
			end
			return
		end

	elseif (not savedData) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: can't save the encounter, couldn't load DataStorage, may be the addon is disabled.")
		end
		return
	end

	return savedData
end

---@param savedData details_storage
function Details.Database.GetBossKillsDB(savedData)
	return savedData.totalkills
end

---@param combat combat?
function Details.Database.StoreWipe(combat)
	if (not combat) then
		combat = Details:GetCurrentCombat()
	end

	if (not combat) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: combat not found.")
		end
		return
	end

	local _, _, _, _, _, _, _, mapID = GetInstanceInfo()

	if (not Details:IsZoneIdFromCurrentExpansion(mapID) and not Details222.storage.IsDebug) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: instance not allowed.") --again
		end
		return
	end

	local bossInfo = combat:GetBossInfo()
	local dungeonEncounterID = bossInfo and bossInfo.id

	if (not dungeonEncounterID) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: encounter ID not found.")
		end
		return
	end

	--get the difficulty
	local _, difficulty = combat:GetDifficulty()

	--load database
	---@type details_storage?
	local savedData = Details.Database.LoadDB()
	if (not savedData) then
		return
	end

	if (IsInRaid()) then
		--total kills in a boss on raid or dungeon
		local totalKillsDataBase = Details.Database.GetBossKillsDB(savedData)

		totalKillsDataBase[difficulty] = totalKillsDataBase[difficulty] or {}
		totalKillsDataBase[difficulty][dungeonEncounterID] = totalKillsDataBase[difficulty][dungeonEncounterID] or {
			kills = 0,
			wipes = 0,
			time_fasterkill = 0,
			time_fasterkill_when = 0,
			time_incombat = 0,
			dps_best = 0,
			dps_best_when = 0,
			dps_best_raid = 0,
			dps_best_raid_when = 0
		}

		local bossData = totalKillsDataBase[difficulty][dungeonEncounterID]
		bossData.wipes = bossData.wipes + 1
	end
end

---@param combat combat
function Details.Database.StoreEncounter(combat)
	combat = combat or Details:GetCurrentCombat()
print(1)
	if (not combat) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: combat not found.")
		end
		return
	end

	local _, _, _, _, _, _, _, mapID = GetInstanceInfo()

	--Details:IsZoneIdFromCurrentExpansion(select(8, GetInstanceInfo()))

	if (not Details:IsZoneIdFromCurrentExpansion(mapID) and not Details222.storage.IsDebug) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: instance not allowed.")
		end
		return
	end
	print(2)
	local encounterInfo = combat:GetBossInfo()
	local encounterId = encounterInfo and encounterInfo.id

	if (not encounterId) then
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: encounter ID not found.")
		end
		return
	end

	--get the difficulty
	local diffId, diff = combat:GetDifficulty()

	--database
	---@type details_storage?
	local savedData = Details.Database.LoadDB()
	if (not savedData) then
		return
	end
	print(3)
	--[=[
		savedData[mythic] = {
			[encounterId] = { --indexed table
				[1] = { 
					DAMAGER = {
						[actorname] = details_storage_unitresult
					},
					HEALER = {
						[actorname] = details_storage_unitresult
					},
					date = date("%H:%M %d/%m/%y"),
					time = time(),
					servertime = GetServerTime(),
					elapsed = combat:GetCombatTime(),
					guild = guildName,
				}
			}
		}
	--]=]

	---@type combattime
	local elapsedCombatTime = combat:GetCombatTime()

	---@type table<encounterid, details_encounterkillinfo[]>
	local encountersTable = savedData[diff]
	if (not encountersTable) then
		savedData[diff] = {}
		encountersTable = savedData[diff]
	end

	---@type details_encounterkillinfo[]
	local allEncountersStored = encountersTable[encounterId]
	if (not allEncountersStored) then
		encountersTable[encounterId] = {}
		allEncountersStored = encountersTable[encounterId]
	end

	--total kills in a boss on raid or dungeon
	local totalkillsTable = Details.Database.GetBossKillsDB(savedData)
	
	--store total kills on this boss
	--if the player is facing a raid boss
	if (IsInRaid()) then
		totalkillsTable[encounterId] = totalkillsTable[encounterId] or {}
		totalkillsTable[encounterId][diff] = totalkillsTable[encounterId][diff] or {
			kills = 0,
			wipes = 0,
			time_fasterkill = 1000000,
			time_fasterkill_when = 0,
			time_incombat = 0,
			dps_best = 0, --player best dps
			dps_best_when = 0, --when the player did the best dps
			dps_best_raid = 0,
			dps_best_raid_when = 0
		}
		print(4)
		---@type details_bosskillinfo
		local bossData = totalkillsTable[encounterId][diff]
		---@type combattime
		local encounterElapsedTime = elapsedCombatTime

		--kills amount
		bossData.kills = bossData.kills + 1

		--best time
		if (encounterElapsedTime < bossData.time_fasterkill) then
			bossData.time_fasterkill = encounterElapsedTime
			bossData.time_fasterkill_when = time()
		end

		--total time in combat
		bossData.time_incombat = bossData.time_incombat + encounterElapsedTime

		--player best dps
		---@actor
		local playerActorObject = combat(DETAILS_ATTRIBUTE_DAMAGE, Details.playername)
		if (playerActorObject) then
			local playerDps = playerActorObject.total / encounterElapsedTime
			if (playerDps > bossData.dps_best) then
				bossData.dps_best = playerDps
				bossData.dps_best_when = time()
			end
		end

		--raid best dps
		local raidTotalDamage = combat:GetTotal(DETAILS_ATTRIBUTE_DAMAGE, nil, true)
		local raidDps = raidTotalDamage / encounterElapsedTime
		if (raidDps > bossData.dps_best_raid) then
			bossData.dps_best_raid = raidDps
			bossData.dps_best_raid_when = time()
		end
	end
	print(5, diff)
	--check for heroic and mythic
	if (Details222.storage.IsDebug or Details222.storage.DiffNamesHash[diff]) then
		--check the guild name
		local match = 0
		local guildName = GetGuildInfo("player")
		local raidSize = GetNumGroupMembers() or 0

		local cachedUnitIds = Details222.UnitIdCache.Raid

		if (not Details222.storage.IsDebug) then
			if (guildName) then
				for i = 1, raidSize do
					local gName = GetGuildInfo(cachedUnitIds[i]) or ""
					if (gName == guildName) then
						match = match + 1
					end
				end

				if (match < raidSize * 0.75) then
					if (Details.debug) then
						print("|cFFFFFF00Details! Storage|r: can't save the encounter, need at least 75% of players be from your guild.")
					end
					return
				end
			else
				if (Details.debug) then
					print("|cFFFFFF00Details! Storage|r: player isn't in a guild.")
				end
				return
			end
		else
			guildName = "Test Guild"
		end

		---@type details_encounterkillinfo
		local combatResultData = {
			DAMAGER = {},
			HEALER = {},
			date = date("%H:%M %d/%m/%y"),
			time = time(),
			servertime = GetServerTime(),
			elapsed = elapsedCombatTime,
			guild = guildName,
		}

		local damageContainer = combat:GetContainer(DETAILS_ATTRIBUTE_DAMAGE)
		local healingContainer = combat:GetContainer(DETAILS_ATTRIBUTE_HEAL)

		print(6, diff)

		for i = 1, GetNumGroupMembers() do
			local role = UnitGroupRolesAssigned(cachedUnitIds[i])

			if (UnitIsInMyGuild(cachedUnitIds[i])) then
				if (role == "NONE" or role == "DAMAGER" or role == "TANK") then
					local playerName = Details:GetFullName(cachedUnitIds[i])
					local _, _, class = Details:GetUnitClassFull(playerName)

					local damagerActor = damageContainer:GetActor(playerName)
					if (damagerActor) then
						local guid = UnitGUID(cachedUnitIds[i])

						---@type details_storage_unitresult
						local unitResultInfo = {
							total = floor(damagerActor.total),
							itemLevel = Details:GetItemLevelFromGuid(guid),
							classId = class or 0
						}
						combatResultData.DAMAGER[playerName] = unitResultInfo
					end

				elseif (role == "HEALER" or role == "SUPPORT") then
					local playerName = Details:GetFullName(cachedUnitIds[i])
					local _, _, class = Details:GetUnitClassFull(playerName)

					local healingActor = healingContainer:GetActor(playerName)
					if (healingActor) then
						local guid = UnitGUID(cachedUnitIds[i])

						---@type details_storage_unitresult
						local unitResultInfo = {
							total = floor(healingActor.total),
							itemLevel = Details:GetItemLevelFromGuid(guid),
							classId = class or 0
						}
						combatResultData.HEALER[playerName] = unitResultInfo
					end
				end
			end
		end

		print(7, diff)

		--add the encounter data
		tinsert(allEncountersStored, combatResultData)
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: combat data added to encounter database.")
		end

		local playerRole = UnitGroupRolesAssigned("player")
		---@type details_storage_unitresult, details_encounterkillinfo
		local bestRank, encounterKillInfo = Details222.storage.GetBestFromPlayer(diff, encounterId, playerRole, Details.playername, true) --get dps or hps

		if (bestRank and encounterKillInfo) then
			local registeredBestTotal = bestRank and bestRank.total or 0
			local registeredBestPerSecond = registeredBestTotal / encounterKillInfo.elapsed

			local currentPerSecond = 0
			if (playerRole == "DAMAGER" or playerRole == "TANK") then
				---@actor
				local playerActorObject = damageContainer:GetActor(Details.playername)
				if (playerActorObject) then
					currentPerSecond = playerActorObject.total / elapsedCombatTime
				end
			elseif (playerRole == "HEALER") then
				---@actor
				local playerActorObject = healingContainer:GetActor(Details.playername)
				if (playerActorObject) then
					currentPerSecond = playerActorObject.total / elapsedCombatTime
				end
			end

			if (registeredBestPerSecond > currentPerSecond) then
				if (not Details.deny_score_messages) then
					print(Loc ["STRING_DETAILS1"] .. format(Loc ["STRING_SCORE_NOTBEST"], Details:ToK2(currentPerSecond), Details:ToK2(registeredBestPerSecond), encounterKillInfo.date, bestRank[2]))
				end
			else
				if (not Details.deny_score_messages) then
					print(Loc ["STRING_DETAILS1"] .. format(Loc ["STRING_SCORE_BEST"], Details:ToK2(currentPerSecond)))
				end
			end
		end

		local lowerInstanceId = Details:GetLowerInstanceNumber()
		if (lowerInstanceId) then
			local instanceObject = Details:GetInstance(lowerInstanceId)
			if (instanceObject) then
				if (playerRole == "TANK") then
					playerRole = "DAMAGER"
				end

				local raidName = GetInstanceInfo()
				local func = {Details.OpenRaidHistoryWindow, Details, raidName, encounterId, diff, playerRole, guildName}
				local icon = {[[Interface\PvPRankBadges\PvPRank08]], 16, 16, false, 0, 1, 0, 1}
				if (not Details.deny_score_messages) then
					instanceObject:InstanceAlert(Loc ["STRING_GUILDDAMAGERANK_WINDOWALERT"], icon, Details.update_warning_timeout, func, true)
				end
			end
		end
	else
		if (Details.debug) then
			print("|cFFFFFF00Details! Storage|r: raid difficulty must be heroic or mythic.")
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--inspect stuff

Details.ilevel = {}
local ilvl_core = Details:CreateEventListener()
ilvl_core.amt_inspecting = 0
Details.ilevel.core = ilvl_core

ilvl_core:RegisterEvent("GROUP_ONENTER", "OnEnter")
ilvl_core:RegisterEvent("GROUP_ONLEAVE", "OnLeave")
ilvl_core:RegisterEvent("COMBAT_PLAYER_ENTER", "EnterCombat")
ilvl_core:RegisterEvent("COMBAT_PLAYER_LEAVE", "LeaveCombat")
ilvl_core:RegisterEvent("ZONE_TYPE_CHANGED", "ZoneChanged")

local inspecting = {}
ilvl_core.forced_inspects = {}

function ilvl_core:HasQueuedInspec(unitName)
	local guid = UnitGUID(unitName)
	if (guid) then
		return ilvl_core.forced_inspects [guid]
	end
end

local inspect_frame = CreateFrame("frame")
inspect_frame:RegisterEvent("INSPECT_TALENT_READY")

local two_hand = {
	["INVTYPE_2HWEAPON"] = true,
 	["INVTYPE_RANGED"] = true,
	["INVTYPE_RANGEDRIGHT"] = true,
}

local MAX_INSPECT_AMOUNT = 1
local MIN_ILEVEL_TO_STORE = 1
local LOOP_TIME = 7

function Details:IlvlFromNetwork(player, realm, core, serialNumber, itemLevel, talentsSelected, currentSpec)
	if (Details.debug and false) then
		local talents = "Invalid Talents"
		if (type(talentsSelected) == "table") then
			talents = ""
			for i = 1, #talentsSelected do
				talents = talents .. talentsSelected [i] .. ","
			end
		end
		Details222.DebugMsg("Received PlayerInfo Data: " ..(player or "Invalid Player Name") .. " | " ..(itemLevel or "Invalid Item Level") .. " | " ..(currentSpec or "Invalid Spec") .. " | " .. talents  .. " | " ..(serialNumber or "Invalid Serial"))
	end

	if (not player) then
		return
	end

	--older versions of details wont send serial nor talents nor spec
	if (not serialNumber or not itemLevel or not talentsSelected or not currentSpec) then
		--if any data is invalid, abort
		return
	end

	--won't inspect this actor
	Details.trusted_characters[serialNumber] = true

	if (type(serialNumber) ~= "string") then
		return
	end

	--store the item level
	if (type(itemLevel) == "number") then
		Details.item_level_pool[serialNumber] = {name = player, ilvl = itemLevel, time = time()}
	end

	--store talents
	if (type(talentsSelected) == "table") then
		if (talentsSelected[1]) then
			Details.cached_talents[serialNumber] = talentsSelected
		end

	elseif (type(talentsSelected) == "string" and talentsSelected ~= "") then
		Details.cached_talents[serialNumber] = talentsSelected
	end

	--store the spec the player is playing
	if (type(currentSpec) == "number") then
		Details.cached_specs[serialNumber] = currentSpec
	end
end

--test
--/run _detalhes.ilevel:CalcItemLevel("player", UnitGUID("player"), true)
--/run wipe(_detalhes.item_level_pool)

function ilvl_core:CalcItemLevel(unitid, guid, shout)

	if (type(unitid) == "table") then
		shout = unitid [3]
		guid = unitid [2]
		unitid = unitid [1]
	end

	--disable due to changes to CheckInteractDistance()
	if (not InCombatLockdown() and unitid and UnitPlayerControlled(unitid) and CheckInteractDistance(unitid, CONST_INSPECT_ACHIEVEMENT_DISTANCE) and CanInspect(unitid)) then
		local average = UnitAverageItemLevel(unitid)
		--register
		if (average > 0) then
			if (shout) then
				Details:Msg(UnitName(unitid) .. " item level: " .. average)
			end

			if (average > MIN_ILEVEL_TO_STORE) then
				local unitName = Details:GetFullName(unitid)
				Details.item_level_pool [guid] = {name = unitName, ilvl = average, time = time()}
			end
		end

		--------------------------------------------------------------------------------------------------------

		if (ilvl_core.forced_inspects [guid]) then
			if (type(ilvl_core.forced_inspects [guid].callback) == "function") then
				local okey, errortext = pcall(ilvl_core.forced_inspects[guid].callback, guid, unitid, ilvl_core.forced_inspects[guid].param1, ilvl_core.forced_inspects[guid].param2)
				if (not okey) then
					Details:Msg("Error on QueryInspect callback: " .. errortext)
				end
			end
			ilvl_core.forced_inspects [guid] = nil
		end

		--------------------------------------------------------------------------------------------------------

	end
end

Details.ilevel.CalcItemLevel = ilvl_core.CalcItemLevel

inspect_frame:SetScript("OnEvent", function(self, event, ...)
	local guid
	for queue_guid in pairs(inspecting) do -- get first guid
		guid = queue_guid
		break
	end

	if not guid or guild == "" then
		return
 	end

	if (inspecting [guid]) then
		local unitid, cancel_tread = inspecting [guid] [1], inspecting [guid] [2]
		inspecting [guid] = nil
		ilvl_core.amt_inspecting = ilvl_core.amt_inspecting - 1

		ilvl_core:CancelTimer(cancel_tread)

		--do inspect stuff
		if (unitid) then
			local t = {unitid, guid}
			--ilvl_core:ScheduleTimer("CalcItemLevel", 0.5, t)
			ilvl_core:ScheduleTimer("CalcItemLevel", 0.5, t)
			ilvl_core:ScheduleTimer("CalcItemLevel", 2, t)
			ilvl_core:ScheduleTimer("CalcItemLevel", 4, t)
			ilvl_core:ScheduleTimer("CalcItemLevel", 8, t)
		end
	else
		if (IsInRaid()) then
			--get the unitID
			local serial = ...
			if (serial and type(serial) == "string") then
				for i = 1, GetNumGroupMembers() do
					if (UnitGUID("raid" .. i) == serial) then
						ilvl_core:ScheduleTimer("CalcItemLevel", 2, {"raid" .. i, serial})
						ilvl_core:ScheduleTimer("CalcItemLevel", 4, {"raid" .. i, serial})
					end
				end
			end
		end
	end
end)

function ilvl_core:InspectTimeOut(guid)
	inspecting [guid] = nil
	ilvl_core.amt_inspecting = ilvl_core.amt_inspecting - 1
end

function ilvl_core:ReGetItemLevel(t)
	local unitid, guid, is_forced, try_number = unpack(t)
	return ilvl_core:GetItemLevel(unitid, guid, is_forced, try_number)
end

function ilvl_core:GetItemLevel(unitid, guid, is_forced, try_number)
	--ddouble check
	if (not is_forced and (UnitAffectingCombat("player") or InCombatLockdown())) then
		return
	end

	if UnitIsUnit(unitid, "player") then
		ilvl_core:CalcItemLevel(unitid, guid)
		return
	end

	if (AscensionInspectFrame and AscensionInspectFrame:IsShown() or InCombatLockdown() or not unitid or not CanInspect(unitid) or not UnitPlayerControlled(unitid) or not CheckInteractDistance(unitid, CONST_INSPECT_ACHIEVEMENT_DISTANCE)) then
		if (is_forced) then
			try_number = try_number or 0
			if (try_number > 18) then
				return
			else
				try_number = try_number + 1
			end
			ilvl_core:ScheduleTimer("ReGetItemLevel", 3, {unitid, guid, is_forced, try_number})
		end
		return
	end

	inspecting [guid] = {unitid, ilvl_core:ScheduleTimer("InspectTimeOut", 12, guid)}
	ilvl_core.amt_inspecting = ilvl_core.amt_inspecting + 1

	NotifyInspect(unitid)
end

local NotifyInspectHook = function(unitid) --not in use
	local unit = unitid:gsub("%d+", "")

	if ((IsInRaid() or IsInGroup()) and(Details:GetZoneType() == "raid" or Details:GetZoneType() == "party")) then
		local guid = UnitGUID(unitid)
		local name = Details:GetFullName(unitid)
		if (guid and name and not inspecting [guid]) then
			for i = 1, GetNumGroupMembers()-1 do
				if (name == Details:GetFullName(unit .. i)) then
					unitid = unit .. i
					break
				end
			end

			inspecting [guid] = {unitid, ilvl_core:ScheduleTimer("InspectTimeOut", 12, guid)}
			ilvl_core.amt_inspecting = ilvl_core.amt_inspecting + 1
		end
	end
end
hooksecurefunc("NotifyInspect", NotifyInspectHook)

function ilvl_core:Reset()
	ilvl_core.raid_id = 1
	ilvl_core.amt_inspecting = 0

	for guid, t in pairs(inspecting) do
		ilvl_core:CancelTimer(t[2])
		inspecting [guid] = nil
	end
end

function ilvl_core:QueryInspect(unitName, callback, param1)
	local unitid

	if (IsInRaid()) then
		for i = 1, GetNumGroupMembers() do
			if (Details:GetFullName("raid" .. i, "none") == unitName) then
				unitid = "raid" .. i
				break
			end
		end
	elseif (IsInGroup()) then
		for i = 1, GetNumGroupMembers()-1 do
			if (Details:GetFullName("party" .. i, "none") == unitName) then
				unitid = "party" .. i
				break
			end
		end
		if not unitid then -- player
			unitid = unitName
		end
	else
		unitid = unitName
	end

	if (not unitid) then
		return false
	end

	local guid = UnitGUID(unitid)
	if (not guid) then
		return false
	elseif (ilvl_core.forced_inspects [guid]) then
		return true
	end

	if (inspecting [guid]) then
		return true
	end

	ilvl_core.forced_inspects [guid] = {callback = callback, param1 = param1}
	ilvl_core:GetItemLevel(unitid, guid, true)

	if (ilvl_core.clear_queued_list) then
		ilvl_core:CancelTimer(ilvl_core.clear_queued_list)
	end
	ilvl_core.clear_queued_list = ilvl_core:ScheduleTimer("ClearQueryInspectQueue", 60)

	return true
end

function ilvl_core:ClearQueryInspectQueue()
	Details:Destroy(ilvl_core.forced_inspects)
	ilvl_core.clear_queued_list = nil
end

function ilvl_core:Loop()
	if (ilvl_core.amt_inspecting >= MAX_INSPECT_AMOUNT) then
		return
	end

	local members_amt = GetNumGroupMembers()
	if (ilvl_core.raid_id > members_amt) then
		ilvl_core.raid_id = 1
	end

	local unitid
	if (IsInRaid()) then
		unitid = "raid" .. ilvl_core.raid_id
	elseif (IsInGroup()) then
		unitid = "party" .. ilvl_core.raid_id
	else
		return
	end

	local guid = UnitGUID(unitid)
	if (not guid) then
		ilvl_core.raid_id = ilvl_core.raid_id + 1
		return
	end

	--if already inspecting or the actor is in the list of trusted actors
	if (inspecting [guid] or Details.trusted_characters [guid]) then
		return
	end

	local ilvl_table = Details.ilevel:GetIlvl(guid)
	if (ilvl_table and ilvl_table.time + 3600 > time()) then
		ilvl_core.raid_id = ilvl_core.raid_id + 1
		return
	end

	ilvl_core:GetItemLevel(unitid, guid)
	ilvl_core.raid_id = ilvl_core.raid_id + 1
end

function ilvl_core:EnterCombat()
	if (ilvl_core.loop_process) then
		ilvl_core:CancelTimer(ilvl_core.loop_process)
		ilvl_core.loop_process = nil
	end
end

local can_start_loop = function()
	if ((_detalhes:GetZoneType() ~= "raid" and _detalhes:GetZoneType() ~= "party") or ilvl_core.loop_process or _detalhes.in_combat or not _detalhes.track_item_level) then
		return false
	end
	return true
end

function ilvl_core:LeaveCombat()
	if (can_start_loop()) then
		ilvl_core:Reset()
		ilvl_core.loop_process = ilvl_core:ScheduleRepeatingTimer("Loop", LOOP_TIME)
	end
end

function ilvl_core:ZoneChanged(zone_type)
	if (can_start_loop()) then
		ilvl_core:Reset()
		ilvl_core.loop_process = ilvl_core:ScheduleRepeatingTimer("Loop", LOOP_TIME)
	end
end

function ilvl_core:OnEnter()
	if (IsInRaid()) then
		Details:SendCharacterData()
	end

	if (can_start_loop()) then
		ilvl_core:Reset()
		ilvl_core.loop_process = ilvl_core:ScheduleRepeatingTimer("Loop", LOOP_TIME)
	end
end

function ilvl_core:OnLeave()
	if (ilvl_core.loop_process) then
		ilvl_core:CancelTimer(ilvl_core.loop_process)
		ilvl_core.loop_process = nil
	end
end

--ilvl API
function Details.ilevel:IsTrackerEnabled()
	return Details.track_item_level
end
function Details.ilevel:TrackItemLevel(bool)
	if (type(bool) == "boolean") then
		if (bool) then
			Details.track_item_level = true
			if (can_start_loop()) then
				ilvl_core:Reset()
				ilvl_core.loop_process = ilvl_core:ScheduleRepeatingTimer("Loop", LOOP_TIME)
			end
		else
			Details.track_item_level = false
			if (ilvl_core.loop_process) then
				ilvl_core:CancelTimer(ilvl_core.loop_process)
				ilvl_core.loop_process = nil
			end
		end
	end
end

function Details.ilevel:GetPool()
	return Details.item_level_pool
end

function Details:GetItemLevelFromGuid(guid)
	return Details.item_level_pool[guid] and Details.item_level_pool[guid].ilvl or 0
end

function Details.ilevel:GetIlvl(guid)
	return Details.item_level_pool[guid]
end

function Details.ilevel:GetInOrder()
	local order = {}

	for guid, t in pairs(Details.item_level_pool) do
		order[#order+1] = {t.name, t.ilvl or 0, t.time}
	end

	table.sort(order, Details.Sort2)

	return order
end

function Details.ilevel:ClearIlvl(guid)
	Details.item_level_pool[guid] = nil
end

function Details:GetTalents(guid)
	return Details.cached_talents [guid]
end

function Details:GetSpecFromSerial(guid)
	return Details.cached_specs [guid]
end

--------------------------------------------------------------------------------------------------------------------------------------------
--compress data

-- ~compress ~zip ~export ~import ~deflate ~serialize
function Details:CompressData(data, dataType)
	local LibDeflate = LibStub:GetLibrary("LibDeflate")
	local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

	--check if there isn't funtions in the data to export
	local dataCopied = DetailsFramework.table.copytocompress({}, data)

	if (LibDeflate and LibAceSerializer) then
		local dataSerialized = LibAceSerializer:Serialize(dataCopied)
		if (dataSerialized) then
			local dataCompressed = LibDeflate:CompressDeflate(dataSerialized, {level = 9})
			if (dataCompressed) then
				if (dataType == "print") then
					local dataEncoded = LibDeflate:EncodeForPrint(dataCompressed)
					return dataEncoded

				elseif (dataType == "comm") then
					local dataEncoded = LibDeflate:EncodeForWoWAddonChannel(dataCompressed)
					return dataEncoded
				end
			end
		end
	end
end

function Details:DecompressData(data, dataType)
	local LibDeflate = LibStub:GetLibrary("LibDeflate")
	local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

	if (LibDeflate and LibAceSerializer) then

		local dataCompressed

		if (dataType == "print") then

			data = DetailsFramework:Trim(data)

			dataCompressed = LibDeflate:DecodeForPrint(data)
			if (not dataCompressed) then
				Details:Msg("couldn't decode the data.")
				return false
			end

		elseif (dataType == "comm") then
			dataCompressed = LibDeflate:DecodeForWoWAddonChannel(data)
			if (not dataCompressed) then
				Details:Msg("couldn't decode the data.")
				return false
			end
		end
		local dataSerialized = LibDeflate:DecompressDeflate(dataCompressed)

		if (not dataSerialized) then
			Details:Msg("couldn't uncompress the data.")
			return false
		end

		local okay, data = LibAceSerializer:Deserialize(dataSerialized)
		if (not okay) then
			Details:Msg("couldn't unserialize the data.")
			return false
		end

		return data
	end
end

local function GetRoleFromSpecInfo(specInfo)
	if specInfo.Healer then
		return "HEALER"
	elseif specInfo.Tank then
		return "TANK"
	else
		return "DAMAGER"
	end
end

Details.specToRole = {}
Details.validSpecIds = {}

Details.textureToSpec = {}
Details.specToTexture = {}

for _, class in ipairs(CLASS_SORT_ORDER) do
    local specs = C_ClassInfo.GetAllSpecs(class)
    for _, spec in ipairs(specs) do
        local specInfo = C_ClassInfo.GetSpecInfo(class, spec)
		local thumbnail = ClassTalentUtil.GetThumbnailAtlas(class, spec)
		Details.validSpecIds[specInfo.ID] = true
        Details.specToRole[specInfo.ID] = GetRoleFromSpecInfo(specInfo)
		Details.textureToSpec[thumbnail] = specInfo.ID
		Details.specToTexture[specInfo.ID] = thumbnail
    end
end

--oldschool talent tree
do
	function _detalhes:GetRoleFromSpec(specId)
		return Details.specToRole [specId] or "NONE"
	end
	
	function Details.IsValidSpecId(specId)
		return Details.validSpecIds [specId]
	end

	function Details.GetClassicSpecByTalentTexture(talentTexture)
		return Details.textureToSpec [talentTexture] or nil
	end
end

--fill the passed table with spells from talents and spellbook, affect only the active spec
function Details.FillTableWithPlayerSpells(completeListOfSpells)
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
end

function Details.SavePlayTimeOnClass()
	local className = select(2, UnitClass("player"))
	if (className) then
		--played time by  expansion
		local expansionLevel = GetExpansionLevel()

		local expansionTable = Details.class_time_played[expansionLevel]
		if (not expansionTable) then
			expansionTable = {}
			Details.class_time_played[expansionLevel] = expansionTable
		end

		local playedTime = expansionTable[className] or 0
		expansionTable[className] = playedTime + GetTime() - Details.GetStartupTime()
	end
end

function Details.GetPlayTimeOnClass()
	local className = select(2, UnitClass("player"))
	if (className) then
		--played time by  expansion
		local expansionLevel = GetExpansionLevel()

		local expansionTable = Details.class_time_played[expansionLevel]
		if (not expansionTable) then
			expansionTable = {}
			Details.class_time_played[expansionLevel] = expansionTable
		end

		local playedTime = expansionTable[className]
		if (playedTime) then
			playedTime = playedTime +(GetTime() - Details.GetStartupTime())
			return playedTime
		end
	end
	return 0
end

function Details.GetPlayTimeOnClassString()
    local playedTime = Details.GetPlayTimeOnClass()
    local days = floor(playedTime / 86400) .. " days"
    playedTime = playedTime % 86400
    local hours = floor(playedTime / 3600) .. " hours"
    playedTime = playedTime % 3600
    local minutes = floor(playedTime / 60) .. " minutes"

	local expansionLevel = GetExpansionLevel()
	local expansionName = _G["EXPANSION_NAME" .. GetExpansionLevel()]

    return "|cffffff00Time played this class(" .. expansionName .. "): " .. days .. " " .. hours .. " " .. minutes
end

hooksecurefunc("ChatFrame_DisplayTimePlayed", function()
	if (Details.played_class_time) then
		C_Timer.After(0, function()
			print(Details.GetPlayTimeOnClassString() .. " \ncommand: /details playedclass")
		end)
	end
end)

--game freeze prevention, there are people calling UpdateAddOnMemoryUsage() making the game client on the end user to freeze, this is bad, really bad.
--Details! replace the function call with one that do the same thing, but warns the player if the function freezes the client too many times.
--this feature is disabled by default, to enable it, type /run Details.check_stuttering = true and reload the game
local stutterCounter = 0
local bigStutterCounter = 0
local UpdateAddOnMemoryUsage_Original = _G.UpdateAddOnMemoryUsage
Details.UpdateAddOnMemoryUsage_Original = _G.UpdateAddOnMemoryUsage

Details.UpdateAddOnMemoryUsage_Custom = function()
	local currentTime = debugprofilestop()
	UpdateAddOnMemoryUsage_Original()
	local deltaTime = debugprofilestop() - currentTime

	if (deltaTime > 16) then
		local callStack = debugstack(2, 0, 4)
		--ignore if is coming from the micro menu tooltip
		if (callStack:find("MainMenuBarPerformanceBarFrame_OnEnter")) then
			return
		end

		if (deltaTime >= 500) then
			bigStutterCounter = bigStutterCounter + 1
			if (bigStutterCounter >= 6) then
				Details:Msg("an addon made your game freeze for more than a half second, use '/details perf' to know more.")
				bigStutterCounter = -10000 --make this msg appear only once
			end
		end

		stutterCounter = stutterCounter + 1
		local stutterDegree = 0
		if (stutterCounter > 60) then
			if (deltaTime < 48) then
				Details:Msg("some addon may be causing small framerate stuttering, use '/details perf' to know more.")
				stutterDegree = 1

			elseif (deltaTime <= 100) then
				Details:Msg("some addon may be causing framerate drops, use '/details perf' to know more.")
				stutterDegree = 2

			else
				Details:Msg("some addon might be causing performance issues, use '/details perf' to know more.")
				stutterDegree = 3
			end

			stutterCounter = -10000  --make this msg appear only once
		end

		Details.performanceData = {
			deltaTime = deltaTime,
			callStack = callStack,
			culpritFunc = "_G.UpdateAddOnMemoryUsage()",
			culpritDesc = "Calculates memory usage of addons",
		}
	end
end

Details.performanceData = {
	deltaTime = 0,
	callStack = "",
	culpritFunc = "",
	culpritDesc = "",
}

function CopyText(text) --[[GLOBAL]]
	if (not Details.CopyTextField) then
		Details.CopyTextField = CreateFrame("Frame", "DetailsCopyText", UIParent, "BackdropTemplate")
		Details.CopyTextField:SetHeight(14)
		Details.CopyTextField:SetWidth(120)
		Details.CopyTextField:SetPoint("center", UIParent, "center")
		Details.CopyTextField:SetBackdrop(backdrop)

		DetailsFramework:ApplyStandardBackdrop(Details.CopyTextField)

		tinsert(UISpecialFrames, "DetailsCopyText")

		Details.CopyTextField.textField = CreateFrame("editbox", nil, Details.CopyTextField, "BackdropTemplate")
		Details.CopyTextField.textField:SetPoint("topleft", Details.CopyTextField, "topleft")
		Details.CopyTextField.textField:SetAutoFocus(false)
		Details.CopyTextField.textField:SetFontObject("GameFontHighlightSmall")
		Details.CopyTextField.textField:SetAllPoints()
		Details.CopyTextField.textField:EnableMouse(true)

		Details.CopyTextField.textField:SetScript("OnEnterPressed", function()
			Details.CopyTextField.textField:ClearFocus()
			Details.CopyTextField:Hide()
		end)

		Details.CopyTextField.textField:SetScript("OnEscapePressed", function()
			Details.CopyTextField.textField:ClearFocus()
			Details.CopyTextField:Hide()
		end)

		Details.CopyTextField.textField:SetScript("OnChar", function()
			Details.CopyTextField.textField:ClearFocus()
			Details.CopyTextField:Hide()
		end)
	end

	C_Timer.After(0.1, function()
		Details.CopyTextField:Show()
		Details.CopyTextField.textField:SetFocus()
		Details.CopyTextField.textField:SetText(text)
		Details.CopyTextField.textField:HighlightText()
	end)
end


-------------------------------------------------------------------------
--> cache maintenance

function Details222.Cache.DoMaintenance()
	local currentTime = time()
	local delay = 1036800 --12 days

	if (currentTime > Details.latest_spell_pool_access + delay) then
		local spellIdPoolBackup = DetailsFramework.table.copy({}, Details.spell_pool)

		Details:Destroy(Details.spell_pool)

		--preserve ignored spells spellId
		for spellId in pairs(Details.spellid_ignored) do
			Details.spell_pool[spellId] = spellIdPoolBackup[spellId]
		end

		Details.latest_spell_pool_access = currentTime
		Details:Destroy(spellIdPoolBackup)
	end

	if (currentTime > Details.latest_npcid_pool_access + delay) then
		local npcIdPoolBackup = DetailsFramework.table.copy({}, Details.npcid_pool)

		Details:Destroy(Details.npcid_pool)

		--preserve ignored npcs npcId
		for npcId in pairs(Details.npcid_ignored) do
			Details.npcid_pool[npcId] = npcIdPoolBackup[npcId]
		end
		Details.latest_npcid_pool_access = currentTime
		Details:Destroy(npcIdPoolBackup)
	end

	if (currentTime > Details.latest_encounter_spell_pool_access + delay) then
		Details:Destroy(Details.encounter_spell_pool)
		Details.latest_encounter_spell_pool_access = currentTime
	end

	if (Details.boss_mods_timers and Details.boss_mods_timers.latest_boss_mods_access) then
		if (currentTime > Details.boss_mods_timers.latest_boss_mods_access + delay) then
			Details:Destroy(Details.boss_mods_timers.encounter_timers_bw)
			Details:Destroy(Details.boss_mods_timers.encounter_timers_dbm)
			Details.boss_mods_timers.latest_boss_mods_access = currentTime
		end
	end

	--latest_shield_spellid_cache_access
	--shield_spellid_cache
end