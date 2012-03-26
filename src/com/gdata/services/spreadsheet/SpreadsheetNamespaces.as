package com.gdata.services.spreadsheet
{
    /**
     * Spreadsheet service's namespaces<br>
     * 
     * @history create Mar 24, 2012 12:33:48 AM<br>
     * @author Smirnov Sergey
     */	
    public class SpreadsheetNamespaces
    {	
        //----------------------------------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------------------------------
        
        // atom name space (http://www.w3.org/2005/Atom)
        public static const ans:Namespace = new Namespace("", "http://www.w3.org/2005/Atom");
        
        // google spreadsheet name space (http://schemas.google.com/spreadsheets/2006)
        public static const gs:Namespace = new Namespace("gs", "http://schemas.google.com/spreadsheets/2006");
        
        // google extended spreadsheet name space (http://schemas.google.com/spreadsheets/2006/extended)
        public static const gsx:Namespace = new Namespace("gsx", "http://schemas.google.com/spreadsheets/2006/extended");
        
        //----------------------------------------------------------------------------------------------
    }
}