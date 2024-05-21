
local Details = Details
local DF = DetailsFramework
local _

--namespace
Details.AuraTracker = {
    buff = {},
    debuff = {},
}

--frame options
local windowWidth = 800
local windowHeight = 670
local scrollWidth = 790
local scrollHeightBuff = 400
local scrollHeightDebuff = 200
local scrollLineAmountBuff = 20
local scrollLineAmountDebuff = 10
local scrollLineHeight = 20

--templates
local dropdownTemplate = DetailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWNDARK_TEMPLATE")

function Details.AuraTracker.AddAura(auraType, spellid)
    Details.AuraTracker[auraType][spellid] = true
end



local function HandleAuraBuff(...)
    local auraInfo = AuraUtil.PackAuraData(...)
    Details.AuraTracker.buff[auraInfo.spellId] = auraInfo
end

local function HandleAuraDebuff(...)
    local auraInfo = AuraUtil.PackAuraData(...)
    Details.AuraTracker.debuff[auraInfo.spellId] = auraInfo
end

local doFullAuraUpdate = function()
    Details:Destroy(Details.AuraTracker.buff)
    Details:Destroy(Details.AuraTracker.debuff)

    local unitId = "player"

    local batchCount = nil
    local usePackedAura = true
    AuraUtil.ForEachAura(unitId, "HELPFUL", batchCount, HandleAuraBuff, usePackedAura)
    AuraUtil.ForEachAura(unitId, "HARMFUL", batchCount, HandleAuraDebuff, usePackedAura)

    unitId = "pet"
    AuraUtil.ForEachAura(unitId, "HELPFUL", batchCount, HandleAuraBuff, usePackedAura)
    AuraUtil.ForEachAura(unitId, "HARMFUL", batchCount, HandleAuraDebuff, usePackedAura)

    Details.AuraTracker.RefreshScrollData()
end

function Details.AuraTracker.OnShowAuraTrackerFrame(auraTrackerFrame)
    doFullAuraUpdate()
    auraTrackerFrame.EventFrame:RegisterUnitEvent("UNIT_AURA", "player")
end

function Details.AuraTracker.OnHideAuraTrackerFrame(auraTrackerFrame)
    auraTrackerFrame.EventFrame:UnregisterEvent("UNIT_AURA")
end

