local t = Def.ActorFrame{
	LoadActor("top");
	LoadActor("bottom");
	LoadActor("highlight")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+5;y,SCREEN_CENTER_Y+60;);
		OnCommand=cmd(diffusealpha,0;decelerate,0.2;diffusealpha,1);
	};
	Def.ActorFrame{
		Name="P1Frame";
		InitCommand=cmd(visible,GAMESTATE:IsPlayerEnabled(PLAYER_1));
		LoadActor("_left gradient")..{ InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_CENTER_Y+150;halign,0); };
		LoadActor("_p1")..{ InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_CENTER_Y+150;halign,0); };
		LoadFont("_r bold 30px")..{
			Text="Step Artist:";
			InitCommand=cmd(x,SCREEN_LEFT+5;y,SCREEN_CENTER_Y+172;zoom,.6;halign,0;shadowlength,2);
			BeginCommand=function(self)
				local pm = GAMESTATE:GetPlayMode()
				local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
				self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and show)
			end;
		};
		-- player name
	};
	Def.ActorFrame{
		Name="P2Frame";
		InitCommand=cmd(visible,GAMESTATE:IsPlayerEnabled(PLAYER_2));
		LoadActor("_right gradient")..{ InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+150;halign,1); };
		LoadActor("_p2")..{ InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+150;halign,1); };
		LoadFont("_r bold 30px")..{
			Text=":Step Artist";
			InitCommand=cmd(x,SCREEN_RIGHT-5;y,SCREEN_CENTER_Y+172;zoom,.6;halign,1;shadowlength,2);
			BeginCommand=function(self)
				local pm = GAMESTATE:GetPlayMode()
				local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
				self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and show)
			end;
		};
		-- player name
	};
};

return t;