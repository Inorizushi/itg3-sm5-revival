local t = LoadFallbackB();

-- StepsDisplay
if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(PlayerNumber) do
		local t2 = Def.ActorFrame{
			InitCommand=cmd(player,pn);
			LoadActor(THEME:GetPathG("_difficulty","icons"))..{
				InitCommand=cmd(zoomy,.8;animate,0;zoomx,(pn==PLAYER_2) and -0.8 or 0.8;playcommand,"Update");
				UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						self:setstate(DifficultyToState(steps:GetDifficulty()))
					end
				end;
			};
			Def.StepsDisplay {
				InitCommand=cmd(Load,"StepsDisplayEvaluation",pn;SetFromGameState,pn;);
				UpdateNetEvalStatsMessageCommand=function(self,param)
					if GAMESTATE:IsPlayerEnabled(pn) then
						self:SetFromSteps(param.Steps)
					end;
				end;
			};
		};
		t[#t+1] = StandardDecorationFromTable("StepsDisplay"..ToEnumShortString(pn), t2);
	end
end

-- records text
for pn in ivalues(PlayerNumber) do
	local MetricsName = "MachineRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
		InitCommand=function(self) 
			self:player(pn); 
			self:name(MetricsName); 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
		end;
	};
end

for pn in ivalues(PlayerNumber) do
	local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn)..{
		InitCommand=function(self) 
			self:player(pn); 
			self:name(MetricsName); 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
		end;
	};
end

-- life graph
local function GraphDisplay(pn)
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=cmd(Load,"GraphDisplay"..ToEnumShortString(pn););
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable("GraphDisplay"..ToEnumShortString(pn), GraphDisplay(pn));
	end
end

-- combo graph
local function ComboGraph( pn )
	local t = Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=cmd(Load,"ComboGraph"..ToEnumShortString(pn););
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end

if ShowStandardDecoration("ComboGraph") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable("ComboGraph"..ToEnumShortString(pn), ComboGraph(pn));
	end;
end;

-- awards
--[[
local function StageAward( pn )
	local MetricsName = "StageAward"..ToEnumShortString(pn);
	return Def.ActorFrame{
		LoadActor(THEME:GetPathG("ScreenEvaluation", "StageAward"), pn)..{
			InitCommand=function(self) 
				self:player(pn); 
				self:name(MetricsName); 
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
			end;
		};
	};
end
if ShowStandardDecoration("StageAward") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable("StageAward"..ToEnumShortString(pn), StageAward(pn));
	end;
end;

local function PeakComboAward( pn )
	local MetricsName = "PeakComboAward"..ToEnumShortString(pn);
	return Def.ActorFrame{
		LoadActor(THEME:GetPathG("ScreenEvaluation", "PeakComboAward"), pn)..{
			InitCommand=function(self) 
				self:player(pn); 
				self:name(MetricsName); 
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
			end;
		};
	};
end
if ShowStandardDecoration("PeakComboAward") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable("PeakComboAward"..ToEnumShortString(pn), PeakComboAward(pn));
	end;
end;
--]]

return t;