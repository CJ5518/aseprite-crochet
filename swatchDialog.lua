--Contains the code for the swatch dialog

--[[

module.dialog (dialog)
--The dialog object created in the module

module.showDialog (function) (nothing) -> nothing
--Show the dialog, call this instead of module.dialog:show()
--Will have wait = true

module.calculatePixelSize (function) (nothing) -> Size, table
--Returns the size of a pixel based upon the size of the stitches
--The table has two members, table.stitchWidth / table.stitchHeight
--The table members are in the input units, provided for convenience

module.getData (function) (nothing) -> table
--Get the data the user entered, output format is as follows:
--table.rows / table.columns / table.realWidth / table.realHeight

]]

local module = {};

--Private function, called when the text entries/numbers change
--Used to update the pixel strech label
function module.m_textEntryChanged()
	local data = module.getData();
	local pixelSize = module.calculatePixelSize();

	module.dialog:modify{
		id="stretchLabel",
		text=string.format("Pixel Stretch: %d, %d", pixelSize.width, pixelSize.height)
	}
end

--Create the widgets
do
	module.dialog = Dialog { title = "Test Swatch" }

	--Entries for the real world width and height
	module.dialog:entry {
		id="widthEntry",
		label=string.format("Width (%s)", UNITS),
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}
	module.dialog:entry {
		id="heightEntry",
		label=string.format("Height (%s)", UNITS),
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	--Number entries for the rows and columns
	module.dialog:number {
		id="rowsNumber",
		label="Rows",
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	module.dialog:number {
		id="columnsNumber",
		label="Columns",
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	--Label to show the current level of stretching
	module.dialog:label {
		id="stretchLabel",
		text="Pixel Stretch: "
	}

	--Button to preview the pixel streching
	module.dialog:button {
		id="previewButton",
		onclick = function()
			local sprite = Sprite(app.activeSprite);
			sprite.pixelRatio = module.calculatePixelSize();
			sprite.filename = "STRETCHED-" .. sprite.filename;
			module.dialog:close();
		end,
		text = "Preview stretch"

	}
end

--Show the dialog
function module.showDialog()
	module.dialog:show({wait = true});

end

--Returns the user input data
function module.getData()
	local ret = {};
	ret.rows = tonumber(module.dialog.data.rowsNumber) or 0;
	ret.columns = tonumber(module.dialog.data.columnsNumber) or 0;
	ret.realWidth = tonumber(module.dialog.data.widthEntry) or 0;
	ret.realHeight = tonumber(module.dialog.data.heightEntry) or 0;
	return ret;
end

--Performs calculations on the user input data
function module.calculatePixelSize()
	local ret = {};
	local data = module.getData();
	ret.stitchHeight = data.realHeight / data.rows;
	ret.stitchWidth = data.realWidth / data.columns;

	local pixelSize = Size((ret.stitchWidth / ret.stitchWidth) * 100, 100 * (ret.stitchHeight / ret.stitchWidth));

	return pixelSize, ret;
end

return module;
