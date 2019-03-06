--Keeps track of which Bonus buttons were showing last time we checked
BONUS_BUTTONS_OFFSET = 0;

--Keeps track of whether we have a pet with an action bar
PET_WITH_ACTION_BAR = nil;

function ACUI_LinkFrameToDragButton(dragbutton, component, side, x_offset, y_offset)
	getglobal(component):ClearAllPoints();
	if(side == "RIGHT") then
		getglobal(component):SetPoint("TOPLEFT", dragbutton, "TOPRIGHT", x_offset, y_offset);
	elseif(side == "ABOVE") then
		getglobal(component):SetPoint("BOTTOMLEFT", dragbutton, "TOPLEFT", x_offset, y_offset);
	elseif(side == "BEHIND") then
		getglobal(component):SetPoint("TOP", dragbutton, "TOP", x_offset, y_offset);
	end
end

function RemoveMainActionBar()
	MainMenuBarTexture0:Hide();
	MainMenuBarTexture1:Hide();
	MainMenuBarTexture2:Hide();
	MainMenuBarTexture3:Hide();
	MainMenuBarLeftEndCap:Hide();
	MainMenuBarRightEndCap:Hide();
	MainMenuBarOverlayFrame:Hide();
	MainMenuBarArtFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	MainMenuBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	for i = 1, 12 do
		getglobal("ActionButton"..i):Hide();
	end
	ActionBarUpButton:Hide();
	ActionBarDownButton:Hide();
	ExhaustionTick:Hide();
	ShapeshiftBarLeft:Hide();
	ShapeshiftBarMiddle:Hide();
	ShapeshiftBarRight:Hide();
	ShapeshiftBarFrame:ClearAllPoints();
	ShapeshiftBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	BonusActionBarTexture0:ClearAllPoints();
	BonusActionBarTexture0:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	BonusActionBarFrame:ClearAllPoints();
	BonusActionBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	SlidingActionBarTexture0:ClearAllPoints();
	SlidingActionBarTexture0:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	MainMenuExpBar:ClearAllPoints();
	MainMenuExpBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	PetActionBarFrame:ClearAllPoints();
	PetActionBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
end

--Keeps track of UI changes that should affect the main action bar, and changes it accordingly
function UpdateACUI_MainActionBar()
	local button;
	local bonusButtonsOffset = GetBonusBarOffset();

	if (BONUS_BUTTONS_OFFSET ~= bonusButtonsOffset) then
		BONUS_BUTTONS_OFFSET = bonusButtonsOffset;
		ChangeACUI_ActionBarPage();
	end
end

function ConstructACUI_MicroBar()
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("BOTTOMLEFT", this:GetName(), "BOTTOMLEFT", 0, 0);
	ACUI_GreenButtonsToggle:SetPoint("BOTTOMLEFT", "HelpMicroButton", "BOTTOMRIGHT", 2, 0);
	MainMenuBar:SetScale(0.8);
end


function UpdateACUI_GreenButtons()
	if(GreenButtonsDisabled and GreenButtonsDisabled[UnitName("player")]) then
		ACUI_ShapeshiftBarDragButton:Hide();
		ACUI_PetBarDragButton:Hide();
		ACUI_ActionBarMicroDragButton:Hide();
		ACUI_BagBarDragButton:Hide();
	else
		ACUI_ShapeshiftBarDragButton:Show();
		ACUI_PetBarDragButton:Show();
		ACUI_ActionBarMicroDragButton:Show();
		ACUI_BagBarDragButton:Show();
	end
end

function UpdateACUI_GreenButtonsToggle()
	if(GreenButtonsDisabled and GreenButtonsDisabled[UnitName("player")]) then
		this:SetNormalTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_GreenButtonsDisabled");
		this:SetPushedTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_GreenButtonsEnabled");
	else
		this:SetNormalTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_GreenButtonsEnabled");
		this:SetPushedTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_GreenButtonsDisabled");
	end
end

function UpdateACUI_ButtonsHideGridToggle()
	if(ACUI_ButtonsHideGrid and ACUI_ButtonsHideGrid[UnitName("player")]) then
		this:SetNormalTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_HideGrid");
		this:SetPushedTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_ShowGrid");
	else
		this:SetNormalTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_ShowGrid");
		this:SetPushedTexture("Interface\\AddOns\\ACUI_Toolbars\\ACUI_HideGrid");
	end
end

function ConstructACUI_BagBar()
	CharacterBag3Slot:ClearAllPoints();
	CharacterBag3Slot:SetPoint("BOTTOMLEFT", this:GetName());
	CharacterBag3Slot:SetScale(0.8);
	CharacterBag2Slot:ClearAllPoints();
	CharacterBag2Slot:SetPoint("LEFT", "CharacterBag3Slot", "RIGHT", 2, 0);
	CharacterBag2Slot:SetScale(0.8);
	CharacterBag1Slot:ClearAllPoints();
	CharacterBag1Slot:SetPoint("LEFT", "CharacterBag2Slot", "RIGHT", 2, 0);
	CharacterBag1Slot:SetScale(0.8);
	CharacterBag0Slot:ClearAllPoints();
	CharacterBag0Slot:SetPoint("LEFT", "CharacterBag1Slot", "RIGHT", 2, 0);
	CharacterBag0Slot:SetScale(0.8);
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("LEFT", "CharacterBag0Slot", "RIGHT", 2, 0);
	MainMenuBarBackpackButton:SetScale(0.8);
end

function ConstructACUI_PetBar() 
	for i=1, 12 do
		pet_button = getglobal("PetActionButton"..i); 
		if (pet_button ~= nil) then
			pet_button:ClearAllPoints();
			pet_button:SetPoint("TOPLEFT", this:GetName(), "TOPLEFT", 2 + ((i - 1) * 33), -1); 
			pet_button:SetScale(0.8); 
		end 
	end 
end

function ConstructACUI_ShapeshiftBar()
	for i=1, 10 do
		shapeshift_button = getglobal("ShapeshiftButton"..i);
		shapeshift_button:ClearAllPoints();
		shapeshift_button:SetPoint("TOPLEFT", this:GetName(), "TOPLEFT", 4 + ((i - 1) * 39), -4);
		shapeshift_button:SetScale(0.8);
	end
end

