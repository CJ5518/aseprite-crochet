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

function module.m_textEntryChanged()
	local data = module.getData();
	local pixelSize = module.calculatePixelSize();

	module.dialog:modify{
		id="stretchLabel",
		text=string.format("Pixel Stretch: %.2f, %.2f", pixelSize.width, pixelSize.height)
	}
end

do
	module.dialog = Dialog { title = "Test Swatch" }

	module.dialog:entry {
		id="widthSwatchEntry",
		label=string.format("Width (%s)", UNITS),
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}
	module.dialog:entry {
		id="heightSwatchEntry",
		label=string.format("Height (%s)", UNITS),
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	module.dialog:number {
		id="rowsSwatchEntry",
		label="Rows",
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	module.dialog:number {
		id="columnsSwatchEntry",
		label="Columns",
		text="0",
		focus = false,
		onchange = module.m_textEntryChanged
	}

	module.dialog:label {
		id="stretchLabel",
		text="Pixel Stretch: "
	}
	module.dialog:button {
		id="previewButton",
		onclick = function()
			local sprite = Sprite(app.activeSprite);
			sprite.pixelRatio = module.calculatePixelSize();
			sprite.filename = sprite.filename .. "STRETCHED";
			module.dialog:close();
		end,
		text = "Preview stretch"

	}
end

function module.showDialog()
	module.dialog:show({wait = true});
	local bounds = module.dialog.bounds;
	module.dialog.bounds = Rectangle(bounds.x, bounds.y, 150, 200);
end

--Returns the user input data
function module.getData()
	local ret = {};
	ret.rows = tonumber(module.dialog.data.rowsSwatchEntry) or 0;
	ret.columns = tonumber(module.dialog.data.columnsSwatchEntry) or 0;
	ret.realWidth = tonumber(module.dialog.data.widthSwatchEntry) or 0;
	ret.realHeight = tonumber(module.dialog.data.heightSwatchEntry) or 0;
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
