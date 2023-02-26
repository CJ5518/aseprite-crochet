--Contains the code for the swatch dialog

--[[

module.dialog (dialog)
--The dialog object created in the module

module.showDialog (function) (nothing) -> nothing
--Show the dialog, call this instead of module.dialog:show()
--Will have wait = true



]]

local module = {};



function module.m_textEntryChanged()
	local input = module.getInput();
end

do
	module.dialog = Dialog { title = "Desired Output (Size)" }

	module.dialog:entry {
		id="widthEntry",
		label=string.format("Width (%s)", UNITS),
		text="0",
		focus = false
	}
	module.dialog:entry {
		id="heightEntry",
		label=string.format("Height (%s)", UNITS),
		text="0",
		focus = false
	}

	module.dialog:label {
		id="outputRows",
		label = "Rows: "
	}
	module.dialog:label {
		id="outputColumns",
		label = "Columns: "
	}
end

function module.getInput()
	local ret = {};
	ret.width = tonumber(module.dialog.data.widthEntry);
	ret.height = tonumber(module.dialog.data.heightEntry);
	return ret;
end

function module.showDialog()
	module.dialog:show({wait = true});
	local bounds = module.dialog.bounds;
	module.dialog.bounds = Rectangle(bounds.x, bounds.y, 150, 200);
end


return module;
