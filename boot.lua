-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--global name declaration
--use lua-language-server annotations to help the linter:
--https://github.com/LuaLS/lua-language-server/wiki/Annotations#documenting-types
--follow definitions declared in the file definitions.lua
--follow game api definitions in the file LibLuaServer.lua

		local _ = nil
		_G.Details = LibStub("AceAddon-3.0"):NewAddon("_detalhes", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0", "NickTag-1.0")

		--add the original name to the global namespace
		_detalhes = _G.Details --[[GLOBAL]]

		__details_debug = __details_debug or {}
		if (__details_debug.prescience_timeline) then
			wipe(__details_debug.prescience_timeline)
		end

		local addonName, Details222 = ...
		local version = GetBuildInfo()

		Details.build_counter = 12890
		Details.alpha_build_counter = 12890 --if this is higher than the regular counter, use it instead
		Details.dont_open_news = true
		Details.game_version = version
		Details.userversion = version .. " " .. Details.build_counter
		Details.realversion = 160 --core version, this is used to check API version for scripts and plugins (see alias below)
		Details.gametoc = tvs
		Details.APIVersion = Details.realversion --core version
		Details.version = Details.userversion .. " (core " .. Details.realversion .. ")" --simple stirng to show to players

		Details.acounter = 1 --in case of a second release with the same .build_counter
		Details.curseforgeVersion = GetAddOnMetadata("Details", "Version")

		function Details:GetCoreVersion()
			return Details.realversion
		end

		Details.BFACORE = 131 --core version on BFA launch
		Details.SHADOWLANDSCORE = 143 --core version on Shadowlands launch
		Details.DRAGONFLIGHT = 147 --core version on Dragonflight launch
		Details.V11CORE = 160 --core version on V11 launch

		Details = Details

		local gameVersionPrefix = "ASC"

		Details.gameVersionPrefix = gameVersionPrefix

		pcall(function() Details.version_alpha_id = tonumber(Details.curseforgeVersion:match("%-(%d+)%-")) end)

		--WD 10288 RELEASE 10.0.2
		--WD 10288 ALPHA 21 10.0.2
		function Details.GetVersionString()
			local curseforgeVersion = Details.curseforgeVersion or ""
			local alphaId = curseforgeVersion:match("%-(%d+)%-")

			if (not alphaId) then
				--this is a release version
				alphaId = "RELEASE"
			else
				alphaId = "ALPHA " .. alphaId
			end

			return Details.gameVersionPrefix .. " " .. Details.build_counter .. " " .. alphaId .. " " .. Details.game_version .. ""
		end

		Details.DefaultTooltipIconSize = 20

		--namespace for the player breakdown window
		Details.PlayerBreakdown = {}
		Details222.PlayerBreakdown = {
			DamageSpellsCache = {}
		}

		Details222.StartUp = {}

		Details222.Unknown = _G["UNKNOWN"]

		--namespace color
		Details222.ColorScheme = {
			["gradient-background"] = {0.1215, 0.1176, 0.1294, 0.8},
		}
		function Details222.ColorScheme.GetColorFor(colorScheme)
			return Details222.ColorScheme[colorScheme]
		end

		function Details222.DebugMsg(...)
			if (Details.debug) then
				print("|cFFCCAAAADetails! Debug:|r", ...)
			end
		end

		--cache of frames to call :SetColor() when the color scheme changes
		Details222.RegisteredFramesToColor = {}

		Details222.TrainingDummiesNpcId = {
			[632668] = true, --Classic Dummy
			[666925] = true, --Outland Execute Dummy
			[666928] = true, --Outland Tank Training Dummy
			[666938] = true, --Outland AOE Training Dummy
			[967254] = true, --Dynamic Training Dummy
			[666953] = true, --Outland Single Target Training Dummy
		}

		---@type details_storage_feature
		---@diagnostic disable-next-line: missing-fields
		local storage = {
			DiffNames = {"normal", "heroic", "mythic", "ascended"},
			DiffNamesHash = {normal = 14, heroic = 2, mythic = 3, ascended = 4,},
			DiffIdToName = {[1] = "normal", [2] = "heroic", [3] = "mythic", [4] = "ascended"},
			IsDebug = false
		}
		Details222.storage = storage

		--namespace for damage spells (spellTable)
		Details222.DamageSpells = {}
		--namespace for texture
		Details222.Textures = {}

		Details222.Debug = {
			DebugPets = false,
			DebugPlayerPets = false,
			DebugBuff = false,
		}

		Details222.Tvs = tvs
		--namespace for pet
		Details222.Pets = {}
		Details222.PetContainer = {
			---@type table<guid, petdata>
			Pets = {},
			---@type table<guid, boolean>
			IgnoredActors = {},
			---table that stores the player guid as keys and their petguid as values
			---this is useful to know which pets are the legit class pet from the UNIT_PET event
			---@type table<guid, guid>
			UnitPetCache = {},
		}

		--auto run code
		Details222.AutoRunCode = {}
		--options panel
		Details222.OptionsPanel = {}
		--store bar icons (left side of the damage bar)
		Details222.BarIconSetList = {}
		Details222.Instances = {}
		Details222.Combat = {}
		Details222.MythicPlus = {
			Charts = {},
			Frames = {},
		}

		Details222.MythicPlusBreakdown = {}
		Details222.EJCache = {}
		Details222.Segments = {}
		Details222.Tables = {}
		Details222.Mixins = {}
		Details222.Cache = {}
		Details222.Perf = {}
		Details222.Cooldowns = {}
		Details222.GarbageCollector = {}
		Details222.BreakdownWindow = {}
		Details222.PlayerStats = {}
		Details222.LoadSavedVariables = {}
		Details222.SaveVariables = {}
		Details222.GuessSpecSchedules = {
			Schedules = {},
		}
		Details222.Profiling = {}
		Details222.ProfilingCache = {}
		Details222.TimeMachine = {}
		Details222.OnUseItem = {Trinkets = {}}

		Details222.Date = {
			GetDateForLogs = function()
				return _G.date("%Y-%m-%d %H:%M:%S")
			end,
		}

		Details222.ClassCache = {}
		Details222.ClassCache.ByName = {}
		Details222.ClassCache.ByGUID = {}
		Details222.UnitIdCache = {}
		Details222.Roskash = {}
		Details222.SpecHelpers = {
			[1473] = {},
		}

		Details222.IgnoredWorldAuras = {}
		Details222.OneHourAuras = {}

		Details222.Parser = {}

		Details222.Actors = {}

		Details222.CurrentDPS = {
			Cache = {}
		}
		--store all data from the encounter journal
		Details222.EncounterJournalDump = {}
		--aura scanner
		Details222.AuraScan = {}

        local GetSpellInfo = GetSpellInfo 
        Details222.GetSpellInfo = GetSpellInfo

		local UnitBuff = UnitBuff
		Details222.UnitBuff = UnitBuff

		local UnitDebuff = UnitDebuff
		Details222.UnitDebuff = UnitDebuff


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--initialization stuff
local _

do
	local _detalhes = _G.Details
	_detalhes.resize_debug = {}

	local Loc = _G.LibStub("AceLocale-3.0"):GetLocale("Details")

	local news = {
		{"Ascension.12890.160", "October 18th, 2024"},
		"Potential fix for lua error spam caused by Absorb tracking",
		"Fixed an issue preventing the \"Everything\" Mode from tracking players not in your group.",

		{"Ascension.12889.160", "October 7th, 2024"},
		"Fixes for mana regen and other resource tracking.",

		{"Ascension.12888.160", "September 5th, 2024"},
		"Initial Release of TWW Backported Details! v11.0.12888.160",
	}

	local newsString = "|cFFF1F1F1"

	for i = 1, #news do
		local line = news[i]
		if (type(line) == "table")  then
			local version = line[1]
			local date = line[2]
			newsString = newsString .. "|cFFFFFF00" .. version .. " (|cFFFF8800" .. date .. "|r):|r\n\n"
		else
			if (line ~= "") then
				newsString = newsString .. "|cFFFFFF00-|r " .. line .. "\n\n"
			else
				newsString = newsString .. " \n"
			end
		end
	end

	Loc["STRING_VERSION_LOG"] = newsString

	Loc ["STRING_DETAILS1"] = "|cffffaeaeDetails!:|r "

	--startup
		_detalhes.max_windowline_columns = 11
		_detalhes.initializing = true
		_detalhes.enabled = true
		_detalhes.__index = _detalhes
		_detalhes._tempo = time()
		_detalhes.debug = true and UnitName("player") == "Andrew"
		_detalhes.debug_chr = true and UnitName("player") == "Andrew"
		_detalhes.opened_windows = 0
		_detalhes.last_combat_time = 0

		--store functions to create options frame
		Details.optionsSection = {}

	--containers
		--armazenas as fun��es do parser - All parse functions
			_detalhes.parser = {}
			_detalhes.parser_functions = {}
			Details222.parser_frame = CreateFrame("Frame")
			Details222.parser_frame:Hide()
			_detalhes.pvp_parser_frame = CreateFrame("Frame")

			_detalhes.MacroList = {
				{Name = "Click on Your Own Bar", Desc = "To open the player details window on your character, like if you click on your bar in the damage window. The number '1' is the window number where it'll click.", MacroText = "/script Details:OpenPlayerDetails(1)"},
				{Name = "Open Encounter Breakdown", Desc = "Open the encounter breakdown plugin. Details! Encounter Breakdown (plugin) must be enabled.", MacroText = "/script Details:OpenPlugin ('Encounter Breakdown')"},
				{Name = "Open Damage per Phase", Desc = "Open the encounter breakdown plugin in the phase tab. Details! Encounter Breakdown (plugin) must be enabled.", MacroText = "/script Details:OpenPlugin ('Encounter Breakdown'); local a=Details_EncounterDetails and Details_EncounterDetails.buttonSwitchPhases:Click()"},
				{Name = "Reset Data", Desc = "Reset the overall and regular segments data. Use 'ResetSegmentOverallData' to reset only the overall.", MacroText = "/script Details:ResetSegmentData()"},
				{Name = "Change What the Window Shows", Desc = "Make a window show different data. SetDisplay uses (segment, displayGroup, displayID), the menu from the sword icon is in order (damage = group 1, overheal is: displayGroup 2 displayID 3.", MacroText = "/script Details:GetWindow(1):SetDisplay( DETAILS_SEGMENTID_CURRENT, 4, 5 )"},
				{Name = "Toggle Window Height to Max Size", Desc = "Make a window be 450 pixel height, pressing the macro again toggle back to the original size. The number '1' if the window number. Hold a click in any window to show their number.", MacroText = "/script Details:GetWindow(1):ToggleMaxSize()"},
			--	/script Details:OpenPlugin ('Advanced Death Logs'); local a = Details_DeathGraphsModeEnduranceButton and Details_DeathGraphsModeEnduranceButton.MyObject:Click()
				{Name = "Report What is Shown In the Window", Desc = "Report the current data shown in the window, the number 1 is the window number, replace it to report another window.", MacroText = "/script Details:FastReportWindow(1)"},
			}

		--current instances of the exp (need to maintain)
			local expansion = GetExpansionLevel()
			if expansion == Enum.Expansion.TBC then
				_detalhes.InstancesToStoreData = { --GetActiveMapID()
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
				_detalhes.InstancesToStoreData = { --GetActiveMapID()
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
				_detalhes.InstancesToStoreData = { --GetActiveMapID()
					[409] = true, --Molten Core
					[469] = true, --Blackwing Lair
					[249] = true, --Onyxia's Lair
					[509] = true, --Ruins of Ahn'Qiraj
					[531] = true, --Temple of Ahn'Qiraj
					[533] = true, --Naxxramas 
				}
			end
			

		--store shield information for absorbs
			_detalhes.ShieldCache = {}

		--armazena as fun��es dos frames - Frames functions
			_detalhes.gump = _G ["DetailsFramework"]
			function _detalhes:GetFramework()
				return self.gump
			end
			GameCooltip = GameCooltip2
		--anima��es dos icones
			_detalhes.icon_animations = {
				load = {
					in_use = {},
					available = {},
				},
			}

		--make a color namespace
		Details.Colors = {}
		function Details.Colors.GetMenuTextColor()
			return "orange"
		end

		function Details:GetTextureAtlasTable()
			return Details.TextureAtlas
		end

		--armazena as fun��es para inicializa��o dos dados - Metatable functions
			_detalhes.refresh = {}
		--armazena as fun��es para limpar e guardas os dados - Metatable functions
			_detalhes.clear = {}
		--armazena a config do painel de fast switch
			_detalhes.switch = {}
		--armazena os estilos salvos
			_detalhes.savedStyles = {}
		--armazena quais atributos possue janela de atributos - contain attributes and sub attributos wich have a detailed window (left click on a row)
			_detalhes.row_singleclick_overwrite = {}
		--report
			_detalhes.ReportOptions = {}
		--armazena os buffs registrados - store buffs ids and functions
			_detalhes.Buffs = {} --initialize buff table
		-- cache de grupo
			_detalhes.cache_damage_group = {}
			_detalhes.cache_healing_group = {}
			_detalhes.cache_npc_ids = {}
		--cache de specs
			_detalhes.cached_specs = {}
			_detalhes.cached_talents = {}
		--ignored pets
			_detalhes.pets_ignored = {}
			_detalhes.pets_no_owner = {}
		--dual candidates
			_detalhes.duel_candidates = {}
		--armazena as skins dispon�veis para as janelas
			_detalhes.skins = {}
		--armazena os hooks das fun��es do parser
			---@type table<detailshook, function[]>
			_detalhes.hooks = {}
		--informa��es sobre a luta do boss atual
			_detalhes.encounter_end_table = {}
			_detalhes.encounter_table = {}
			_detalhes.encounter_counter = {}
			_detalhes.encounter_dungeons = {}
		--unitId dos inimigos dentro de uma arena
			_detalhes.arena_enemies = {}
		--reliable char data sources
		--actors that are using details! and sent character data, we don't need query inspect on these actors
			_detalhes.trusted_characters = {}
		--informa��es sobre a arena atual
			_detalhes.arena_table = {}
			_detalhes.arena_info = {
				[559] = {file = "LoadScreenNagrandArenaBattlegrounds"}, --Nagrand Arena            
				[562] = {file = "LoadScreenBladesEdgeArena"}, --Blade's Edge Arena       
				[572] = {file = "LoadScreenRuinsofLordaeronBattlegrounds"}, --Ruins of Lordaeron       
				[617] = {file = "LoadScreenDalaranSewersArena"}, --Dalaran Sewers           
				[618] = {file = "loadscreenbrawlgararena"}, --The Ring of Valor        
				[980] = {file = "loadscreentolvirarena"}, --Tol'viron Arena          
				[982] = {file = "loadingscreenulduarcolliseum"}, --Coliseum of Past Echoes  
				[983] = {file = "loadingscreennerubarena"}, --Imperial Arena of Thakraj
				[984] = {file = "loadscreenmaldraxxuscoliseum"}, --Maldraxxus Coliseum      
				[985] = {file = "LoadScreenNagrandArenaBattlegrounds"}, --Nagrand Arena            
				[986] = {file = "LoadScreenBladesEdgeArena"}, --Blade's Edge Arena       
				[1007] = {file = "LoadScreenKarazhan"}, --Guardian's Hall          
				[1134] = {file = "loadingscreenshadowpanbg"}, --The Tiger's Peak         
				[1401] = {file = "loadscreentolbarad"}, --Baradin Hold Arena       
				[1402] = {file = "Obelisk_of_the_Stars"}, --Obelisk of the Stars     
				[1403] = {file = "loadscreenthetwistingnether"}, --The Twisting Nether      
				[1504] = {file = "loadingscreenblackrookholdarena"}, --Black Rook Hold Arena    
				[1552] = {file = "loadingscreenarenavalsharah"}, --Ashamane's Fall          
				[1683] = {file = "the_inventors_library_arena"}, --The Inventor's Library   
				[1684] = {file = "amphitheater_of_anguish_arena"}, --Amphitheater of Anguish
			}

			Details.IgnoredEnemyNpcsTable = {
				[31216] = true, --mirror image
			}

			local default_coords = {0, 1, 0.265625, 0.8525390625}
			function _detalhes:GetArenaInfo (mapid)
				local t = _detalhes.arena_info [mapid]
				if (t) then
					return t.file, t.coords or default_coords
				end
			end
			_detalhes.battleground_info = {
				[30] = {file = "LoadScreenPvpBattleground"}, -- Alterac Valley
				[489] = {file = "LoadScreenWarsongGulch"}, -- Warsong Gulch
				[529] = {file = "LoadscreenArathiBasin"}, -- Arathi Basin
				[566] = {file = "LoadScreenNetherBattlegrounds"}, -- Eye of the Storm
				[607] = {file = "LoadScreenNorthrendBG"}, -- Strand of the Ancients
				[628] = {file = "LoadScreenIsleOfConquest"}, -- Isle of Conquest
				[726] = {file = "loadscreentwinpeaksbg"}, -- Twin Peaks
				[987] = {file = "LoadScreenWarsongGulch"}, -- Warsong Gulch
				[988] = {file = "LoadscreenArathiBasin"}, -- Arathi Basin
				[998] = {file = "loadscreenkotmoguscenario"}, -- Temple of Kotmogu
				[1280] = {file = "LoadScreenEasternKingdom2"}, -- Southshore vs. Tarren Mill
				[1681] = {file = "loadingscreenarathibasinwinter"}, -- Arathi Basin Winter
				[1682] = {file = "loadingscreenwsgWinter"}, -- Warsong Gulch Winter
				[1686] = {file = "LoadScreenPvpBattleground"}, -- Assault on Alcaz Island
				[1690] = {file = "LoadScreenPvpBattleground"}, -- Alterac Assault
				[1693] = {file = "LoadScreenPvpBattleground"}, -- Andorhal Attack
				[1696] = {file = "LoadScreenPvpBattleground"}, -- War on Zin-Malor
				[1700] = {file = "LoadScreenPvpBattleground"}, -- Battle of Bladespire Hold
				[1703] = {file = "LoadScreenPvpBattleground"}, -- Battle of Booty Bay
				[1706] = {file = "LoadScreenPvpBattleground"}, -- Skirmish in the Steppes
				[1709] = {file = "LoadScreenPvpBattleground"}, -- Clash in The Cauldron
				[1713] = {file = "LoadScreenPvpBattleground"}, -- Deatholme Deathmatch
				[1716] = {file = "LoadScreenPvpBattleground"}, -- Battle of Dire Maul
				[1718] = {file = "LoadScreenPvpBattleground"}, -- Feathermoon Clash
				[1720] = {file = "LoadScreenPvpBattleground"}, -- Frostwhisper Fallout
				[1722] = {file = "LoadScreenPvpBattleground"}, -- Silverpine Showdown
				[1725] = {file = "LoadScreenPvpBattleground"}, -- Battle for Nagrand
				[1727] = {file = "LoadScreenPvpBattleground"}, -- Hellfire Havoc
				[1730] = {file = "LoadScreenPvpBattleground"}, -- War of the World Tree
				[1733] = {file = "LoadScreenPvpBattleground"}, -- Airstrip Assault
				[1735] = {file = "LoadScreenPvpBattleground"}, -- Bloodshed in The Barrens
				[1737] = {file = "LoadScreenPvpBattleground"}, -- Battle of North Gate Pass
				[1740] = {file = "LoadScreenPvpBattleground"}, -- Excavation of Ahn'Qiraj
				[1741] = {file = "LoadScreenPvpBattleground"}, -- Stonewatch Slaughter
				[1748] = {file = "LoadScreenPvpBattleground"}, -- Slaughter in Stromgarde
				[1751] = {file = "LoadScreenPvpBattleground"}, -- Battle for Theramore
				[1753] = {file = "LoadScreenPvpBattleground"}, -- Tor'Watha
				[1754] = {file = "LoadScreenPvpBattleground"}, -- Carnage in the Crater
				[1755] = {file = "LoadScreenPvpBattleground"}, -- Warsong Lumber War
				[1757] = {file = "LoadScreenPvpBattleground"}, -- War of Windshear Crag
				[3000] = {file = "LoadScreenPvpBattleground"}, -- Alterac Valley
			}
			function _detalhes:GetBattlegroundInfo(mapid)
				local battlegroundInfo = _detalhes.battleground_info[mapid]
				if (battlegroundInfo) then
					return battlegroundInfo.file, battlegroundInfo.coords or default_coords
				end
			end

		--tokenid
			_detalhes.TokenID = {
				["SPELL_PERIODIC_DAMAGE"] = 1,
				["SPELL_EXTRA_ATTACKS"] = 2,
				["SPELL_DAMAGE"] = 3,
				["SPELL_BUILDING_DAMAGE"] = 4,
				["SWING_DAMAGE"] = 5,
				["RANGE_DAMAGE"] = 6,
				["DAMAGE_SHIELD"] = 7,
				["DAMAGE_SPLIT"] = 8,
				["RANGE_MISSED"] = 9,
				["SWING_MISSED"] = 10,
				["SPELL_MISSED"] = 11,
				["SPELL_PERIODIC_MISSED"] = 12,
				["SPELL_BUILDING_MISSED"] = 13,
				["DAMAGE_SHIELD_MISSED"] = 14,
				["ENVIRONMENTAL_DAMAGE"] = 15,
				["SPELL_HEAL"] = 16,
				["SPELL_PERIODIC_HEAL"] = 17,
				["SPELL_HEAL_ABSORBED"] = 18,
				["SPELL_ABSORBED"] = 19,
				["SPELL_AURA_APPLIED"] = 20,
				["SPELL_AURA_REMOVED"] = 21,
				["SPELL_AURA_REFRESH"] = 22,
				["SPELL_AURA_APPLIED_DOSE"] = 23,
				["SPELL_ENERGIZE"] = 24,
				["SPELL_PERIODIC_ENERGIZE"] = 25,
				["SPELL_CAST_SUCCESS"] = 26,
				["SPELL_DISPEL"] = 27,
				["SPELL_STOLEN"] = 28,
				["SPELL_AURA_BROKEN"] = 29,
				["SPELL_AURA_BROKEN_SPELL"] = 30,
				["SPELL_RESURRECT"] = 31,
				["SPELL_INTERRUPT"] = 32,
				["UNIT_DIED"] = 33,
				["UNIT_DESTROYED"] = 34,
			}

		---@type table<npcid, textureid>
		local npcIdToIcon = {
			[17252] = [[Interface\Icons\Spell_shadow_summonfelguard]], --felguard
			[1860] = [[Interface\Icons\spell_shadow_summonvoidwalker]], -- voidwalker
			[417] = [[Interface\Icons\spell_shadow_summonfelhunter]], -- felhunter
			[1863] = [[Interface\Icons\spell_shadow_summonsuccubus]], -- succubus 
			[416] = [[Interface\Icons\spell_shadow_summonimp]], -- imp
		}
		_detalhes.NpcIdToIcon = npcIdToIcon

		--armazena instancias inativas
			_detalhes.unused_instances = {}
			_detalhes.default_skin_to_use = "Minimalistic"
			_detalhes.instance_title_text_timer = {}
		--player detail skin
			_detalhes.playerdetailwindow_skins = {}

		_detalhes.BitfieldSwapDebuffsIDs = {}
		_detalhes.BitfieldSwapDebuffsSpellIDs = {}

		--auto run code
		_detalhes.RunCodeTypes = {
			{Name = "On Initialization", Desc = "Run code when Details! initialize or when a profile is changed.", Value = 1, ProfileKey = "on_init"},
			{Name = "On Zone Changed", Desc = "Run code when the zone where the player is in has changed (e.g. entered in a raid).", Value = 2, ProfileKey = "on_zonechanged"},
			{Name = "On Enter Combat", Desc = "Run code when the player enters in combat.", Value = 3, ProfileKey = "on_entercombat"},
			{Name = "On Leave Combat", Desc = "Run code when the player left combat.", Value = 4, ProfileKey = "on_leavecombat"},
			{Name = "On Spec Change", Desc = "Run code when the player has changed its specialization.", Value = 5, ProfileKey = "on_specchanged"},
			{Name = "On Enter/Leave Group", Desc = "Run code when the player has entered or left a party or raid group.", Value = 6, ProfileKey = "on_groupchange"},
		}

		--run a function without stopping the execution in case of an error
		function Details.SafeRun(func, executionName, ...)
			local runToCompletion, errorText = pcall(func, ...)
			if (not runToCompletion) then
				if (Details.debug) then
					Details:Msg("Safe run failed:", executionName, errorText)
				end
				return false
			end
			return true
		end

		--tooltip
			_detalhes.tooltip_backdrop = {
				bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
				edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
				tile = true,
				edgeSize = 16,
				tileSize = 16,
				insets = {left = 3, right = 3, top = 4, bottom = 4}
			}
			_detalhes.tooltip_border_color = {1, 1, 1, 1}
			_detalhes.tooltip_spell_icon = {file = [[Interface\CHARACTERFRAME\UI-StateIcon]], coords = {36/64, 58/64, 7/64, 26/64}}
			_detalhes.tooltip_target_icon = {file = [[Interface\Addons\Details\images\icons]], coords = {0, 0.03125, 0.126953125, 0.15625}}

		--icons
			_detalhes.attribute_icons = [[Interface\AddOns\Details\images\atributos_icones]]
			function _detalhes:GetAttributeIcon (attribute)
				return _detalhes.attribute_icons, 0.125 * (attribute - 1), 0.125 * attribute, 0, 1
			end

		--colors
			_detalhes.default_backdropcolor = {.094117, .094117, .094117, .8}
			_detalhes.default_backdropbordercolor = {0, 0, 0, 1}

	--Plugins

		--plugin templates

		DetailsFramework:NewColor("DETAILS_PLUGIN_BUTTONTEXT_COLOR", 0.9999, 0.8196, 0, 1)
		DetailsFramework:NewColor("DETAILS_HEADER_YELLOW", 227/255, 186/255, 4/255)

		DetailsFramework:InstallTemplate("button", "DETAILS_PLUGINPANEL_BUTTON_TEMPLATE",
			{
				backdrop = {edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true},
				backdropcolor = {0, 0, 0, .5},
				backdropbordercolor = {0, 0, 0, .5},
				onentercolor = {0.3, 0.3, 0.3, .5},
			}
		)
		DetailsFramework:InstallTemplate("button", "DETAILS_PLUGINPANEL_BUTTONSELECTED_TEMPLATE",
			{
				backdrop = {edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true},
				backdropcolor = {0, 0, 0, .5},
				backdropbordercolor = {1, 1, 0, 1},
				onentercolor = {0.3, 0.3, 0.3, .5},
			}
		)

		DetailsFramework:InstallTemplate("button", "DETAILS_PLUGIN_BUTTON_TEMPLATE",
			{
				backdrop = {edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true},
				backdropcolor = {1, 1, 1, .5},
				backdropbordercolor = {0, 0, 0, 1},
				onentercolor = {1, 1, 1, .9},
				textcolor = "DETAILS_PLUGIN_BUTTONTEXT_COLOR",
				textsize = 10,
				width = 120,
				height = 20,
			}
		)
		DetailsFramework:InstallTemplate("button", "DETAILS_PLUGIN_BUTTONSELECTED_TEMPLATE",
			{
				backdrop = {edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true},
				backdropcolor = {1, 1, 1, .5},
				backdropbordercolor = {1, .7, 0, 1},
				onentercolor = {1, 1, 1, .9},
				textcolor = "DETAILS_PLUGIN_BUTTONTEXT_COLOR",
				textsize = 10,
				width = 120,
				height = 20,
			}
		)

		DetailsFramework:InstallTemplate("button", "DETAILS_TAB_BUTTON_TEMPLATE",
			{
				width = 100,
				height = 20,
			},
			"DETAILS_PLUGIN_BUTTON_TEMPLATE"
		)
		DetailsFramework:InstallTemplate("button","DETAILS_TAB_BUTTONSELECTED_TEMPLATE",
			{
				width = 100,
				height = 20,
			},
			"DETAILS_PLUGIN_BUTTONSELECTED_TEMPLATE"
		)

		Details.PluginsGlobalNames = {}
		Details.PluginsLocalizedNames = {}

		--raid -------------------------------------------------------------------
			--general function for raid mode plugins
				Details.RaidTables = {}
			--menu for raid modes
				Details.RaidTables.Menu = {}
			--plugin objects for raid mode
				Details.RaidTables.Plugins = {}
			--name to plugin object
				Details.RaidTables.NameTable = {}
			--using by
				Details.RaidTables.InstancesInUse = {}
				Details.RaidTables.PluginsInUse = {}

		--solo -------------------------------------------------------------------
			--general functions for solo mode plugins
				Details.SoloTables = {}
			--maintain plugin menu
				Details.SoloTables.Menu = {}
			--plugins objects for solo mode
				Details.SoloTables.Plugins = {}
			--name to plugin object
				Details.SoloTables.NameTable = {}

		--toolbar -------------------------------------------------------------------
			--plugins container
				Details.ToolBar = {}
			--current showing icons
				Details.ToolBar.Shown = {}
				Details.ToolBar.AllButtons = {}
			--plugin objects
				Details.ToolBar.Plugins = {}
			--name to plugin object
				Details.ToolBar.NameTable = {}
				Details.ToolBar.Menu = {}

		--statusbar -------------------------------------------------------------------
			--plugins container
				Details.StatusBar = {}
			--maintain plugin menu
				Details.StatusBar.Menu = {}
			--plugins object
				Details.StatusBar.Plugins = {}
			--name to plugin object
				Details.StatusBar.NameTable = {}

		--constants
		if (GetExpansionLevel() == Enum.Expansion.WoTLK) then
			--[[global]] DETAILS_HEALTH_POTION_ID = 33447 -- Runic Healing Potion
			--[[global]] DETAILS_HEALTH_POTION2_ID = 41166 -- Runic Healing Injector
			--[[global]] DETAILS_REJU_POTION_ID = 40087 -- Powerful Rejuvenation Potion
			--[[global]] DETAILS_REJU_POTION2_ID = 40077 -- Crazy Alchemist's Potion
			--[[global]] DETAILS_MANA_POTION_ID = 33448 -- Runic Mana Potion
			--[[global]] DETAILS_MANA_POTION2_ID = 42545 -- Runic Mana Injector
			--[[global]] DETAILS_FOCUS_POTION_ID = 307161
			--[[global]] DETAILS_HEALTHSTONE_ID = 47875 --Warlock's Healthstone
			--[[global]] DETAILS_HEALTHSTONE2_ID = 47876 --Warlock's Healthstone (1/2 Talent)
			--[[global]] DETAILS_HEALTHSTONE3_ID = 47877 --Warlock's Healthstone (2/2 Talent)

			--[[global]] DETAILS_INT_POTION_ID = 40212 --Potion of Wild Magic
			--[[global]] DETAILS_AGI_POTION_ID = 40211 --Potion of Speed
			--[[global]] DETAILS_STR_POTION_ID = 307164
			--[[global]] DETAILS_STAMINA_POTION_ID = 40093 --Indestructible Potion
			--[[global]] DETAILS_HEALTH_POTION_LIST = {
					[DETAILS_HEALTH_POTION_ID] = true, -- Runic Healing Potion
					[DETAILS_HEALTH_POTION2_ID] = true, -- Runic Healing Injector
					[DETAILS_HEALTHSTONE_ID] = true, --Warlock's Healthstone
					[DETAILS_HEALTHSTONE2_ID] = true, --Warlock's Healthstone (1/2 Talent)
					[DETAILS_HEALTHSTONE3_ID] = true, --Warlock's Healthstone (2/2 Talent)
					[DETAILS_REJU_POTION_ID] = true, -- Powerful Rejuvenation Potion
					[DETAILS_REJU_POTION2_ID] = true, -- Crazy Alchemist's Potion
					[DETAILS_MANA_POTION_ID] = true, -- Runic Mana Potion
					[DETAILS_MANA_POTION2_ID] = true, -- Runic Mana Injector
				}
		elseif GetExpansionLevel() == Enum.Expansion.TBC then
			--[[global]] DETAILS_HEALTH_POTION_ID = 33447 -- Runic Healing Potion
			--[[global]] DETAILS_HEALTH_POTION2_ID = 41166 -- Runic Healing Injector
			--[[global]] DETAILS_REJU_POTION_ID = 40087 -- Powerful Rejuvenation Potion
			--[[global]] DETAILS_REJU_POTION2_ID = 40077 -- Crazy Alchemist's Potion
			--[[global]] DETAILS_MANA_POTION_ID = 33448 -- Runic Mana Potion
			--[[global]] DETAILS_MANA_POTION2_ID = 42545 -- Runic Mana Injector
			--[[global]] DETAILS_FOCUS_POTION_ID = 307161
			--[[global]] DETAILS_HEALTHSTONE_ID = 47875 --Warlock's Healthstone
			--[[global]] DETAILS_HEALTHSTONE2_ID = 47876 --Warlock's Healthstone (1/2 Talent)
			--[[global]] DETAILS_HEALTHSTONE3_ID = 47877 --Warlock's Healthstone (2/2 Talent)

			--[[global]] DETAILS_INT_POTION_ID = 40212 --Potion of Wild Magic
			--[[global]] DETAILS_AGI_POTION_ID = 40211 --Potion of Speed
			--[[global]] DETAILS_STR_POTION_ID = 307164
			--[[global]] DETAILS_STAMINA_POTION_ID = 40093 --Indestructible Potion
			--[[global]] DETAILS_HEALTH_POTION_LIST = {
					[DETAILS_HEALTH_POTION_ID] = true, -- Runic Healing Potion
					[DETAILS_HEALTH_POTION2_ID] = true, -- Runic Healing Injector
					[DETAILS_HEALTHSTONE_ID] = true, --Warlock's Healthstone
					[DETAILS_HEALTHSTONE2_ID] = true, --Warlock's Healthstone (1/2 Talent)
					[DETAILS_HEALTHSTONE3_ID] = true, --Warlock's Healthstone (2/2 Talent)
					[DETAILS_REJU_POTION_ID] = true, -- Powerful Rejuvenation Potion
					[DETAILS_REJU_POTION2_ID] = true, -- Crazy Alchemist's Potion
					[DETAILS_MANA_POTION_ID] = true, -- Runic Mana Potion
					[DETAILS_MANA_POTION2_ID] = true, -- Runic Mana Injector
				}
		else
			--[[global]] DETAILS_HEALTH_POTION_ID = 33447 -- Runic Healing Potion
			--[[global]] DETAILS_HEALTH_POTION2_ID = 41166 -- Runic Healing Injector
			--[[global]] DETAILS_REJU_POTION_ID = 40087 -- Powerful Rejuvenation Potion
			--[[global]] DETAILS_REJU_POTION2_ID = 40077 -- Crazy Alchemist's Potion
			--[[global]] DETAILS_MANA_POTION_ID = 33448 -- Runic Mana Potion
			--[[global]] DETAILS_MANA_POTION2_ID = 42545 -- Runic Mana Injector
			--[[global]] DETAILS_FOCUS_POTION_ID = 307161
			--[[global]] DETAILS_HEALTHSTONE_ID = 47875 --Warlock's Healthstone
			--[[global]] DETAILS_HEALTHSTONE2_ID = 47876 --Warlock's Healthstone (1/2 Talent)
			--[[global]] DETAILS_HEALTHSTONE3_ID = 47877 --Warlock's Healthstone (2/2 Talent)

			--[[global]] DETAILS_INT_POTION_ID = 40212 --Potion of Wild Magic
			--[[global]] DETAILS_AGI_POTION_ID = 40211 --Potion of Speed
			--[[global]] DETAILS_STR_POTION_ID = 307164
			--[[global]] DETAILS_STAMINA_POTION_ID = 40093 --Indestructible Potion
			--[[global]] DETAILS_HEALTH_POTION_LIST = {
					[DETAILS_HEALTH_POTION_ID] = true, -- Runic Healing Potion
					[DETAILS_HEALTH_POTION2_ID] = true, -- Runic Healing Injector
					[DETAILS_HEALTHSTONE_ID] = true, --Warlock's Healthstone
					[DETAILS_HEALTHSTONE2_ID] = true, --Warlock's Healthstone (1/2 Talent)
					[DETAILS_HEALTHSTONE3_ID] = true, --Warlock's Healthstone (2/2 Talent)
					[DETAILS_REJU_POTION_ID] = true, -- Powerful Rejuvenation Potion
					[DETAILS_REJU_POTION2_ID] = true, -- Crazy Alchemist's Potion
					[DETAILS_MANA_POTION_ID] = true, -- Runic Mana Potion
					[DETAILS_MANA_POTION2_ID] = true, -- Runic Mana Injector
				}
		end

		--[[global]] DETAILS_MODE_GROUP = 2
		--[[global]] DETAILS_MODE_ALL = 3

		Details._detalhes_props = {
			DATA_TYPE_START = 1,	--Something on start
			DATA_TYPE_END = 2,	--Something on end

			MODO_ALONE = 1,	--Solo
			MODO_GROUP = 2,	--Group
			MODO_ALL = 3,		--Everything
			MODO_RAID = 4,	--Raid
		}
		Details.modos = {
			alone = 1, --Solo
			group = 2,	--Group
			all = 3,	--Everything
			raid = 4	--Raid
		}

		Details.divisores = {
			abre = "(",	--open
			fecha = ")",	--close
			colocacao = ". " --dot
		}

		Details.role_texcoord = {
			DAMAGER = "72:130:69:127",
			HEALER = "72:130:2:60",
			TANK = "5:63:69:127",
			NONE = "139:196:69:127",
		}

		Details.role_texcoord_normalized = {
			DAMAGER = {72/256, 130/256, 69/256, 127/256},
			HEALER = {72/256, 130/256, 2/256, 60/256},
			TANK = {5/256, 63/256, 69/256, 127/256},
			NONE = {139/256, 196/256, 69/256, 127/256},
		}

		Details.player_class = {}
		Details.classstring_to_classid = {}
		Details.classid_to_classstring = {}

		for _, classFile in ipairs(CLASS_SORT_ORDER) do
			Details.player_class[classFile] = true
			Details.classstring_to_classid[classFile] = Enum.Class[classFile]
			Details.classid_to_classstring[Enum.Class[classFile]] = classFile
		end

		local Loc = LibStub("AceLocale-3.0"):GetLocale ("Details")

		Details.segmentos = {
			label = Loc ["STRING_SEGMENT"]..": ",
			overall = Loc ["STRING_TOTAL"],
			overall_standard = Loc ["STRING_OVERALL"],
			current = Loc ["STRING_CURRENT"],
			current_standard = Loc ["STRING_CURRENTFIGHT"],
			past = Loc ["STRING_FIGHTNUMBER"]
		}

		Details._detalhes_props["modo_nome"] = {
				[_detalhes._detalhes_props["MODO_ALONE"]] = Loc ["STRING_MODE_SELF"],
				[_detalhes._detalhes_props["MODO_GROUP"]] = Loc ["STRING_MODE_GROUP"],
				[_detalhes._detalhes_props["MODO_ALL"]] = Loc ["STRING_MODE_ALL"],
				[_detalhes._detalhes_props["MODO_RAID"]] = Loc ["STRING_MODE_RAID"]
		}

		--[[global]] DETAILS_MODE_SOLO = 1
		--[[global]] DETAILS_MODE_RAID = 4
		--[[global]] DETAILS_MODE_GROUP = 2
		--[[global]] DETAILS_MODE_ALL = 3

		Details.icones = {
			--report window
			report = {
					up = "Interface\\FriendsFrame\\UI-Toast-FriendOnlineIcon",
					down = "Interface\\ItemAnimations\\MINIMAP\\TRACKING\\Profession",
					disabled = "Interface\\ItemAnimations\\MINIMAP\\TRACKING\\Profession",
					highlight = nil
				}
		}

		Details.missTypes = {"ABSORB", "BLOCK", "DEFLECT", "DODGE", "EVADE", "IMMUNE", "MISS", "PARRY", "REFLECT", "RESIST"} --do not localize-me


	function Details.SendHighFive()
		Details.users = {{UnitName("player"), GetRealmName(), (Details.userversion or "") .. " (" .. Details.APIVersion .. ")"}}
		Details.sent_highfive = GetTime()
		if (IsInRaid()) then
			Details:SendRaidData(Details.network.ids.HIGHFIVE_REQUEST)
		else
			Details:SendPartyData(Details.network.ids.HIGHFIVE_REQUEST)
		end
	end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--frames

	local CreateFrame = CreateFrame --api locals
	local UIParent = UIParent --api locals

	--create the breakdown window frame
	---@type breakdownwindow
	Details.BreakdownWindowFrame = CreateFrame("Frame", "DetailsBreakdownWindow", UIParent, "BackdropTemplate")
	Details.PlayerDetailsWindow = Details.BreakdownWindowFrame
	Details.BreakdownWindow = Details.BreakdownWindowFrame

	--Event Frame
	Details.listener = CreateFrame("Frame", nil, UIParent)
	Details.listener:RegisterEvent("ADDON_LOADED")
	Details.listener:SetFrameStrata("LOW")
	Details.listener:SetFrameLevel(9)
	Details.listener.FrameTime = 0

	Details.overlay_frame = CreateFrame("Frame", nil, UIParent)
	Details.overlay_frame:SetFrameStrata("TOOLTIP")

	--Pet Owner Finder
	CreateFrame("GameTooltip", "DetailsPetOwnerFinder", nil, "GameTooltipTemplate")


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--plugin defaults
	--backdrop
	Details.PluginDefaults = {}

	Details.PluginDefaults.Backdrop = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
	edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1,
	insets = {left = 1, right = 1, top = 1, bottom = 1}}
	Details.PluginDefaults.BackdropColor = {0, 0, 0, .6}
	Details.PluginDefaults.BackdropBorderColor = {0, 0, 0, 1}

	function Details.GetPluginDefaultBackdrop()
		return Details.PluginDefaults.Backdrop, Details.PluginDefaults.BackdropColor, Details.PluginDefaults.BackdropBorderColor
	end


------------------------------------------------------------------------------------------
-- welcome panel
	function _detalhes:CreateWelcomePanel(name, parent, width, height, makeMovable)
		local newWelcomePanel = CreateFrame("frame", name, parent or UIParent, "BackdropTemplate")

		DetailsFramework:ApplyStandardBackdrop(newWelcomePanel)
		newWelcomePanel:SetSize(width or 1, height or 1)

		if (makeMovable) then
			newWelcomePanel:SetScript("OnMouseDown", function(self, button)
				if (self.isMoving) then
					return
				end
				if (button == "RightButton") then
					self:Hide()
				else
					self:StartMoving()
					self.isMoving = true
				end
			end)

			newWelcomePanel:SetScript("OnMouseUp", function(self, button)
				if (self.isMoving and button == "LeftButton") then
					self:StopMovingOrSizing()
					self.isMoving = nil
				end
			end)
			newWelcomePanel:SetToplevel(true)
			newWelcomePanel:SetMovable(true)
		end

		return newWelcomePanel
	end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--functions

	_detalhes.empty_function = function() end
	_detalhes.empty_table = {}

	--register textures and fonts for shared media
		---@type table
		local SharedMedia = LibStub:GetLibrary ("LibSharedMedia-3.0")
		--default bars
		SharedMedia:Register("statusbar", "Details Hyanda Reverse", [[Interface\AddOns\Details\images\bar_textures\bar_hyanda_reverse]])
		SharedMedia:Register("statusbar", "You Are the Best!", [[Interface\AddOns\Details\images\bar_textures\bar_best]])
		SharedMedia:Register("statusbar", "Details Hyanda", [[Interface\AddOns\Details\images\bar_hyanda]])

		SharedMedia:Register("statusbar", "Details D'ictum", [[Interface\AddOns\Details\images\bar4]])
		SharedMedia:Register("statusbar", "Details Vidro", [[Interface\AddOns\Details\images\bar4_vidro]])
		SharedMedia:Register("statusbar", "Details D'ictum (reverse)", [[Interface\AddOns\Details\images\bar4_reverse]])

		--flat bars
		SharedMedia:Register("statusbar", "Skyline", [[Interface\AddOns\Details\images\bar_skyline]])

		SharedMedia:Register("statusbar", "Details Serenity", [[Interface\AddOns\Details\images\bar_serenity]])
		SharedMedia:Register("statusbar", "BantoBar", [[Interface\AddOns\Details\images\BantoBar]])
		SharedMedia:Register("statusbar", "Skyline Compact", [[Interface\AddOns\Details\images\bar_textures\bar_skyline_compact]])
		SharedMedia:Register("statusbar", "WorldState Score", [[Interface\WorldStateFrame\WORLDSTATEFINALSCORE-HIGHLIGHT]])
		SharedMedia:Register("statusbar", "DGround", [[Interface\AddOns\Details\images\bar_background]])
		SharedMedia:Register("statusbar", "Details Flat", [[Interface\AddOns\Details\images\bar_background]])
		SharedMedia:Register("statusbar", "Splitbar", [[Interface\AddOns\Details\images\bar_textures\split_bar]])
		SharedMedia:Register("statusbar", "Details2020", [[Interface\AddOns\Details\images\bar_textures\texture2020]])
		SharedMedia:Register("statusbar", "Left White Gradient", [[Interface\AddOns\Details\images\bar_textures\gradient_white_10percent_left]])
		SharedMedia:Register("statusbar", "Details! Slash", [[Interface\AddOns\Details\images\bar_textures\bar_of_bars]])

		--window bg and bar order
		SharedMedia:Register("background", "Details Ground", [[Interface\AddOns\Details\images\background]])
		SharedMedia:Register("border", "Details BarBorder 1", [[Interface\AddOns\Details\images\border_1]])
		SharedMedia:Register("border", "Details BarBorder 2", [[Interface\AddOns\Details\images\border_2]])
		SharedMedia:Register("border", "Details BarBorder 3", [[Interface\AddOns\Details\images\border_3]])
		SharedMedia:Register("border", "1 Pixel", [[Interface\Buttons\WHITE8X8]])

		--misc fonts
		SharedMedia:Register("font", "Oswald", [[Interface\Addons\Details\fonts\Oswald-Regular.ttf]])
		SharedMedia:Register("font", "Nueva Std Cond", [[Interface\Addons\Details\fonts\Nueva Std Cond.ttf]])
		SharedMedia:Register("font", "Accidental Presidency", [[Interface\Addons\Details\fonts\Accidental Presidency.ttf]])
		SharedMedia:Register("font", "TrashHand", [[Interface\Addons\Details\fonts\TrashHand.TTF]])
		SharedMedia:Register("font", "Harry P", [[Interface\Addons\Details\fonts\HARRYP__.TTF]])
		SharedMedia:Register("font", "FORCED SQUARE", [[Interface\Addons\Details\fonts\FORCED SQUARE.ttf]])

		SharedMedia:Register("sound", "Details Gun1", [[Interface\Addons\Details\sounds\sound_gun2.ogg]])
		SharedMedia:Register("sound", "Details Gun2", [[Interface\Addons\Details\sounds\sound_gun3.ogg]])
		SharedMedia:Register("sound", "Details Jedi1", [[Interface\Addons\Details\sounds\sound_jedi1.ogg]])
		SharedMedia:Register("sound", "Details Whip1", [[Interface\Addons\Details\sounds\sound_whip1.ogg]])
		SharedMedia:Register("sound", "Details Horn", [[Interface\Addons\Details\sounds\Details Horn.ogg]])

		SharedMedia:Register("sound", "Details Warning", [[Interface\Addons\Details\sounds\Details Warning 100.ogg]])
		SharedMedia:Register("sound", "Details Truck", [[Interface\Addons\Details\sounds\Details Truck.ogg]])
		SharedMedia:Register("sound", "Details Bass Drop", [[Interface\Addons\Details\sounds\bassdrop2.mp3]])

	--dump table contents over chat panel
		function Details.VarDump(t)
			if (type(t) ~= "table") then
				return
			end
			for a,b in pairs(t) do
				print(a,b)
			end
		end

		function dumpt(value) --[[GLOBAL]]
			--check if this is a spellId
			local spellId = tonumber(value)
			if (spellId) then
				local spellInfo = {Details222.GetSpellInfo(spellId)}
				if (type(spellInfo[1]) == "string") then
					local desc = C_Spell.GetSpellDescription and C_Spell.GetSpellDescription(spellId) or GetSpellDescription(spellId)
					if (not desc or desc == "") then
						return
					end

					if (C_Spell.GetSpellInfo) then
						Details:Dump({desc, C_Spell.GetSpellInfo(spellId)})
						return
					else
						return Details:Dump({desc, spellInfo})
					end
				end
			end

			--check if is an atlas texture
			local atlas
			if (type(value) == "string") then
				atlas = AtlasUtil:AtlasExists(value) and AtlasUtil:GetAtlasInfo(atlas)
				if (atlas) then
					return Details:Dump(atlas)
				end
			end

			if (value == nil) then
				local allTooltips = {"GameTooltip", "GameTooltipTooltip", "EventTraceTooltip", "FrameStackTooltip", "GarrisonMissionMechanicTooltip", "GarrisonMissionMechanicFollowerCounterTooltip", "ItemSocketingDescription", "NamePlateTooltip", "PrivateAurasTooltip", "RuneforgeFrameResultTooltip", "ItemRefTooltip", "QuickKeybindTooltip", "SettingsTooltip"}
				for i = 1, #allTooltips do
					local tooltipName = allTooltips[i]
					local tooltip = _G[tooltipName]
					if (tooltip and tooltip:IsVisible()) then
                        if (tooltip.GetTooltipData) then
                            local tooltipData = tooltip:GetTooltipData()
                            if (tooltipData) then
                                if (tooltip.ItemTooltip and tooltip.ItemTooltip:IsVisible()) then
                                    local icon = tooltip.ItemTooltip.Icon
                                    if (icon) then
                                        local texture = icon:GetTexture()
                                        local atlas = icon:GetAtlas()
                                        if (texture or atlas) then
                                            tooltipData.IconTexture = texture
                                            tooltipData.IconAtlas = atlas
                                        end
                                    end
                                end

                                if (tooltipData.hyperlink) then
                                    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType,
                                    itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType,
                                    expacID, setID, isCraftingReagent = GetItemInfo(tooltipData.hyperlink)

                                    local itemInfo = {
                                        itemName = itemName,
                                        itemLink = itemLink,
                                        itemQuality = itemQuality,
                                        itemLevel = itemLevel,
                                        itemMinLevel = itemMinLevel,
                                        itemType = itemType,
                                        itemSubType = itemSubType,
                                        itemStackCount = itemStackCount,
                                        itemEquipLoc = itemEquipLoc,
                                        itemTexture = itemTexture,
                                        sellPrice = sellPrice,
                                        classID = classID,
                                        subclassID = subclassID,
                                        bindType = bindType,
                                        expacID = expacID,
                                        setID = setID,
                                        isCraftingReagent = isCraftingReagent
                                    }
                                    DetailsFramework.table.deploy(tooltipData, itemInfo)
                                end

                                return Details:Dump(tooltipData)
                            end
                        else
                            local outputTable = {}
                            for lineNumber = 1, 10 do
                                local leftText = _G[tooltipName..'TextLeft'..lineNumber]
                                local rightText = _G[tooltipName..'TextRight'..lineNumber]
                                if not (leftText and rightText) then
                                    break
                                end
                                
                                outputTable[#outputTable+1] = {left = leftText:GetText(), right = rightText:GetText()}
                            end
                            
                            return Details:Dump(outputTable)                            
                        end
					end
				end
			end

			return Details:Dump(value)
		end

		function FindSpellByName(spellName) --[[GLOBAL]]
			if (spellName and type(spellName) == "string") then
				local GSI = GetSpellInfo
				local foundSpells = {}
				spellName = spellName:lower()
				for i = 1, 450000 do
					local thisSpellName = GSI(i)
					if (thisSpellName) then
						thisSpellName = thisSpellName:lower()
						if (spellName == thisSpellName) then
							foundSpells[#foundSpells+1] = {GSI(i)}
						end
					end
				end

				if (#foundSpells > 0) then
					dumpt(foundSpells)
				else
					Details:Msg("spell", spellName, "not found.")
				end
			end
		end

	--copies a full table
		function Details.CopyTable(orig)
			local orig_type = type(orig)
			local copy
			if orig_type == 'table' then
				copy = {}
				for orig_key, orig_value in next, orig, nil do
					--print(orig_key, orig_value)
					copy[Details.CopyTable(orig_key)] = Details.CopyTable(orig_value)
				end
			else
				copy = orig
			end
			return copy
		end

	--delay messages
		function _detalhes:DelayMsg(msg)
			_detalhes.delaymsgs = _detalhes.delaymsgs or {}
			_detalhes.delaymsgs[#_detalhes.delaymsgs+1] = msg
		end
		function _detalhes:ShowDelayMsg()
			if (_detalhes.delaymsgs and #_detalhes.delaymsgs > 0) then
				for _, msg in ipairs(_detalhes.delaymsgs) do
					print(msg)
				end
			end
			_detalhes.delaymsgs = {}
		end

	--print messages
		function _detalhes:Msg(str, arg1, arg2, arg3, arg4)
			if (self.__name) then
				print("|cffffaeae" .. self.__name .. "|r |cffcc7c7c(plugin)|r: " .. (str or ""), arg1 or "", arg2 or "", arg3 or "", arg4 or "")
			else
				print(Loc ["STRING_DETAILS1"] .. (str or ""), arg1 or "", arg2 or "", arg3 or "", arg4 or "")
			end
		end

	--welcome
		function _detalhes:WelcomeMsgLogon()
			_detalhes:Msg("you can always reset the addon running the command |cFFFFFF00'/details reinstall'|r if it does fail to load after being updated.")

			function _detalhes:wipe_combat_after_failed_load()
				_detalhes.tabela_historico = _detalhes.historico:CreateNewSegmentDatabase()
				_detalhes.tabela_overall = _detalhes.combate:NovaTabela()
				_detalhes.tabela_vigente = _detalhes.combate:NovaTabela (_, _detalhes.tabela_overall)
				Details222.PetContainer.Reset()

				_detalhes_database.tabela_overall = nil
				_detalhes_database.tabela_historico = nil

				_detalhes:Msg("seems failed to load, please type /reload to try again.")
			end

			Details.Schedules.After(5, _detalhes.wipe_combat_after_failed_load)
		end

		Details.failed_to_load = C_Timer.NewTimer(1, function() Details.Schedules.NewTimer(20, _detalhes.WelcomeMsgLogon) end)

	--key binds
	--[=
		--header
			_G ["BINDING_HEADER_Details"] = "Details!"
			_G ["BINDING_HEADER_DETAILS_KEYBIND_SEGMENTCONTROL"] = Loc ["STRING_KEYBIND_SEGMENTCONTROL"]
			_G ["BINDING_HEADER_DETAILS_KEYBIND_SCROLLING"] = Loc ["STRING_KEYBIND_SCROLLING"]
			_G ["BINDING_HEADER_DETAILS_KEYBIND_WINDOW_CONTROL"] = Loc ["STRING_KEYBIND_WINDOW_CONTROL"]
			_G ["BINDING_HEADER_DETAILS_KEYBIND_BOOKMARK"] = Loc ["STRING_KEYBIND_BOOKMARK"]
			_G ["BINDING_HEADER_DETAILS_KEYBIND_REPORT"] = Loc ["STRING_KEYBIND_WINDOW_REPORT_HEADER"]

		--keys

			_G ["BINDING_NAME_DETAILS_TOGGLE_ALL"] = Loc ["STRING_KEYBIND_TOGGLE_WINDOWS"]

			_G ["BINDING_NAME_DETAILS_RESET_SEGMENTS"] = Loc ["STRING_KEYBIND_RESET_SEGMENTS"]
			_G ["BINDING_NAME_DETAILS_SCROLL_UP"] = Loc ["STRING_KEYBIND_SCROLL_UP"]
			_G ["BINDING_NAME_DETAILS_SCROLL_DOWN"] = Loc ["STRING_KEYBIND_SCROLL_DOWN"]

			_G ["BINDING_NAME_DETAILS_REPORT_WINDOW1"] = string.format(Loc ["STRING_KEYBIND_WINDOW_REPORT"], 1)
			_G ["BINDING_NAME_DETAILS_REPORT_WINDOW2"] = string.format(Loc ["STRING_KEYBIND_WINDOW_REPORT"], 2)

			_G ["BINDING_NAME_DETAILS_TOOGGLE_WINDOW1"] = string.format(Loc ["STRING_KEYBIND_TOGGLE_WINDOW"], 1)
			_G ["BINDING_NAME_DETAILS_TOOGGLE_WINDOW2"] = string.format(Loc ["STRING_KEYBIND_TOGGLE_WINDOW"], 2)
			_G ["BINDING_NAME_DETAILS_TOOGGLE_WINDOW3"] = string.format(Loc ["STRING_KEYBIND_TOGGLE_WINDOW"], 3)
			_G ["BINDING_NAME_DETAILS_TOOGGLE_WINDOW4"] = string.format(Loc ["STRING_KEYBIND_TOGGLE_WINDOW"], 4)
			_G ["BINDING_NAME_DETAILS_TOOGGLE_WINDOW5"] = string.format(Loc ["STRING_KEYBIND_TOGGLE_WINDOW"], 5)

			_G ["BINDING_NAME_DETAILS_BOOKMARK1"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 1)
			_G ["BINDING_NAME_DETAILS_BOOKMARK2"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 2)
			_G ["BINDING_NAME_DETAILS_BOOKMARK3"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 3)
			_G ["BINDING_NAME_DETAILS_BOOKMARK4"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 4)
			_G ["BINDING_NAME_DETAILS_BOOKMARK5"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 5)
			_G ["BINDING_NAME_DETAILS_BOOKMARK6"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 6)
			_G ["BINDING_NAME_DETAILS_BOOKMARK7"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 7)
			_G ["BINDING_NAME_DETAILS_BOOKMARK8"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 8)
			_G ["BINDING_NAME_DETAILS_BOOKMARK9"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 9)
			_G ["BINDING_NAME_DETAILS_BOOKMARK10"] = string.format(Loc ["STRING_KEYBIND_BOOKMARK_NUMBER"], 10)
	--]=]
end

local classCacheName = Details222.ClassCache.ByName
local classCacheGUID = Details222.ClassCache.ByGUID

function Details222.ClassCache.GetClassFromCache(value)
	return classCacheName[value] or classCacheGUID[value]
end

function Details222.ClassCache.AddClassToCache(value, whichCache)
	if (whichCache == "name") then
		classCacheName[value] = true
	elseif (whichCache == "guid") then
		classCacheGUID[value] = true
	end
end

function Details222.ClassCache.GetClass(value)
	local className = Details222.ClassCache.ByName[value] or Details222.ClassCache.ByGUID[value]
	if (className) then
		return className
	end

	local _, unitClass = UnitClass(value)
	return unitClass
end

function Details222.ClassCache.MakeCache()
	--iterage among all segments in the container history, get the damage container and get the actor list, check if the actor is a player and if it is, get the class and store it in the cache
	local segmentsTable = Details:GetCombatSegments()
	for _, combatObject in ipairs(segmentsTable) do
		for _, actorObject in combatObject:GetContainer(DETAILS_ATTRIBUTE_DAMAGE):ListActors() do
			if (actorObject:IsPlayer()) then
				local actorName = actorObject.nome
				local actorClass = actorObject.classe
				local actorGUID = actorObject.serial
				Details222.ClassCache.ByName[actorName] = actorClass
				Details222.ClassCache.ByGUID[actorGUID] = actorClass
			end
		end
	end
end

Details222.UnitIdCache.Party = {"player"}
Details222.UnitIdCache.PartyPet = {"playerpet"}
for i = 1, 4 do
	table.insert(Details222.UnitIdCache.Party, "party" .. i)
	table.insert(Details222.UnitIdCache.PartyPet, "partypet" .. i)
end

Details222.UnitIdCache.Raid = {}
Details222.UnitIdCache.RaidPet = {}
Details222.UnitIdCache.RaidTargets = {}
for i = 1, 40 do
	Details222.UnitIdCache.Raid[i] = "raid" .. i
	Details222.UnitIdCache.RaidPet[i] = "raidpet" .. i
	Details222.UnitIdCache.RaidTargets[i] = "raidtarget" .. i
end

Details222.UnitIdCache.Boss = {}
for i = 1, 9 do
	Details222.UnitIdCache.Boss[i] = "boss" .. i
end

Details222.UnitIdCache.Nameplate = {}
for i = 1, 40 do
	Details222.UnitIdCache.Nameplate[i] = "nameplate" .. i
end

Details222.UnitIdCache.Arena = {}
for i = 1, 5 do
	Details222.UnitIdCache.Arena[i] = "arena" .. i
end


function Details222.Tables.MakeWeakTable(mode)
	local newTable = {}
	setmetatable(newTable, {__mode = mode or "v"})
	return newTable
end

--STRING_CUSTOM_POT_DEFAULT

---add a statistic, log, or any other data to the player stat table
---@param statName string
---@param value number
function Details222.PlayerStats:AddStat(statName, value)
	Details.player_stats[statName] = (Details.player_stats[statName] or 0) + value
end

---get the value of a saved stat
---@param statName string
---@return any
function Details222.PlayerStats:GetStat(statName)
	return Details.player_stats[statName]
end

---same thing as above but set the value instead of adding
---@param statName string
---@param value number
function Details222.PlayerStats:SetStat(statName, value)
	Details.player_stats[statName] = value
end

local profileStartFunc = function(functionName)
	local profile = Details222.ProfilingCache[functionName]

	if (not profile) then
		Details222.ProfilingCache[functionName] = {elapsed = 0, startTime = 0, runs = 0}
		profile = Details222.ProfilingCache[functionName]
	end

	profile.startTime = debugprofilestop()
	profile.runs = profile.runs + 1
end

local profileStopFunc = function(functionName)
	local profile = Details222.ProfilingCache[functionName]
	if (profile) then
		profile.elapsed = profile.elapsed + debugprofilestop() - profile.startTime
	end
end

function Details222.Profiling.ProfileStart()end
function Details222.Profiling.ProfileStop()end

function Details222.Profiling.EnableProfiler()
	Details222.Profiling.ProfileStart = profileStartFunc
	Details222.Profiling.ProfileStop = profileStopFunc
end

function Details222.Profiling.DisableProfiler()
	Details222.Profiling.ProfileStart = function()end
	Details222.Profiling.ProfileStop = function()end
end

function Details222.Profiling.ResetProfiler()
	table.wipe(Details222.ProfilingCache)
end

if (select(4, GetBuildInfo()) >= 100000) then
	Details222.Profiling.EnableProfiler()
end

function Details:ProfilerResult()
	local resultTable = {}
	local total = 0

	for functionName, profile in pairs(Details222.ProfilingCache) do
		local runTime = string.format("%.3f", profile.elapsed / 1000)
		resultTable[functionName] = runTime .. " ms | runs: " .. profile.runs
		total = total + profile.elapsed
	end

	resultTable["Total"] = string.format("%.3f", total / 1000) .. " ms"
	dumpt(resultTable)
end
function Details:ResetProfilerResult()

end

---destroy a table and remove it from the object, if the key isn't passed, the object itself is destroyed
---@param object any
---@param key string|nil
function Details:Destroy(object, key)
	if (key) then
		if (getmetatable(object[key])) then
			setmetatable(object[key], nil)
		end
		object[key].__index = nil
		table.wipe(object[key])
		object[key] = nil
	else
		if (getmetatable(object)) then
			setmetatable(object, nil)
		end
		object.__index = nil
		table.wipe(object)
	end
end

function Details:DestroyCombat(combatObject)
	--destroy each individual actor, hence more cleanups are done
	for i = 1, DETAILS_COMBAT_AMOUNT_CONTAINERS do
		local actorContainer = combatObject:GetContainer(i)
		for index, actorObject in actorContainer:ListActors() do
			Details:DestroyActor(actorObject, actorContainer, combatObject, 3)
		end
	end

	setmetatable(combatObject, nil)
	combatObject.__index = nil
	combatObject.__newindex = nil
	combatObject.__call = nil
	Details:Destroy(combatObject)
	--leave a trace that the actor has been deleted
	combatObject.__destroyed = true
	combatObject.__destroyedBy = debugstack(2, 1, 0)
end

---destroy the actor, also calls container:RemoveActor(actor)
---@param self details
---@param actorObject actor
---@param actorContainer actorcontainer
---@param combatObject combat
function Details:DestroyActor(actorObject, actorContainer, combatObject, callStackDepth)
	local containerType = actorContainer:GetType()
	local combatTotalsTable = combatObject.totals[containerType] --without group
	local combatTotalsTableInGroup = combatObject.totals_grupo[containerType] --with group

	--remove the actor from the parser cache
	local c1, c2, c3, c4 = Details222.Cache.GetParserCacheTables()
	c1[actorObject.serial] = nil
	c2[actorObject.serial] = nil
	c3[actorObject.serial] = nil
	c4[actorObject.serial] = nil

	if (not actorObject.ownerName) then --not a pet
		if (containerType == 1 or containerType == 2) then --damage|healing done
			combatTotalsTable = combatTotalsTable - actorObject.total
			if (actorObject.grupo) then
				combatTotalsTableInGroup = combatTotalsTableInGroup - actorObject.total
			end

		elseif (containerType == 3) then
			---@cast actorObject actorresource
			if (actorObject.total and actorObject.total > 0) then
				if (actorObject.powertype) then
					combatTotalsTable[actorObject.powertype] = combatTotalsTable[actorObject.powertype] - actorObject.total
					combatTotalsTableInGroup[actorObject.powertype] = combatTotalsTableInGroup[actorObject.powertype] - actorObject.total
				end
			end
			if (actorObject.alternatepower and actorObject.alternatepower > 0) then
				combatTotalsTable.alternatepower = combatTotalsTable.alternatepower - actorObject.alternatepower
				combatTotalsTableInGroup.alternatepower = combatTotalsTableInGroup.alternatepower - actorObject.alternatepower
			end

		elseif (containerType == 4) then
			---@cast actorObject actorutility
			--decrease the amount of CC break from the combat totals
			if (actorObject.cc_break and actorObject.cc_break > 0) then
				if (combatTotalsTable.cc_break) then
					combatTotalsTable.cc_break = combatTotalsTable.cc_break - actorObject.cc_break
				end
				if (combatTotalsTableInGroup.cc_break) then
					combatTotalsTableInGroup.cc_break = combatTotalsTableInGroup.cc_break - actorObject.cc_break
				end
			end

			--decrease the amount of dispell from the combat totals
			if (actorObject.dispell and actorObject.dispell > 0) then
				if (combatTotalsTable.dispell) then
					combatTotalsTable.dispell = combatTotalsTable.dispell - actorObject.dispell
				end
				if (combatTotalsTableInGroup.dispell) then
					combatTotalsTableInGroup.dispell = combatTotalsTableInGroup.dispell - actorObject.dispell
				end
			end

			--decrease the amount of interrupt from the combat totals
			if (actorObject.interrupt and actorObject.interrupt > 0) then
				if (combatTotalsTable.interrupt) then
					combatTotalsTable.interrupt = combatTotalsTable.interrupt - actorObject.interrupt
				end
				if (combatTotalsTableInGroup.interrupt) then
					combatTotalsTableInGroup.interrupt = combatTotalsTableInGroup.interrupt - actorObject.interrupt
				end
			end

			--decrease the amount of ress from the combat totals
			if (actorObject.ress and actorObject.ress > 0) then
				if (combatTotalsTable.ress) then
					combatTotalsTable.ress = combatTotalsTable.ress - actorObject.ress
				end
				if (combatTotalsTableInGroup.ress) then
					combatTotalsTableInGroup.ress = combatTotalsTableInGroup.ress - actorObject.ress
				end
			end

			--decrease the amount of dead from the combat totals
			if (actorObject.dead and actorObject.dead > 0) then
				if (combatTotalsTable.dead) then
					combatTotalsTable.dead = combatTotalsTable.dead - actorObject.dead
				end
				if (combatTotalsTableInGroup.dead) then
					combatTotalsTableInGroup.dead = combatTotalsTableInGroup.dead - actorObject.dead
				end
			end

			--decreate the amount of cooldowns used from the combat totals
			if (actorObject.cooldowns_defensive and actorObject.cooldowns_defensive > 0) then
				if (combatTotalsTable.cooldowns_defensive) then
					combatTotalsTable.cooldowns_defensive = combatTotalsTable.cooldowns_defensive - actorObject.cooldowns_defensive
				end
				if (combatTotalsTableInGroup.cooldowns_defensive) then
					combatTotalsTableInGroup.cooldowns_defensive = combatTotalsTableInGroup.cooldowns_defensive - actorObject.cooldowns_defensive
				end
			end

			--decrease the amount of buff uptime from the combat totals
			if (actorObject.buff_uptime and actorObject.buff_uptime > 0) then
				if (combatTotalsTable.buff_uptime) then
					combatTotalsTable.buff_uptime = combatTotalsTable.buff_uptime - actorObject.buff_uptime
				end
				if (combatTotalsTableInGroup.buff_uptime) then
					combatTotalsTableInGroup.buff_uptime = combatTotalsTableInGroup.buff_uptime - actorObject.buff_uptime
				end
			end

			--decrease the amount of debuff uptime from the combat totals
			if (actorObject.debuff_uptime and actorObject.debuff_uptime > 0) then
				if (combatTotalsTable.debuff_uptime) then
					combatTotalsTable.debuff_uptime = combatTotalsTable.debuff_uptime - actorObject.debuff_uptime
				end
				if (combatTotalsTableInGroup.debuff_uptime) then
					combatTotalsTableInGroup.debuff_uptime = combatTotalsTableInGroup.debuff_uptime - actorObject.debuff_uptime
				end
			end
		end
	end

	Details222.TimeMachine.RemoveActor(actorObject)

	local actorName = actorObject:Name()
	combatObject:RemoveActorFromSpellCastTable(actorName)

	setmetatable(actorObject, nil)
	actorObject.__index = nil
	actorObject.__newindex = nil
	Details:Destroy(actorObject)

	--leave a trace that the actor has been deleted
	actorObject.__destroyed = true
	actorObject.__destroyedBy = debugstack(callStackDepth or 2, 1, 0)
end