function Details.AuraTracker.CreatePanel()
    --create a panel
    local auraTrackerFrame = DetailsFramework:CreateSimplePanel(UIParent)
    auraTrackerFrame:SetSize(windowWidth, windowHeight)
    auraTrackerFrame:SetTitle("Details! Aura Tracker")

    --disable the buil-in mouse integration of the simple panel, doing this to use LibWindow-1.1 as the window management
    auraTrackerFrame:SetScript("OnMouseDown", nil)
    auraTrackerFrame:SetScript("OnMouseUp", nil)

    Details.AuraTracker.AuraTrackerFrame = auraTrackerFrame
    auraTrackerFrame.data = {
        buffs = {},
        debuffs = {},
    }

    auraTrackerFrame.EventFrame = CreateFrame("frame")
    auraTrackerFrame.EventFrame:SetScript("OnEvent", Details.AuraTracker.OnUnitAuraEvent)

    --register in the libWindow
    local LibWindow = LibStub("LibWindow-1.1")
    LibWindow.RegisterConfig(auraTrackerFrame, Details.aura_tracker_frame.position)
    LibWindow.MakeDraggable(auraTrackerFrame)
    LibWindow.RestorePosition(auraTrackerFrame)

    --scale bar
    local scaleBar = DetailsFramework:CreateScaleBar(auraTrackerFrame, Details.aura_tracker_frame.scaletable)
    auraTrackerFrame:SetScale(Details.aura_tracker_frame.scaletable.scale)

    --status bar
    local statusBar = DetailsFramework:CreateStatusBar(auraTrackerFrame)
    statusBar.text = statusBar:CreateFontString(nil, "overlay", "GameFontNormal")
    statusBar.text:SetPoint("left", statusBar, "left", 5, 0)
    statusBar.text:SetText("By Terciob | Part of Details! Damage Meter")
    DetailsFramework:SetFontSize(statusBar.text, 11)
    DetailsFramework:SetFontColor(statusBar.text, "gray")

    --header
    local headerTable = {
        {text = "", width = 20},
        {text = "Aura Name", width = 162},
        {text = "Spell Id", width = 100},
        {text = "Lua Table", width = 200},
    }
    local headerOptions = {
        padding = 2,
    }

    auraTrackerFrame.Header = DetailsFramework:CreateHeader(auraTrackerFrame, headerTable, headerOptions)
    auraTrackerFrame.Header:SetPoint("topleft", auraTrackerFrame, "topleft", 5, -22)

    --create a scroll to show all buffs
    local buffScroll = DetailsFramework:CreateScrollBox(auraTrackerFrame, "$parentBuffScrollBox", Details.AuraTracker.RefreshScroll, auraTrackerFrame.data.buffs, scrollWidth, scrollHeightBuff, scrollLineAmountBuff, scrollLineHeight)
    DetailsFramework:ReskinSlider(buffScroll)
    buffScroll:CreateLines(Details.AuraTracker.CreateScrollLine, scrollLineAmountBuff)
    buffScroll:SetPoint("topleft", auraTrackerFrame, "topleft", 5, -42)
    auraTrackerFrame.BuffScroll = buffScroll

    --create a scroll to show all debuffs
    local debuffScroll = DetailsFramework:CreateScrollBox(auraTrackerFrame, "$parentDebuffScrollBox", Details.AuraTracker.RefreshScroll, auraTrackerFrame.data.debuffs, scrollWidth, scrollHeightDebuff, scrollLineAmountDebuff, scrollLineHeight)
    debuffScroll:CreateLines(Details.AuraTracker.CreateScrollLine, scrollLineAmountDebuff)
    DetailsFramework:ReskinSlider(debuffScroll)
    debuffScroll:SetPoint("topleft", buffScroll, "bottomleft", 0, -2)
    auraTrackerFrame.DebuffScroll = debuffScroll

    Details.AuraTracker.framesCreated = true
end

local formatToLuaTable = {
    --[232698] = 1, --Shadowform
    doFormat1 = function(auraInfo)
        return "[" .. auraInfo.spellId .. "] = 1, --" .. auraInfo.name
    end,
}

--if you need your own table format, override the function below as: function(auraInfo) return "" end
--[[GLOBAL]] DETAILS_AURATRACKER_LUATABLE_FUNC = nil

--[371354] = {[131] = 1, [151] = 2, [174] = 3, [1] = 131, [2] = 151, [3] = 174}, --Phial of the Eye in the Storm

function Details.AuraTracker.RefreshScroll(self, data, offset, totalLines)
    for i = 1, totalLines do
        local index = i + offset
        local auraInfo = data[index]

        if (auraInfo) then
            local line = self:GetLine(i)
            line.Icon.texture = auraInfo.icon
            line.Name.text = auraInfo.name
            line.SpellId.text = auraInfo.spellId
            local globalfunc = DETAILS_AURATRACKER_LUATABLE_FUNC
            line.LuaTableEntry.text = globalfunc and globalfunc(auraInfo) or formatToLuaTable.doFormat1(auraInfo) --doFormat2NoIndex

            line.Name:SetCursorPosition(0)
            line.LuaTableEntry:SetCursorPosition(0)
        end
    end
end

