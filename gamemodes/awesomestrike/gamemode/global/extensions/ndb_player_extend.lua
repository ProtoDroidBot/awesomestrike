AddCSLuaFile("ndb_player_extend.lua")

local meta = FindMetaTable("Player")
if not meta then return end

function meta:GiveAward(nam)
	NDB.GiveAward(self, nam)
end

function meta:HasAward(nam)
	nam = string.lower(nam)
	for _, awdname in pairs(self.Awards) do
		if string.lower(awdname) == nam then
			return true
		end
	end

	return false
end

function meta:HasFlag(flag)
	flag = string.lower(flag)
	for i, myflag in pairs(self.Flags) do
		if myflag == flag then return true end
	end

	return false
end

function meta:GetDefaultTitle()
	local title

	if self:IsAdmin() then
		title = NDB.DefaultAdminTitle
	else
		title = NDB.DefaultMemberTitles[self.MemberLevel or MEMBER_DEFAULT] or NDB.DefaultMemberTitles[0] or "None"
	end

	if self.MemberLevel and MEMBER_NONE < self.MemberLevel then
		title = "<avatar>"..title
	end

	return title
end

function meta:GetDiscount()
	return NDB.MemberDiscounts[self.MemberLevel or MEMBER_DEFAULT] or 1
end

function meta:RemoveFlag(flag)
	flag = string.lower(flag)
	for i, myflag in ipairs(self.Flags) do
		if myflag == flag then
			table.remove(self.Flags, i)
			return true
		end
	end

	return false
end

function meta:GiveFlag(flag)
	flag = string.lower(flag)
	for i, myflag in pairs(self.Flags) do
		if myflag == flag then return true end
	end

	table.insert(self.Flags, flag)
	return true
end
meta.AddFlag = meta.GiveFlag

function meta:HasShopItem(item)
	return NDB.PlayerHasShopItem(self, item)
end

function meta:AddMoney(int)
	self:SetMoney(self:GetMoney() + int)
end

function meta:GetMoney()
	return self.Money
end

function meta:GetJetanium()
	return self.UsableJetanium or 0
end

function meta:GetTotalJetanium()
	return self.Jetanium or 0
end

function meta:AddJetanium(int)
	self:SetJetanium(self:GetJetanium() + int)
end

function meta:ConvertNet()
	return ConvertNet(self:SteamID())
end

function meta:GetHeadPosAng()
	local boneindex = self:LookupBone("ValveBiped.Bip01_Head1")
	if not boneindex then boneindex = self:LookupBone("ValveBiped.HC_BodyCube") end
	if boneindex then
		local pos, ang = self:GetBonePosition(boneindex)
		if pos then return pos, ang end
	end

	local attachment = self:LookupAttachment("eyes")
	if attachment == 0 then attachment = self:LookupAttachment("head") end
	if 0 < attachment then
		local attach = self:GetAttachment(attachment)
		return attach.Pos, attach.Ang, true
	end

	return self:GetPos() + Vector(0,0,64), self:GetUp():Angle(), true
end

--[[meta.OldPrintMessage = meta.PrintMessage
local dumbent = Entity(0)
function meta:PrintMessage(typ, str)
	str = str or " "
	if typ == HUD_PRINTTALK then
		umsg.Start("RecChat", self)
			umsg.Entity(dumbent)
			umsg.String(str)
		umsg.End()
	else
		self:OldPrintMessage(typ, str)
	end
end]]

function meta:ChatPrint(str)
	umsg.Start("RecChat", self)
		umsg.Entity(Entity(0))
		umsg.String(str)
	umsg.End()
end

function meta:NoParseName()
	local name, num = string.Replace(self:Name(), "</noparse>", "</noparse><noparse>")
	return name
end

if CLIENT then
	function meta:SetMoney(int)
		self.Money = int
	end

	function meta:GetStatus(sType)
		for _, ent in pairs(ents.FindByClass("status_"..sType)) do
			if ent:GetOwner() == self then return ent end
		end
	end

	function meta:SetJetanium(int, forcefeed, total)
		self.UsableJetanium = int
		self.Jetanium = total or self.Jetanium
	end

	function meta:ChatPrint(str)
		NDB.FullChatText(-1, nil, str, "none", false, CHANNEL_DEFAULT)
	end
end

