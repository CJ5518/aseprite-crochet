--Contains the code for the output dialog based upon the image dialog

--[[

module.dialog (dialog)
--The dialog object created in the module

module.showDialog (function) (nothing) -> nothing
--Show the dialog, call this instead of module.dialog:show()
--Will have wait = true


]]

local module = {};

do
	module.dialog = Dialog { title = "Desired Output (Image)" }
	
end

function module.showDialog()
	module.dialog:show({wait = true});
end

return module;
