package com.gdata.services.spreadsheet.entries.worksheet
{
    import com.gdata.services.spreadsheet.SpreadsheetNamespaces;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.requests.Insert;
    import com.gdata.services.spreadsheet.requests.Remove;
    import com.gdata.services.spreadsheet.requests.Update;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.row.RowCustomElements;
    import com.gdata.services.spreadsheet.entries.row.RowEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.cell.CellFeed;
    import com.gdata.services.spreadsheet.feeds.row.RowFeed;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    
    /**
     * ...<br>
     * 
     * @history create Mar 24, 2012 1:51:38 AM<br>
     * @author Smirnov Sergey
     */	
    public class WorksheetEntry extends EventDispatcher implements IEntry
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
         * Entry's title. 
         */        
        protected var _title:String;
        
        /**
         * Columns count. 
         */   
        protected var _columnCount:int;
        
        /**
         * Rows count. 
         */   
        protected var _rowCount:int;
        
        /**
         * Cells feed url. 
         */   
        protected var _cellFeedUrl:String;
        
        /**
         * Row feed url. 
         */   
        protected var _rowFeedUrl:String;
        
        /**
         * Edit entry url. 
         */   
        protected var _worksheetEditUrl:String;

        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function WorksheetEntry(rawData:XML)
        {
            init(rawData);  
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful remove handler.
         * @param event Event
         */        
        protected function onSuccessfulRemove(event:Event):void
        {
            destroyRemoveCommand(event.currentTarget as IGDataRequest);
            dispatchEvent(new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_DELETE, this));
        }
        
        /**
         * Error remove handler.
         * @param event IOErrorEvent
         */   
        protected function onErrorRemove(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyRemoveCommand(event.currentTarget as IGDataRequest);
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        /**
         * Successful update handler.
         * @param event Event
         */   
        protected function onSuccessfulUpdate(event:Event):void
        {
            init(XML(event.currentTarget.loader.data));
            destroyRemoveCommand(event.currentTarget as IGDataRequest);
            dispatchEvent(new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_UPDATE, this));
        }
        
        /**
         * Error update handler.
         * @param event IOErrorEvent
         */  
        protected function onErrorUpdate(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyRemoveCommand(event.currentTarget as IGDataRequest);
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        /**
         * Successful insert row handler.
         * @param event Event
         */   
        protected function onSuccessfulInsert(event:Event):void
        {
            var rawEntry:XML = XML(event.currentTarget.loader.data);
            var entry:IEntry = new RowEntry(rawEntry);
            destroyInsertRowCommand(event.currentTarget as IGDataRequest);
            
            var entryEvent:SuccessEntryEvent = new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_INSERT, entry);
            dispatchEvent(entryEvent);
        }
        
        /**
         * Error insert row handler.
         * @param event IOErrorEvent
         */  
        protected function onErrorInsert(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyInsertRowCommand(event.currentTarget as IGDataRequest);
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        private function destroyRemoveCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulRemove);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorRemove);
            GDataRequest(command).destroy();
        }
        
        private function destroyUpdateCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulUpdate);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorUpdate);
            GDataRequest(command).destroy();
        }
        
        private function destroyInsertRowCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulInsert);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorInsert);
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
            var category:String = rawData.category.@scheme;
            
            _title = rawData.title;
            _cellFeedUrl = rawData.link.(@rel == category + "#cellsfeed").@href;
            _rowFeedUrl = rawData.link.(@rel == category + "#listfeed").@href;
            _worksheetEditUrl = rawData.link.(@rel == "edit").@href;
            _columnCount = rawData.gs::colCount;
            _rowCount = rawData.gs::rowCount;
        }
        
        /**
         * Generates the entry data to update the entry with api.
         * @return 
         */        
        protected function generateUpdatedWorksheet():XML
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var gs:Namespace = SpreadsheetNamespaces.gs;
            var result:XML = new XML(<entry></entry>);
            
            result.addNamespace(gs);
            
            result.appendChild(<title>{_title}</title>);
            result.appendChild(<rowCount>{_rowCount}</rowCount>);
            result.appendChild(<colCount>{_columnCount}</colCount>);
            
            result.rowCount.setNamespace(gs);
            result.colCount.setNamespace(gs);
            
            return result;
        }
        
        /**
         * Generates the entry data to create new row with api.
         * @return 
         */
        protected function generateNewRow(params:RowCustomElements):XML
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var gsx:Namespace = SpreadsheetNamespaces.gsx;
            var result:XML = new XML(<entry></entry>);
            
            result.addNamespace(gsx);
            
            for each (var tag:String in params.getTags())
            {
                var value:String = params.getValue(tag);
                var element:XML = new XML(<{tag}>{value}</{tag}>);
                element.setNamespace(gsx);
                
                result.appendChild(element);
            }
            
            return result;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * New row feed instance.
         * @return 
         */        
        public function getRowFeed():IFeed
        {
            return new RowFeed();
        }
        
        /**
         * New cell feed instance.
         * @return 
         */
        public function getCellFeed():IFeed
        {
            return new CellFeed();
        }
        
        /**
         * Inserts new row's entry with api.
         * You should wait when the row's entry is inserted.
         */
        public function insert(params:RowCustomElements):void
        {
            var data:XML = generateNewRow(params);
            var command:IGDataRequest = new Insert(_rowFeedUrl, data);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulInsert);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorInsert);
            command.send();
        }
        
        /**
         * Removes current entry with api.
         * You should wait when the entry is deleted.
         */
        public function remove():void
        {
            var command:IGDataRequest = new Remove(_worksheetEditUrl);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulRemove);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorRemove);
            command.send();
        }
        
        /**
         * Updates current entry with api.
         * You should wait when the entry is updated.
         */
        public function update():void
        {
            var data:XML = generateUpdatedWorksheet();
            var command:IGDataRequest = new Update(_worksheetEditUrl, data);
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
         * Sets the entry's title.
         * @param title new entry's title.
         */        
        public function setTitle(title:String):void
        {
            _title = title;
        }

        /**
         * Entry columns count.
         * @return 
         */
        public function getColumnCount():int
        {
            return _columnCount;
        }

        /**
         * Sets the columns count of entry.
         * @param value new columns count
         */ 
        public function setColumnCount(value:int):void
        {
            _columnCount = value;
        }

        /**
         * Entry rows count.
         * @return 
         */
        public function getRowCount():int
        {
            return _rowCount;
        }

        /**
         * Sets the rows count of entry.
         * @param value new rows count
         */        
        public function setRowCount(value:int):void
        {
            _rowCount = value;
        }

        /**
         * Entry cells feed url.
         * @return 
         */
        public function getCellFeedUrl():String
        {
            return _cellFeedUrl;
        }

        /**
         * Entry rows feed url.
         * @return 
         */
        public function getRowFeedUrl():String
        {
            return _rowFeedUrl;
        }
        
        /**
         * @inheritDoc 
         */        
        public function destroy():void
        {
            _rowCount = undefined;
            _columnCount = undefined;
            
            _title = null;
            _rowFeedUrl = null;
            _cellFeedUrl = null;
            _worksheetEditUrl = null;
        }

        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}