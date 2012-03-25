package com.gdata.services.spreadsheet.entries.row
{
    import flash.utils.Dictionary;

    /**
     * Describes the custom elements(cells) in current row.<br>
     * 
     * @history create Mar 25, 2012 3:12:54 PM<br>
     * @author Smirnov Sergey
     */	
    public class RowCustomElements
    {	
        //----------------------------------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Class variables
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Custom elements of specific row. 
         */        
        protected var _customElements:Dictionary;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function RowCustomElements()
        {
            _customElements = new Dictionary();
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * All tags of custom elements.
         * @return 
         */        
        public function getTags():Vector.<String>
        {
            var result:Vector.<String> = new Vector.<String>();
            
            for (var tag:String in _customElements)
            {
                result.push(tag);
            }
            
            return result;
        }
        
        /**
         * Value of specific custom element by tag.
         * 
         * @param tag tag of custom element
         * @return 
         */        
        public function getValue(tag:String):String
        {
            return _customElements[tag];
        }
        
        /**
         * Sets the new custom element or update existing.
         * 
         * @param tag tag of custom element
         * @param value value of custom element
         */        
        public function setValue(tag:String, value:String):void
        {
            tag = tag.toLowerCase();
            _customElements[tag] = value;
        }
        
        public function destroy():void
        {
            _customElements = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}