--Contains the code for the output dialog based upon the image dialog

--[[

module.dialog (dialog)
--The dialog object created in the module

module.showDialog (function) (nothing) -> nothing
--Show the dialog, call this instead of module.dialog:show()
--Will have wait = true


]]

local module = {};

function module.m_textEntryChanged()
	local scaleFactor = tonumber(module.dialog.data.scaleNumber);
	local rows, columns = app.activeSprite.width * scaleFactor, app.activeSprite.height * scaleFactor;
	local swatchData = DIALOGS.swatchDialog.getData();
	module.dialog:modify {
		id = "rowsLabel",
		text = "Rows: " .. tostring(rows)
	}

	module.dialog:modify {
		id = "columnsLabel",
		text = "Rows: " .. tostring(columns)
	}

	module.dialog:modify {
		id = "widthLabel",
		text = string.format("Width (%s): %.2f", UNITS, (swatchData.realWidth / swatchData.rows) * rows)
	}
	module.dialog:modify {
		id = "heightLabel",
		text = string.format("Height (%s): %.2f", UNITS, (swatchData.realHeight / swatchData.columns) * columns)
	}
end

do
	module.dialog = Dialog { title = "Desired Output (Image)" }
	
	module.dialog:number {
		id="scaleNumber",
		label="Scale Factor",
		text="1",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	module.dialog:label {
		id="rowsLabel",
		text="Rows: "
	}

	module.dialog:label {
		id="columnsLabel",
		text="Columns: "
	}

	module.dialog:newrow{ always=false }

	module.dialog:label {
		id="widthLabel",
		text="Width: "
	}

	module.dialog:label {
		id="heightLabel",
		text="Height: "
	}

	module.dialog:button {
		id = "useButton",
		text = "Set Scale",
		onclick = function ()
		end
	}

	module.dialog:button {
		id = "closeButton",
		text = "Close",
		onclick = function ()
			module.dialog:close();
		end
	}
end

function module.showDialog()
	module.m_textEntryChanged();
	module.dialog:show({wait = true});
end

return module;
