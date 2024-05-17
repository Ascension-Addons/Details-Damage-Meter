local _detalhes = 		_G.Details

--code from blizzard AlertFrames

function _detalhes:PlayGlow (frame)
	frame:Show()
	
	frame.glow:Show()
	frame.glow.animIn:Play()
	frame.shine:Show()
	frame.shine.animIn:Play()
	
	--PlaySound ("LFG_Rewards", "master")
end

--WatchFrame copy, got removed on WoD
local function DetailsTutorialAlertFrame_OnFinishSlideIn (frame)
	frame.ScrollChild.Shine:Show();
	frame.ScrollChild.IconShine:Show();
	frame.ScrollChild.Shine.Flash:Play();
	frame.ScrollChild.IconShine.Flash:Play();
end

local function DetailsTutorialAlertFrame_OnUpdate (frame, timestep)
	local animData = frame.animData;
	local height = animData.height;
	local scrollStart = animData.scrollStart;
	local scrollEnd = animData.scrollEnd;
	local endTime = animData.slideInTime + (animData.endDelay or 0);

	if (frame.startDelay) then
		frame.startDelay = frame.startDelay - timestep;
		if (frame.startDelay <= 0) then
			frame.startDelay = nil;
		else
			return;
		end
	end

	if (frame.isFirst) then
		height = height + 10;
		scrollEnd = scrollEnd - 10;
	end

	frame.totalTime = frame.totalTime+timestep;
	if (frame.totalTime > endTime) then
		frame.totalTime = endTime;
	end

	local scrollPos = scrollEnd;
	if (animData.slideInTime and animData.slideInTime > 0) then
		height = height*(frame.totalTime/animData.slideInTime);
		scrollPos = scrollStart + (scrollEnd-scrollStart)*(frame.totalTime/animData.slideInTime);
	end
	if ( animData.reverse ) then
		height = max(animData.height - height, 1);
	end
	frame:SetHeight(height);
	frame:UpdateScrollChildRect();
	frame:SetVerticalScroll(floor(scrollPos+0.5));

	if (frame.totalTime >= endTime) then
		frame:SetScript("OnUpdate", nil);
		if ( animData.onFinishFunc ) then
			animData.onFinishFunc(frame);
		end
	end
end

function DetailsTutorialAlertFrame_SlideInFrame (frame, animType)
	frame.totalTime = 0;
	frame.animData = { height = 72, scrollStart = 65, scrollEnd = -9, slideInTime = 0.4, onFinishFunc = DetailsTutorialAlertFrame_OnFinishSlideIn };
	frame.slideInTime = frame.animData.slideInTime;
	frame:SetHeight(1);
	if ( frame.animData.reverse ) then
		frame:SetHeight(frame.animData["height"]);
	else
		frame:SetHeight(1);
	end
	frame.startDelay = frame.animData.startDelay;
	frame:SetScript("OnUpdate", DetailsTutorialAlertFrame_OnUpdate);
end