function Details.AuraTracker.RefreshScrollData()
    local buffData = {}
    for spellId, auraInfo in pairs(Details.AuraTracker.buff) do
        buffData[#buffData+1] = auraInfo
    end

    local debuffData = {}
    for spellId, auraInfo in pairs(Details.AuraTracker.debuff) do
        debuffData[#debuffData+1] = auraInfo
    end

    Details.AuraTracker.AuraTrackerFrame.BuffScroll:SetData(buffData)
    Details.AuraTracker.AuraTrackerFrame.BuffScroll:Refresh()
    Details.AuraTracker.AuraTrackerFrame.DebuffScroll:SetData(debuffData)
    Details.AuraTracker.AuraTrackerFrame.DebuffScroll:Refresh()
end

function Details.AuraTracker.OnUnitAuraEvent(self, event, unit)
    if unit ~= "player" and unit ~= "pet" then
        return
    end
    doFullAuraUpdate(unit)
end

function Details.AuraTracker.CreateScrollLine(self, lineId)
    local line = CreateFrame("frame", "$parentLine" .. lineId, self, "BackdropTemplate")
    line.lineId = lineId

    line:SetPoint("topleft", self, "topleft", 2, (scrollLineHeight * (lineId - 1) * -1) - 2)
    line:SetPoint("topright", self, "topright", -2, (scrollLineHeight * (lineId - 1) * -1) - 2)
    line:SetHeight(scrollLineHeight)

    DetailsFramework:Mixin(line, DetailsFramework.HeaderFunctions)
    DetailsFramework.BackdropUtil:SetColorStripe(line, lineId)

    local header = self:GetParent().Header

    --aura icon
    local auraIconTexture = DetailsFramework:CreateTexture(line, "", scrollLineHeight - 2, scrollLineHeight - 2, "overlay", {.1, .9, .1, .9})

    --aura name
    local auraNameTextField = DetailsFramework:CreateTextEntry(line, function()end, header:GetColumnWidth(2), scrollLineHeight, _, _, _, dropdownTemplate)
    auraNameTextField:SetJustifyH("left")
    auraNameTextField:SetTextInsets(3, 3, 0, 0)
    auraNameTextField:SetAutoSelectTextOnFocus(true)

    --spellId text field
    local spellIdTextField = DetailsFramework:CreateTextEntry(line, function()end, header:GetColumnWidth(3), scrollLineHeight, _, _, _, dropdownTemplate)
    spellIdTextField:SetJustifyH("left")
    spellIdTextField:SetTextInsets(3, 3, 0, 0)
    spellIdTextField:SetAutoSelectTextOnFocus(true)

    --formatted lua table
    local luaTableEntryTextField = DetailsFramework:CreateTextEntry(line, function()end, header:GetColumnWidth(4), scrollLineHeight, _, _, _, dropdownTemplate)
    luaTableEntryTextField:SetJustifyH("left")
    luaTableEntryTextField:SetTextInsets(3, 3, 0, 0)
    luaTableEntryTextField:SetAutoSelectTextOnFocus(true)

    line:AddFrameToHeaderAlignment(auraIconTexture)
    line:AddFrameToHeaderAlignment(auraNameTextField)
    line:AddFrameToHeaderAlignment(spellIdTextField)
    line:AddFrameToHeaderAlignment(luaTableEntryTextField)

    line:AlignWithHeader(header, "left")

    line.Icon = auraIconTexture
    line.Name = auraNameTextField
    line.SpellId = spellIdTextField
    line.LuaTableEntry = luaTableEntryTextField

    return line
end

function Details.AuraTracker.Open()
    if (not Details.AuraTracker.framesCreated) then
        Details.AuraTracker.CreatePanel()
    end
    Details.AuraTracker.AuraTrackerFrame:Show()
    Details.AuraTracker.OnShowAuraTrackerFrame(Details.AuraTracker.AuraTrackerFrame)
end

function Details.AuraTracker.Close()
    if (Details.AuraTracker.framesCreated) then
        Details.AuraTracker.AuraTrackerFrame:Hide()
        Details.AuraTracker.OnHideAuraTrackerFrame(Details.AuraTracker.AuraTrackerFrame)
    end
end