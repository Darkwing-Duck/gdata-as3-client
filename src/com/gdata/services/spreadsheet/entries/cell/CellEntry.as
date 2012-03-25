package com.gdata.services.spreadsheet.entries.cell
{
    import com.gdata.services.spreadsheet.SpreadsheetNamespaces;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.requests.Update;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    
    /**
     * ...<br>
     * 
     * @history create Mar 25, 2012 5:52:11 PM<br>
     * @author Smirnov Sergey
     */	
    public class CellEntry extends EventDispatcher implements IEntry
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
         * Cell entry's title, like a 'A1', 'B4' ...
         */  
        protected var _title:String;
        
        /**
         * Row's index of cell
         */        
        protected var _rowIndex:int;
        
        /**
         * Column's index of cell
         */
        protected var _columnIndex:int;
        
        /**
         * Value of cell
         */
        protected var _value:String;
        
        /**
         * Edit url of cell.
         */
        protected var _cellEditUrl:String;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function CellEntry(rawFeed:XML)
        {
            init(rawFeed);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful update handler.
         * @param event Event
         */   
        protected function onSuccessfulUpdate(event:Event):void
        {
            init(XML(event.currentTarget.loader.data));
            destroyUpdateCommand(event.currentTarget as IGDataRequest);
            dispatchEvent(new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_UPDATE, this));
        }
        
        /**
         * Error update handler.
         * @param event IOErrorEvent
         */  
        protected function onErrorUpdate(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyUpdateCommand(event.currentTarget as IGDataRequest);
           
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        private function destroyUpdateCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulUpdate);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorUpdate);
            GDataRequest(command).destroy();
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Initializes the entry.
         * @param rawData raw data of entry
         */         
        protected function init(rawData:XML):void
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var gs:Namespace = SpreadsheetNamespaces.gs;
            
            _title = rawData.title;
            _cellEditUrl = rawData.link.(@rel == "edit").@href;
            _columnIndex = int(rawData.gs::cell.@col);
            _rowIndex = int(rawData.gs::cell.@row);
            _value = rawData.gs::cell.@inputValue;
        }
        
        /**
         * Generates the entry data to update the cell with api.
         * @return 
         */        
        protected function generateUpdatedCell():XML
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var gs:Namespace = SpreadsheetNamespaces.gs;
            var result:XML = new XML(<entry></entry>);
            
            result.addNamespace(gs);
            result.appendChild(<cell row={_rowIndex} col={_columnIndex} inputValue={_value}></cell>);
            result.cell.setNamespace(gs);
            
            return result;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        public function update():void
        {
            var data:XML = generateUpdatedCell();
            var command:IGDataRequest = new Update(_cellEditUrl, data);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulUpdate);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorUpdate);
            command.send();
        }
        
        /**
         * @inheritDoc
         */
        public function getTitle():String
        {
            return _title;
        }
        
        /**
         * Column index of cell.
         * @return 
         */        
        public function getColumnIndex():int
        {
            return _columnIndex;
        }
        
        /**
         * Row index of cell.
         * @return 
         */        
        public function getRowIndex():int
        {
            return _rowIndex;
        }
        
        /**
         * Cell's value.
         * @return 
         */        
        public function getValue():String
        {
            return _value;
        }
        
        /**
         * Sets cell's value.
         * @param value new cell's value
         */        
        public function setValue(value:String):void
        {
            _value = value;
        }
        
        /**
         * @inheritDoc
         */
        public function destroy():void
        {
            _title = null;
            _value = null;
            _rowIndex = undefined;
            _columnIndex = undefined;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}