#
# Logbook - Add-on for FlightGear
#
# Written and developer by Roman Ludwicki (PlayeRom, SP-ROM)
#
# Copyright (C) 2022 Roman Ludwicki
#
# Logbook is an Open Source project and it is licensed
# under the GNU Public License v3 (GPLv3)
#

#
# ListView widget View
#
DefaultStyle.widgets.ListView = {
    PADDING     : 10,
    ITEM_HEIGHT : 28,

    #
    # Constructor
    #
    # @param hash parent
    # @param hash cfg
    # @return void
    #
    new: func(parent, cfg) {
        me._root = parent.createChild("group", "ListView");

        me._titleElement = nil;
        me._itemElements = [];
        me._loadingText = nil;
        me._columnsWidth = nil;

        me._fontSize = 14;
        me._fontName = "LiberationFonts/LiberationSans-Regular.ttf";

        me._textColor = me._style.getColor("fg_color");
        me._backgroundColor = me._style.getColor("bg_color");
        me._hoverBackgroundColor = [1.0, 1.0, 0.5, 1.0];
        me._highlightingRowColor = nil;

        me._xTransaltion = nil;
        me._yTransaltion = nil;
    },

    #
    # Callback called when user resized the window
    #
    # @param hash model
    # @param int w, h - Width and height of widget
    # @return me
    #
    setSize: func(model, w, h) {
        me.reDrawContent(model);

        return me;
    },

    #
    # @param hash model
    # @return void
    #
    update: func(model) {
        # nothing here
    },

    #
    # @param hash model
    # @param vector columnsWidth
    # @return me
    #
    setColumnsWidth: func(model, columnsWidth) {
        me._columnsWidth = columnsWidth;
        return me;
    },

    #
    # Set title as non clickable description text on the top
    #
    # @param string text
    # @return me
    #
    setTitle: func(model, text) {
        if (me._titleElement != nil) {
            me._titleElement.setText(text);
        }

        me.update(model);
        return me;
    },

    #
    # @param hash model
    # @param vector color
    # @return me
    #
    setColorText: func(model, color) {
        me._textColor = color;

        if (me._loadingText != nil) {
            me._loadingText.setColor(color);
        }

        if (me._titleElement != nil) {
            me._titleElement.setColor(color);
        }

        foreach (var hash; me._itemElements) {
            if (typeof(hash.text) == "vector") {
                foreach (var text; hash.text) {
                    text.setColor(color);
                }
            }
            else {
                hash.text.setColor(color);
            }
        }

        me.update(model);
        return me;
    },

    #
    # @param hash model
    # @param vector color
    # @return me
    #
    setColorBackground: func(model, color) {
        me._backgroundColor = color;

        foreach (var hash; me._itemElements) {
            if (hash.rect != nil) {
                hash.rect.setColorFill(color);
            }
        }

        me.update(model);
        return me;
    },

    #
    # @param hash model
    # @param vector color
    # @return me
    #
    setColorHoverBackground: func(model, color) {
        me._hoverBackgroundColor = color;

        me.update(model);
        return me;
    },

    #
    # @param hash model
    # @param int fontSize
    # @return me
    #
    setFontSize: func(model, fontSize) {
        me._fontSize = fontSize;

        if (me._loadingText != nil) {
            me._loadingText.setFontSize(fontSize);
        }

        if (me._titleElement != nil) {
            me._titleElement.setFontSize(fontSize);
        }

        foreach (var hash; me._itemElements) {
            if (typeof(hash.text) == "vector") {
                foreach (var text; hash.text) {
                    text.setColor(color);
                }
            }
            else {
                hash.text.setFontSize(fontSize);
            }
        }

        return me
    },

    #
    # @param hash model
    # @param string font
    # @return me
    #
    setFontName: func(model, font) {
        me._fontName = font;

        if (me._loadingText != nil) {
            me._loadingText.setFont(font);
        }

        if (me._titleElement != nil) {
            me._titleElement.setFont(font);
        }

        foreach (var hash; me._itemElements) {
            if (typeof(hash.text) == "vector") {
                foreach (var text; hash.text) {
                    text.setFont(color);
                }
            }
            else {
                hash.text.setFont(font);
            }
        }

        return me;
    },

    #
    # @param hash model
    # @param int x, y
    # @return me
    #
    setTranslation: func(model, x, y) {
        me._xTransaltion = x;
        me._yTransaltion = y;
        return me;
    },

    #
    # @param hash model
    # @param vector color
    # @return me
    #
    setHighlightingRow: func(model, color) {
        if (model._highlightingRowIndex != nil) {
            me._highlightingRowColor = color;
            me._itemElements[model._highlightingRowIndex].rect.setColorFill(color);
        }
        return me;
    },

    #
    # @param hash model
    # @return me
    #
    removeHighlightingRow: func(model) {
        me._itemElements[model._highlightingRowIndex].rect.setColorFill(me._backgroundColor);
        return me;
    },

    #
    # @param hash model
    # @param vector boundingBox
    # @return me
    #
    setClipByBoundingBox: func(model, boundingBox) {
        me._root.setClipByBoundingBox(boundingBox);
        return me;
    },

    #
    # @param hash model
    # @return void
    #
    reDrawContent: func(model) {
        # me._deleteElements(); # TODO: <- is it really needed? Maybe removeAllChildren does the job?
        me._root.removeAllChildren();

        var y = model._isLoading
            ? me._drawContentLoading(model)
            : me._drawContentItems(model);

        model.setLayoutMinimumSize([50, DefaultStyle.widgets.ListView.ITEM_HEIGHT]);
        model.setLayoutSizeHint([model._size[0], y]);
    },

    #
    # @param hash model
    # @return int - Height of content
    #
    _drawContentLoading: func(model) {
        me._loadingText = me._createText(
            me._root,
            int(model._size[0] / 2),
            int(model._size[1] / 2),
            "Loading...",
            "center-center"
        );

        return model._size[1];
    },

    #
    # @param hash model
    # @return int - Height of content
    #
    _drawContentItems: func(model) {
        if (me._xTransaltion != nil and me._yTransaltion != nil) {
            me._root.setTranslation(me._xTransaltion, me._yTransaltion);
        }

        var x = DefaultStyle.widgets.ListView.PADDING;
        var y = 0;

        me._itemElements = [];

        if (model._title != nil) {
            var group = me._createBarGroup(y);
            me._titleElement = me._createText(group, x, me._getTextYOffset(), model._title);

            y += int(DefaultStyle.widgets.ListView.ITEM_HEIGHT + DefaultStyle.widgets.ListView.ITEM_HEIGHT / 4);
        }

        var index = 0;
        foreach (var item; model._items) {
            me._createRow(model, item, x, y);

            # TODO: event listeners should be move to model
            func () {
                var innerIndex = index;
                me._itemElements[innerIndex].group.addEventListener("mouseenter", func {
                    if (model._highlightingRowIndex != innerIndex) {
                        me._itemElements[innerIndex].rect.setColorFill(me._hoverBackgroundColor);
                    }
                });

                me._itemElements[innerIndex].group.addEventListener("mouseleave", func {
                    if (model._highlightingRowIndex != innerIndex) {
                        me._itemElements[innerIndex].rect.setColorFill(me._backgroundColor);
                    }
                });

                me._itemElements[index].group.addEventListener("click", func {
                    call(model._callback, [innerIndex], model._callbackContext);
                });
            }();

            # Since the text can wrap, you need to take the height of the last text and add it to the height of the content.
            if (model._isUseTextMaxWidth) {
                var itemsCount = size(me._itemElements);
                if (itemsCount > 0) {
                    var height = me._itemElements[itemsCount - 1].maxHeight;

                    y += height > DefaultStyle.widgets.ListView.ITEM_HEIGHT
                        ? (height + me._getHeightItemPadding(model))
                        : DefaultStyle.widgets.ListView.ITEM_HEIGHT;
                }
            }
            else {
                y += DefaultStyle.widgets.ListView.ITEM_HEIGHT;
            }

            index += 1;
        }

        # Make sure that highlighted row is still highlighting
        me.setHighlightingRow(model, me._highlightingRowColor);

        return y;
    },

    #
    # Create row
    #
    # @param hash model
    # @param string|hash item
    # @param int x, y
    # @return void
    #
    _createRow: func(model, item, x, y) {
        if (model._isComplexItems) {
            # model._items is a vactor of hash, each hash has "data" key with vector of strings
            me._createComplexRow(model, item, x, y);
            return;
        }

        # model._items is a vactor of strings
        me._createSimpleRow(model, item, x, y);
    },

    #
    # Create simple row
    #
    # @param hash model
    # @param string|hash item
    # @param int x, y
    # @return void
    #
    _createSimpleRow: func(model, item, x, y) {
        var hash = me._createBar(y);

        # Create temporary text element for get his height
        # TODO: It would be nice to optimize here so as not to draw these temporary texts, but I need to first
        # draw a rectangle and know its height based on the text that will be there, and then draw the final text.
        var height = DefaultStyle.widgets.ListView.ITEM_HEIGHT;
        if (model._isUseTextMaxWidth) {
            var tempText = me._createText(hash.group, x, me._getTextYOffset(), item)
                .setMaxWidth(me._columnsWidth[0]);

            height = tempText.getSize()[1];
            if (height > hash.maxHeight) {
                hash.maxHeight = height;
            }
            tempText.del();
        }

        hash.rect = me._createRectangle(model, hash.group, height + me._getHeightItemPadding(model));

        hash.text = me._createText(hash.group, x, me._getTextYOffset(), item);
        if (model._isUseTextMaxWidth) {
            hash.text.setMaxWidth(me._columnsWidth[0]);
        }

        append(me._itemElements, hash);
    },

    #
    # Create complex row
    #
    # @param hash model
    # @param string|hash item
    # @param int x, y
    # @return void
    #
    _createComplexRow: func(model, item, x, y) {
        var hash = me._createBar(y);
        hash.text = [];

        # Create temporary text elements to get their height
        # TODO: It would be nice to optimize here so as not to draw these temporary texts, but I need to first
        # draw a rectangle and know its height based on the text that will be there, and then draw the final text.
        if (model._isUseTextMaxWidth) {
            var tempText = me._createText(hash.group, x, me._getTextYOffset(), "temp");
            forindex (var columnIndex; me._columnsWidth) {
                tempText
                    .setText(item.data[columnIndex])
                    .setMaxWidth(me._getColumnWidth(columnIndex));

                var height = tempText.getSize()[1];
                if (height > hash.maxHeight) {
                    hash.maxHeight = height;
                }
            }
            tempText.del();
        }

        var rectHeight = hash.maxHeight == 0
            ? DefaultStyle.widgets.ListView.ITEM_HEIGHT
            : hash.maxHeight + me._getHeightItemPadding(model);
        hash.rect = me._createRectangle(model, hash.group, rectHeight);

        forindex (var columnIndex; me._columnsWidth) {
            var columnWidth = me._getColumnWidth(columnIndex);

            var text = me._createText(hash.group, x, me._getTextYOffset(), item.data[columnIndex]);
            if (model._isUseTextMaxWidth) {
                text.setMaxWidth(columnWidth);
            }

            append(hash.text, text);

            x += columnWidth;
        }

        append(me._itemElements, hash);
    },

    #
    # Get width of column for given index
    #
    # @param int index
    # @return int
    #
    _getColumnWidth: func(index) {
        return me._columnsWidth[index];
    },

    #
    # @param int y
    # @return hash
    #
    _createBar: func(y) {
        var hash = {
            group     : me._createBarGroup(y),
            rect      : nil,
            text      : nil, # vector of text element, or single text element
            maxHeight : 0,   # max text height in this row
        };

        return hash;
    },

    #
    # @param int y
    # @return hash - Group element
    #
    _createBarGroup: func(y) {
        return me._root.createChild("group").setTranslation(0, y);
    },

    #
    # @param hash model
    # @param hash context
    # @param int textHeight
    # @return hash - Path element
    #
    _createRectangle: func(model, context, textHeight) {
        return context.rect(
                0,
                0,
                model._size[0] - (me._xTransaltion == nil ? 0 : (me._xTransaltion * 2)),
                math.max(textHeight, DefaultStyle.widgets.ListView.ITEM_HEIGHT)
            )
            .setColorFill(me._backgroundColor);
    },

    #
    # @param hash context - Parent element
    # @param int x, y
    # @param string text
    # @param string alignment
    # @return hash - Text element
    #
    _createText: func(context, x, y, text, alignment = "left-baseline") {
        return context.createChild("text")
            .setFont(me._fontName)
            .setFontSize(me._fontSize)
            .setAlignment(alignment)
            .setTranslation(x, y)
            .setColor(me._textColor)
            .setText(text);
    },

    #
    # @return int
    #
    _getTextYOffset: func() {
        if (me._fontSize == 12) {
            return 16;
        }

        if (me._fontSize == 14) {
            return 17;
        }

        if (me._fontSize == 16) {
            return 18;
        }

        return 0;
    },

    #
    # @param hash model
    # @return double
    #
    _getHeightItemPadding: func(model) {
        if (model._isUseTextMaxWidth) {
            return me._fontSize;
        }

        return 0;
    },

    #
    # @return me
    #
    _deleteElements: func() {
        if (me._loadingText != nil) {
            me._loadingText.del();
            me._loadingText = nil;
        }

        if (me._titleElement != nil) {
            me._titleElement.del();
            me._titleElement = nil;
        }

        foreach (var hash; me._itemElements) {
            if (typeof(hash.text) == "vector") {
                foreach (var text; hash.text) {
                    text.del();
                }
            }
            else {
                hash.text.del();
            }

            hash.rect.del();
            hash.group.del();
        }
        me._itemElements = [];

        return me;
    },
};