function _detalhes.PlayBestDamageOnGuild (damage)

	damage = damage or 100000000

	--create the main frame
	local DetailsNewDamageRecord = CreateFrame("frame", "DetailsNewDamageRecordAnimationFrame", UIParent)
	DetailsNewDamageRecord:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
	DetailsNewDamageRecord:SetSize(300, 300)

	--single animation group
	local MainAnimationGroup = {
		Play = function()
			for _, animGroup in ipairs(self) do
				if animGroup.Play then
					animGroup.Play()
				end
			end
		end
	}

	--widgets:

	----------------------------------------------

	local BaseTexture  = DetailsNewDamageRecord:CreateTexture("BaseTextureTexture", "ARTWORK")
	BaseTexture:SetTexture([[Interface\ACHIEVEMENTFRAME\UI-Achievement-Alert-Background-Mini]])
	BaseTexture:SetDrawLayer("ARTWORK", -5)
	BaseTexture:SetPoint("center", DetailsNewDamageRecord, "center", 0, 0)
	BaseTexture:SetSize(256, 64)
	BaseTexture:SetVertexColor(0.99999779462814, 0.99999779462814, 0.99999779462814, 0.99999779462814)
	
	--animations for BaseTexture

	do
		local animGroup = BaseTexture:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (1)
		alpha:SetDuration(0)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
		
		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.14869952201843)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(1)
		alpha:SetStartDelay (5)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
	end
	----------------------------------------------

	local BigFlash  = DetailsNewDamageRecord:CreateTexture("BigFlashTexture", "OVERLAY")
	BigFlash:SetTexture([[Interface\ACHIEVEMENTFRAME\UI-Achievement-Alert-Glow]])
	BigFlash:SetDrawLayer("OVERLAY", 0)
	BigFlash:SetPoint("center", DetailsNewDamageRecord, "center", -2, 2)
	BigFlash:SetSize(314, 100)
	BigFlash:SetDesaturated(false)
	BigFlash:SetTexCoord(0.0010000000149012, 0.77400001525879, 0.0010000000149012, 0.65800003051758)
	if (0 ~= 0) then
	    BigFlash:SetRotation (0)
	end
	BigFlash:SetVertexColor(0.96470373868942, 0.98823314905167, 0.99999779462814, 0.99999779462814)
	BigFlash:SetAlpha(1)
	BigFlash:SetBlendMode("ADD")

	--animations for BigFlash
	do
		local animGroup = BigFlash:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (1)
		alpha:SetDuration(0)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.11600000411272)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(0.31600001454353)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
	end

	----------------------------------------------

	local FlashSwipe  = DetailsNewDamageRecord:CreateTexture("FlashSwipeTexture", "OVERLAY")
	FlashSwipe:SetTexture([[Interface\ACHIEVEMENTFRAME\UI-Achievement-Alert-Glow]])
	FlashSwipe:SetDrawLayer("OVERLAY", 7)
	FlashSwipe:SetPoint("center", DetailsNewDamageRecord, "center", -99, 0)
	FlashSwipe:SetSize(100, 57)
	FlashSwipe:SetDesaturated(false)
	FlashSwipe:SetTexCoord(0.78199996948242, 0.91900001525879, 0.0010000000149012, 0.2760000038147)
	if (0 ~= 0) then
	    FlashSwipe:SetRotation (0)
	end
	FlashSwipe:SetVertexColor(0.86666476726532, 0.54117530584335, 0, 0.99999779462814)
	FlashSwipe:SetAlpha(1)
	FlashSwipe:SetBlendMode("ADD")

	--animations for FlashSwipe
	do
		local animGroup = FlashSwipe:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetTarget (FlashSwipe)
		alpha:SetOrder (1)
		alpha:SetDuration()
		alpha:SetStartDelay ()
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.31600001454353)
		alpha:SetStartDelay (0.20000000298023)
		alpha:SetEndDelay (0)
		alpha:SetChange(0.501051902771)

		local translation = animGroup:CreateAnimation("TRANSLATION")
		translation:SetOrder (2)
		translation:SetDuration(0.81599998474121)
		translation:SetStartDelay (0.20000000298023)
		translation:SetEndDelay (0)
		translation:SetOffset (200, 0)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(0.31600001454353)
		alpha:SetStartDelay (0.69999998807907)
		alpha:SetEndDelay (0)
		alpha:SetChange(-0.501051902771)
	end

	----------------------------------------------

	local Portrait  = DetailsNewDamageRecord:CreateTexture("PortraitTexture", "OVERLAY")
	Portrait:SetTexture([[Interface\ARCHEOLOGY\ARCH-FLAREEFFECT]])
	Portrait:SetDrawLayer("OVERLAY", -5)
	Portrait:SetPoint("center", DetailsNewDamageRecord, "center", 3, 0)
	Portrait:SetSize(246, 44)
	Portrait:SetDesaturated(false)
	Portrait:SetTexCoord(0.051753740310669, 0.81701484680176, 0.086334381103516, 0.25102617263794)
	if (0 ~= 0) then
	    Portrait:SetRotation (0)
	end
	Portrait:SetVertexColor(0.99999779462814, 0.99999779462814, 0.99999779462814, 0.99999779462814)
	Portrait:SetAlpha(1)
	Portrait:SetBlendMode("BLEND")

	--animations for Portrait
	do
		local animGroup = Portrait:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")

		alpha:SetOrder (1)
		alpha:SetDuration(0)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.41600000858307)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(1)

		local scale = animGroup:CreateAnimation("SCALE")
		scale:SetOrder (1)
		scale:SetDuration(0)
		scale:SetStartDelay (0)
		scale:SetEndDelay (0)
		scale:SetScale (0.01, 0.01)
		scale:SetOrigin ("center", 0, 0)

		scale = animGroup:CreateAnimation("SCALE")
		scale:SetOrder (2)
		scale:SetDuration(0.21600000560284)
		scale:SetStartDelay (0)
		scale:SetEndDelay (0)
		scale:SetScale(100, 100)
		scale:SetOrigin ("center", 0, 0)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(1)
		alpha:SetStartDelay (4.7000002861023)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
	end

	----------------------------------------------

	local DamageIcon  = DetailsNewDamageRecord:CreateTexture("DamageIconTexture", "OVERLAY")
	DamageIcon:SetTexture([[Interface\LFGFRAME\UI-LFG-ICON-ROLES]])
	DamageIcon:SetDrawLayer("OVERLAY", 2)
	DamageIcon:SetPoint("center", DetailsNewDamageRecord, "center", -97, 1)
	DamageIcon:SetSize(32, 32)
	DamageIcon:SetDesaturated(false)
	DamageIcon:SetTexCoord(0.27200000762939, 0.51899997711182, 0.25837841033936, 0.51399997711182)
	if (0 ~= 0) then
	    DamageIcon:SetRotation (0)
	end
	DamageIcon:SetVertexColor(0.99999779462814, 0.99999779462814, 0.99999779462814, 0.99999779462814)
	DamageIcon:SetAlpha(1)
	DamageIcon:SetBlendMode("BLEND")

	--animations for DamageIcon
	do 
		local animGroup = DamageIcon:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (1)
		alpha:SetDuration(0)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.51599997282028)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0)
		alpha:SetChange(1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(1)
		alpha:SetStartDelay (4.5999999046326)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
	end

	----------------------------------------------

	local NewDamageRecord  = DetailsNewDamageRecord:CreateFontString("NewDamageRecordFontString", "OVERLAY")
	NewDamageRecord:SetFont([=[Fonts\FRIZQT__.TTF]=], 12, "OUTLINE")
	NewDamageRecord:SetText("Damage Record!")
	NewDamageRecord:SetDrawLayer("OVERLAY", 0)
	NewDamageRecord:SetPoint("center", DetailsNewDamageRecord, "center", 18, 7)
	NewDamageRecord:SetSize(181, 20)
	NewDamageRecord:SetTextColor(1, 1, 1)
	NewDamageRecord:SetAlpha(1)
	NewDamageRecord:SetJustifyH("CENTER")

	--animations for NewDamageRecord
	do
		local animGroup = NewDamageRecord:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (1)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0.016000000759959)
		alpha:SetChange(-1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.51599997282028)
		alpha:SetStartDelay (0.40000000596046)
		alpha:SetEndDelay (4.0999999046326)
		alpha:SetChange(1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(1)
		alpha:SetStartDelay (0.10000000149012)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
	end
	----------------------------------------------

	local DamageAmount  = DetailsNewDamageRecord:CreateFontString("DamageAmountFontString", "OVERLAY")
	DamageAmount:SetFont([=[Fonts\FRIZQT__.TTF]=], 12, "THICKOUTLINE")
	DamageAmount:SetText(_detalhes:comma_value (damage))
	DamageAmount:SetDrawLayer("OVERLAY", 0)
	DamageAmount:SetPoint("center", DetailsNewDamageRecord, "center", 18, -7)
	DamageAmount:SetSize(100, 20)
	DamageAmount:SetTextColor(1, 1, 1)
	DamageAmount:SetAlpha(1)
	DamageAmount:SetJustifyH("CENTER")

	--animations for DamageAmount
	do
		local animGroup = DamageAmount:CreateAnimationGroup()
		tinsert(MainAnimationGroup, animGroup)
		local alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (1)
		alpha:SetDuration(0)
		alpha:SetStartDelay (0)
		alpha:SetEndDelay (0.016000000759959)
		alpha:SetChange(-1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (2)
		alpha:SetDuration(0.51599997282028)
		alpha:SetStartDelay (0.40000000596046)
		alpha:SetEndDelay (0)
		alpha:SetChange(1)

		alpha = animGroup:CreateAnimation("ALPHA")
		alpha:SetOrder (3)
		alpha:SetDuration(1.0160000324249)
		alpha:SetStartDelay (4.2000002861023)
		alpha:SetEndDelay (0)
		alpha:SetChange(-1)
	end
	--test the animation
	MainAnimationGroup:Play()
end
