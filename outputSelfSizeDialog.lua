--Contains the code for the swatch dialog

--[[

module.dialog (dialog)
--The dialog object created in the module

module.showDialog (function) (nothing) -> nothing
--Show the dialog, call this instead of module.dialog:show()
--Will have wait = true


]]

local module = {};

do
	module.dialog = Dialog { title = "Desired Output (Size)" }

	module.dialog:entry {
		id="widthSwatchEntry",
		label=string.format("Width (%s)", UNITS),
		text="0",
		focus = false
	}
	module.dialog:entry {
		id="heightSwatchEntry",
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
	module.dialog:label {
		id="outputStiches",
		label = "Stiches: "
	}
end

function module.showDialog()
	module.dialog:show({wait = true});
	local bounds = module.dialog.bounds;
	module.dialog.bounds = Rectangle(bounds.x, bounds.y, 150, 200);
end


return module;
