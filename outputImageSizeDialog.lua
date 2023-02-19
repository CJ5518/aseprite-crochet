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
	local bounds = module.dialog.bounds;
	module.dialog.bounds = Rectangle(bounds.x, bounds.y, 150, 200);
end

function module.calculateOutput()
	local ret = {};
	ret.rows = tonumber(module.dialog.data.rowsSwatchEntry) or 0;
	ret.columns = tonumber(module.dialog.data.columnsSwatchEntry) or 0;
	ret.realWidth = tonumber(module.dialog.data.widthSwatchEntry) or 0;
	ret.realHeight = tonumber(module.dialog.data.heightSwatchEntry) or 0;
	return ret;
end

return module;
