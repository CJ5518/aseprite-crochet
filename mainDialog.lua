--The main dialog for the crochet tool

--Contains the code for the main dialog

--[[

module.dialog (dialog)
--The dialog object created in the module

module.showDialog (function) (nothing) -> nothing
--Show the dialog, call this instead of module.dialog:show()
--Will have wait = false


]]

local swatchDialog = dofile("swatchDialog.lua");

local module = {};

--Create the dialog widgets
do
	module.dialog = Dialog { title = "Crochet Tool v" ..  TOOL_VERSION}

	module.dialog:button {
		text = "Swatch",
		onclick = function ()
			swatchDialog.showDialog();
		end
	}
end

function module.showDialog()
	module.dialog:show({wait = false});
	local bounds = module.dialog.bounds;
	module.dialog.bounds = Rectangle(bounds.x, bounds.y, 200, 300);
end

return module;
