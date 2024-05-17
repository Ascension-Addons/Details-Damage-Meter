
local detailsFramework = _G["DetailsFramework"]
if (not detailsFramework or not DetailsFrameworkCanLoad) then
	return
end

--namespace
detailsFramework.Items = {}

function detailsFramework.Items.GetContainerItemInfo(containerIndex, slotIndex)
	return GetContainerItemInfo(containerIndex, slotIndex)
end

function detailsFramework.Items.IsItemSoulbound(containerIndex, slotIndex)
    local bIsBound = select(11, detailsFramework.Items.GetContainerItemInfo(containerIndex, slotIndex))
    return bIsBound
end