if SERVER then
	if not meta.OldDrawViewModel then
		meta.OldDrawViewModel = meta.DrawViewModel
		meta.OldDrawWorldModel = meta.DrawWorldModel

		local function OldDrawViewModel(self, bDraw)
			if self:IsValid() then
				self:OldDrawViewModel(bDraw)
			end
		end

		function meta:DrawViewModel(bDraw)
			self.m_DrawViewModel = bDraw
			timer.Simple(0, OldDrawViewModel, self, bDraw)
		end

		local function OldDrawWorldModel(self, bDraw)
			if self:IsValid() then
				self:OldDrawWorldModel(bDraw)
			end
		end

		function meta:DrawWorldModel(bDraw)
			self.m_DrawWorldModel = bDraw
			timer.Simple(0, OldDrawWorldModel, self, bDraw)
		end

		function meta:GetDrawViewModel()
			return self.m_DrawViewModel
		end

		function meta:GetDrawWorldModel()
			return self.m_DrawWorldModel
		end
	end

	function meta:SetMoney(int)
		self.Money = int
		self:SendLua("MySelf.Money="..int)
	end

	function meta:IsMuted()
		local muted = self.Muted
		if not muted then return end

		if self.Muted == "" or string.lower(self.Muted) == "none" or self.UnmuteTime and self.UnmuteTime < os.time() then
			self.Muted = nil
			self.UnmuteTime = nil
			return
		end

		return muted
	end

	function meta:AbuseHelp()
		self:PrintMessage(HUD_PRINTTALK, "<deffont=DefaultBold>Please contact <cyan>jetboom@yahoo.com</cyan> or complain on <limegreen>www.noxiousnet.com</limegreen> if you believe this to be abusive.")
	end

	function meta:NotifyMuted(muted)
		if self.UnmuteTime then
			self:PrintMessage(HUD_PRINTTALK, "You've been muted: "..tostring(muted))
			self:PrintMessage(HUD_PRINTTALK, "Unmute: "..math.ceil((self.UnmuteTime - os.time()) / 60).." minutes.")
		else
			self:PrintMessage(HUD_PRINTTALK, "You've been permanently muted: "..tostring(muted))
		end

		return ""
	end

	function meta:UpdateMergerInventory(target)
		self:SendLongString(6, Serialize(self.MergerInventory))
	end

	function meta:UpdateShopInventory(target)
		target = target or self
		local ser = Serialize(target.Inventory)
		if 200 < string.len(ser) then
			self:SendLongString(5, target:EntIndex()..":"..ser)
		else
			umsg.Start("RecInvent", self)
				umsg.Entity(target)
				umsg.String(ser)
			umsg.End()
		end
	end

	function meta:SetJetanium(int, forcefeed, total)
		self.UsableJetanium = int
		if int ~= 0 or forcefeed then
			if total then
				self:SendLua("MySelf:SetJetanium("..self.UsableJetanium..","..total..")")
			else
				self:SendLua("MySelf:SetJetanium("..self.UsableJetanium..")")
			end
		end
	end

	function meta:RemoveAllStatus(bSilent, bInstant)
		if bInstant then
			for _, ent in pairs(ents.FindByClass("status_*")) do
				if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
					ent:Remove()
				end
			end
		else
			for _, ent in pairs(ents.FindByClass("status_*")) do
				if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
					ent.SilentRemove = bSilent
					ent:SetDie()
				end
			end
		end
	end

	function meta:RemoveStatus(sType, bSilent, bInstant)
		local removed
		for _, ent in pairs(ents.FindByClass("status_"..sType)) do
			if ent:GetOwner() == self then
				if bInstant then
					ent:Remove()
				else
					ent.SilentRemove = bSilent
					ent:SetDie()
				end
				removed = true
			end
		end
		return removed
	end

	function meta:GetStatus(sType)
		local ent = self["status_"..sType]
		if ent and ent.Owner == self then return ent end
	end

	function meta:GiveStatus(sType, fDie)
		local cur = self:GetStatus(sType)
		if cur then
			if fDie then
				cur:SetDie(fDie)
			end
			cur:SetPlayer(self, true)
			return cur
		else
			local ent = ents.Create("status_"..sType)
			if ent:IsValid() then
				ent:Spawn()
				if fDie then
					ent:SetDie(fDie)
				end
				ent:SetPlayer(self)
				return ent
			end
		end
	end

	local function SendPiece(pl, uid, pieceid, piece)
		if pl:IsValid() then
			umsg.Start("RLStr", pl)
				umsg.Long(uid)
				umsg.Short(pieceid)
				umsg.String(piece)
			umsg.End()
		end
	end

	function meta:SendLongString(id, contents)
		local uid = self.LongStringUID or 0
		self.LongStringUID = uid + 1

		local len = string.len(contents)
		local numpieces = math.ceil(len / 185)

		umsg.Start("RLStrs", self)
			umsg.Long(uid)
			umsg.Short(id)
			umsg.Short(numpieces)
		umsg.End()

		for i=1, numpieces do
			local x = (i - 1) * 185
			timer.Simple(i * 0.1, SendPiece, self, uid, i, string.sub(contents, x + 1, x + 185))
		end
	end

	--[[local function Continue(pl, id, uid, contents)
		if pl:IsValid() then
			pl:SendLua("RL("..id..","..uid..","..string.format("%q", contents)..")")
		end
	end

	local function Finish(pl, id, uid, contents)
		if pl:IsValid() then
			pl:SendLua("RLf("..id..","..uid..","..string.format("%q", contents)..")")
		end
	end

	function meta:SendLongString(id, contents)
		local uid = self.LongStringUID
		self.LongStringUID = uid + 1

		if string.len(contents) <= 190 then
			self:SendLua("RLf2("..id..","..uid..","..string.format("%q", contents)..")")
		else
			self:SendLua("RLs("..id..","..uid..","..string.format("%q", string.sub(contents, 1, 187))..")")
			local totlen = string.len(contents)
			for i=187, totlen, 187 do
				if totlen <= i + 187 then
					timer.Simple(0.12, Finish, self, id, uid, string.sub(contents, i + 1))
				else
					timer.Simple(0.12, Continue, self, id, uid, string.sub(contents, i + 1, i + 187))
				end
			end
		end
	end]]
end

meta = nil
