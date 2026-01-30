local data = {};
warn(data);

local Player = game.Players.LocalPlayer;
local MorphFunc;
local ex;
local Piv = CFrame.identity

local toCleanup = {};

toCleanup['Thrown'] = workspace.Thrown.ChildAdded:Connect(function(Child: Instance)
	if Child.Name == 'AcceleratorGrab' then
		Child:WaitForChild('Particle'):Destroy();
		if ex and ex['GrabPart'] then
			for i,v in pairs(ex['GrabPart']:GetChildren()) do
				if v:IsA('ParticleEmitter') then
					v = v:Clone();
					v.Parent = Child;
					v.Enabled = true;
				end;
			end;
		end;
	elseif Child.Name == 'Ball' then
		task.wait();
		for i,v in pairs(Child:GetChildren()) do
			if v:IsA('Attachment') then
				v:Destroy();
			end;
		end;
		if ex['DukeBlast'] then
			ex['DukeBlast'].LightningSpear:Clone().Parent = Child;
		end;
	elseif Child.Name == 'AccelCrack' then
		if not workspace.Thrown:FindFirstChild('Duke') then
			local Eff = ex['Effect']:Clone();
			Eff.Name = 'Duke';
			Eff.Parent = workspace.Thrown;
			Eff:PivotTo(Piv*CFrame.new(Vector3.new(0,0,-60)))
			for i,v in pairs(Eff:GetChildren()) do
				v.Enabled = true;
				task.delay(1, function()
					v.Enabled = false;
				end);
			end;
			task.wait(2);
			Eff:Destroy();
		end;
	end;
end);
toCleanup['Trailer'] = workspace.ChildAdded:Connect(function(Child: Instance)
	if Child.Name == 'Trailer2' then
		if not Player.Character then return; end;
		if not Player.Character:FindFirstChild('Counter') then return; end;
		Child:WaitForChild('Trail').Enabled = false;
		if Player.Character:FindFirstChildWhichIsA('Highlight') then
			Player.Character:FindFirstChildWhichIsA('Highlight'):Destroy();
		end;
	elseif Child.Name == 'AccelTornado' then
		Child:WaitForChild('Particle',60).Color = ColorSequence.new(Color3.fromRGB(153,255,199));
	end;
end);

data.OnSpawn = function()
	print(Character, Extras);
	ex = Extras
	Character:FindFirstChild('Head').Transparency = 1;
	
	local armTornadoFunction = function(Child: Instance)
		task.wait();
		if Child.Name:lower():match('armtornado') then
			Child:Destroy();
		end;
	end;
	Character:WaitForChild('Left Arm').ChildAdded:Connect(armTornadoFunction);
	Character:WaitForChild('Right Arm').ChildAdded:Connect(armTornadoFunction);
	Character:WaitForChild('Torso').ChildAdded:Connect(function(Child)
		task.wait();
		if Child.Name == 'Attachment1' and Child:FindFirstChild('Particle') then
			Child:FindFirstChild('Particle').Color = ColorSequence.new(Color3.fromRGB(153,255,199))
		end;
	end);
	Character.ChildAdded:Connect(function(Child)
		if Child.Name == 'Counter' then
			ex['HumanoidRootPart']['WindShieldAttach']:Clone().Parent = Player.Character:FindFirstChild('Torso');
			Child:GetPropertyChangedSignal('Parent'):Connect(function()
				if Child.Parent == nil then
					if Player.Character:FindFirstChild('Torso'):FindFirstChild('WindShieldAttach') then
						Player.Character:FindFirstChild('Torso'):FindFirstChild('WindShieldAttach'):Destroy();
					end;
				end;
			end)
		end;
	end);
	Character:WaitForChild('Humanoid').AnimationPlayed:Connect(function(track: AnimationTrack)
		if track.Animation.AnimationId == 'rbxassetid://7487837377' then
			task.delay(.09, function()
				local ot = tick();
				repeat task.wait() until track.Speed > 0
				if ex then
					if (tick()-ot)>2 then return; end;
					local StrongLeft = ex['HumanoidRootPart']['BigPunch']:Clone();
					StrongLeft.Parent = Character:WaitForChild('HumanoidRootPart');
					for i,v in pairs(StrongLeft:GetChildren()) do
						v:Emit(v:GetAttribute('EmitCount'));
					end;
					game:GetService('Debris'):AddItem(StrongLeft, 1);
				end;
			end);
		elseif track.Animation.AnimationId == 'rbxassetid://7488042958' then
			task.wait(.15);
			if not track.IsPlaying then return; end;
			local StrongLeft = ex['HumanoidRootPart']['BigPunch']:Clone();
			StrongLeft.Parent = Character:WaitForChild('HumanoidRootPart');
			for i,v in pairs(StrongLeft:GetChildren()) do
				v:Emit(v:GetAttribute('EmitCount'));
			end;
			game:GetService('Debris'):AddItem(StrongLeft, 1);
		end;
	end);
end;

data.OnMode = function()
	warn('Popped mode!', Character)
end

data.OnModeEnd = function(Character: Model, newMorph: Model, func)
end

data.OnRemoval = function()
	
end;

data.OnMove = function()
	
end


return data;