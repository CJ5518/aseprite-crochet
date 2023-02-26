--Crochet utility for Aseprite

--Version of the tool
TOOL_VERSION = "0.0";
--Tool folder path
TOOL_FOLDER = os.getenv('APPDATA') .. "/Aseprite/scripts/aseprite-crochet/"
--Units have no real purpose other than display
UNITS = "in";

--Dialog loading utility
DIALOGS = {};

DIALOGS.mt = {};
setmetatable(DIALOGS, DIALOGS.mt);
DIALOGS.mt.__index = function (self, idx)
	--If we have asked for a valid dialog that hasn't been loaded yet
	--Note that all valid dialog files must have "Dialog" in their name, with a capital D
	local filename = TOOL_FOLDER .. idx .. ".lua";
	if idx:find("Dialog") and app.fs.isFile(filename) then
		DIALOGS[idx] = dofile(filename);
		return DIALOGS[idx];
	end
end


DIALOGS.mainDialog.showDialog();