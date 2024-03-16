local SKIN = {}

SKIN.bg_color = Color(0, 0, 0, 220)
SKIN.bg_color_sleep = Color(0, 0, 0, 255)
SKIN.bg_color_dark = Color(0, 0, 0, 255)
SKIN.bg_color_bright = Color(60, 60, 60, 220)

SKIN.control_color = Color(120, 120, 120, 180)
SKIN.control_color_highlight = Color(150, 150, 150, 180)
SKIN.control_color_active = Color(110, 240, 150, 180)
SKIN.control_color_bright = Color(235, 235, 100, 180)
SKIN.control_color_dark = Color(100, 100, 100, 180)

SKIN.panel_transback = Color(0, 0, 0, 220)

SKIN.bg_alt1 = Color(0, 0, 0, 220)
SKIN.bg_alt2 = Color(45, 40, 25, 220)

SKIN.listview_hover = Color(70, 70, 70, 255)
SKIN.listview_selected = Color(100, 170, 220, 255)

SKIN.text_bright = Color(255, 255, 255, 255)
SKIN.text_normal = Color(230, 230, 60, 255)
SKIN.text_dark = Color(200, 200, 20, 255)
SKIN.text_highlight = Color(255, 255, 75, 255)

SKIN.panel_transback = Color(255, 255, 255, 50)
SKIN.tooltip = Color(255, 200, 175, 220)

SKIN.colButtonText = Color(255, 177, 0, 255)
SKIN.colButtonTextDisabled = Color(95, 56, 0, 255)
SKIN.colButtonBorder = Color(95, 56, 0, 255)
SKIN.colButtonBorderHighlight = Color(255, 177, 0, 255)
SKIN.colButtonBorderShadow = Color(0, 0, 0, 0)

SKIN.fontFrame = "Default"

function SKIN:PaintVScrollBar(panel)
end

function SKIN:PaintPanelList(panel)
end

function SKIN:DrawGenericBackground(x, y, w, h, color)
	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.DrawRect(x, y, w, h)
	surface.SetDrawColor(95, 56, 0, 255)
	surface.DrawOutlinedRect(x, y, w, h)
end

function SKIN:LayoutFrame(panel)
	local lblTitle = panel.lblTitle
	local strfont = panel.fontFrame or self.fontFrame
	lblTitle:SetFont(strfont)
	lblTitle:SetTextColor(COLOR_TEXTYELLOW)
	lblTitle:SetPos(8, 8)
	surface.SetFont(strfont)
	local txtw, txth = surface.GetTextSize("Test")
	lblTitle:SetSize(panel:GetWide() - 32, txth)
	lblTitle:SetMouseInputEnabled(false)
	lblTitle:SetKeyboardInputEnabled(false)

	panel.btnClose:SetPos(panel:GetWide() - 22, 4)
	panel.btnClose:SetSize(18, 18)
end

function SKIN:PaintButton(panel)
	if panel.m_bBackground then
		local pw, ph = panel:GetSize()
		local col = COLOR_LINEYELLOW

		if panel:GetDisabled() then
			col = color_black
		elseif panel.Depressed || panel:GetSelected() then
			col = color_white
		elseif panel.Hovered then
			col = color_white
		end

		surface.SetDrawColor(col.r, col.g, col.b, col.a)
		surface.DrawOutlinedRect(0, 0, pw, ph)
	end
end

function SKIN:PaintOverButton(panel)
	--[[local w, h = panel:GetSize()
	if panel.m_bBorder then
		if panel:GetDisabled() then
			self:DrawDisabledButtonBorder( 0, 0, w, h )
		else
			self:DrawButtonBorder(0, 0, w, h, panel.Depressed || panel:GetSelected())
		end
	end]]
end

function SKIN:DrawGenericBackground(x, y, w, h, color)
	draw.RoundedBox(8, x, y, w, h, color)
end

local color_black_alpha220 = Color(0, 0, 0, 220)
function SKIN:PaintFrame(panel)
	local pw, pt = panel:GetSize()
	draw.RoundedBox(16, 0, 0, pw, pt, color_black_alpha220)
end

surface.CreateFont("trebuchet", 18, 500, true, false, "dbuttonfont")

function SKIN:DrawButtonBorder(x, y, w, h, depressed)
	if depressed then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawOutlinedRect(x, y, w, h)
	else
		surface.SetDrawColor(220, 220, 20, 255)
		surface.DrawOutlinedRect(x, y, w, h)
	end
end

derma.DefineSkin("awesomestrike", "Derma skin for Awesome Strike", SKIN, "Default")

function GM:ForceDermaSkin()
	return "awesomestrike"
end
