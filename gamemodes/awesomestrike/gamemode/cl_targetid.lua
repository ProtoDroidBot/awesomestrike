local color_black_alpha120 = Color(0, 0, 0, 120)
local color_black_alpha50 = Color(0, 0, 0, 50)

function GM:HUDDrawTargetID()
	if not MySelf:IsValid() then return end
	local trent = MySelf:GetEyeTrace().Entity
	if not trent:IsPlayer() then return end

	local x, y = w * 0.5, h * 0.5 + 30

	local col = team.GetColor(trent:Team())

	surface.SetFont("TargetID")
	local text = trent:Nick()
	draw.DrawText(text, "TargetID", x + 1, y + 1, color_black_alpha120, TEXT_ALIGN_CENTER)
	draw.DrawText(text, "TargetID", x + 2, y + 2, color_black_alpha50, TEXT_ALIGN_CENTER)
	draw.DrawText(text, "TargetID", x, y, col, TEXT_ALIGN_CENTER)

	if not MySelf:Alive() or trent:Team() == MySelf:Team() then
		local texw, texh = surface.GetTextSize(text)
		y = y + texh + 5

		local text2 = "Health: "..trent:Health()
		draw.SimpleText(text2, "TargetIDSmall", x + 1, y + 1, color_black_alpha120, TEXT_ALIGN_CENTER)
		draw.SimpleText(text2, "TargetIDSmall", x + 2, y + 2, color_black_alpha50, TEXT_ALIGN_CENTER)
		draw.SimpleText(text2, "TargetIDSmall", x, y, col, TEXT_ALIGN_CENTER)
	end
end

