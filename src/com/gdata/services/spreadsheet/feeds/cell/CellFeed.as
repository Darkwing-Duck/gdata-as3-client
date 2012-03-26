package com.gdata.services.spreadsheet.feeds.cell
{
    import com.gdata.services.spreadsheet.SpreadsheetNamespaces;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.cell.CellEntry;
    import com.gdata.services.spreadsheet.feeds.Feed;
    
    /**
     * ...<br>
     * 
     * @history create Mar 25, 2012 7:45:59 PM<br>
     * @author Smirnov Sergey
     */	
    public class CellFeed extends Feed
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
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function CellFeed()
        {
            super();
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
        
        /**
         * @inheritDoc
         */  
        override protected function init(rawFeed:XML):void
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var entriesInfo:XMLList = rawFeed.entry;
            
            for each (var entryInfo:XML in entriesInfo)
            {
                var entry:CellEntry = new CellEntry(entryInfo);
                _entries.push(entry);
            }
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Takes the specific cell entry by position in sheet.
         * 
         * @param columnIndex column index of cell
         * @param rowIndex row index of cell
         * @return 
         */        
        public function getCellByPosition(columnIndex:int, rowIndex:int):IEntry
        {
            var result:IEntry;
            
            for each (var entry:IEntry in _entries)
            {
                if (CellEntry(entry).getColumnIndex() == columnIndex && CellEntry(entry).getRowIndex() == rowIndex)
                {
                    result = entry;
                    break;
                }
            }
            
            return result;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}