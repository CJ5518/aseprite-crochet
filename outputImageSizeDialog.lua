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

	module.dialog:button {
		id = "useButton",
		text = "Use",
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
	module.dialog:show({wait = true});
end

return module;
