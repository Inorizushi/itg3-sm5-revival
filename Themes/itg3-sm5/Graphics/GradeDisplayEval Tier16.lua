return Def.ActorFrame{
	InitCommand=cmd(zoom,0.7;wag;effectmagnitude,0,10,0);
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/cminus.txt"),
		Meshes=THEME:GetPathG("_grade","models/cminus.txt"),
		Bones=THEME:GetPathG("_grade","models/cminus.txt"),
	};
};