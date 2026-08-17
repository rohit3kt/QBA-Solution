tableextension 50038 "QBA Excel Buffer" extends "Excel Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "QBA Cell Value as Text"; Text[1024])
        {
            Caption = 'QBA Cell Value as Text';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    // procedure QBAReadSheet()
    // begin
    //     ReadSheetContinous('', true);
    // end;

    // procedure QBAReadSheetContinous(SheetName: Text; CloseBookOnCompletion: Boolean)
    // var
    //     ColumnList: List of [Integer];
    //     RowList: List of [Integer];
    // begin
    //     ReadSheetContinous(SheetName, CloseBookOnCompletion, ColumnList, RowList, 0);
    // end;

    // procedure QBAReadSheetContinous(SheetName: Text; CloseBookOnCompletion: Boolean; ColumnList: List of [Integer]; RowList: List of [Integer]; MaxRowNo: Integer)
    // var
    //     ExcelBufferDialogMgt: Codeunit "Excel Buffer Dialog Management";
    //     CellData: DotNet CellData;
    //     Enumerator: DotNet IEnumerator;
    //     RowCount: Integer;
    //     LastUpdate: DateTime;
    //     ReadData: Boolean;
    // begin
    //     // Allows reading Excel files with more than one sheet without closing and reopening file
    //     if SheetName <> '' then
    //         SetActiveReaderSheet(SheetName);
    //     LastUpdate := CurrentDateTime;
    //     ExcelBufferDialogMgt.Open(Text007);
    //     DeleteAll();

    //     Enumerator := XlWrkShtReader.GetEnumerator();
    //     RowCount := XlWrkShtReader.RowCount;
    //     ReadData := Enumerator.MoveNext();
    //     while ReadData do begin
    //         CellData := Enumerator.Current;
    //         if CellData.HasValue() and ShouldReadCellData(CellData.ColumnNumber, CellData.RowNumber, ColumnList, RowList) then begin
    //             Validate("Row No.", CellData.RowNumber);
    //             Validate("Column No.", CellData.ColumnNumber);
    //             ParseCellValue(CellData.Value, CellData.Format);
    //             Insert();

    //             if not UpdateProgressDialog(ExcelBufferDialogMgt, LastUpdate, CellData.RowNumber, RowCount) then begin
    //                 CloseBook();
    //                 Error(Text035)
    //             end;
    //         end;
    //         ReadData := Enumerator.MoveNext();
    //         if MaxRowNo = CellData.RowNumber then
    //             ReadData := false;
    //     end;

    //     if CloseBookOnCompletion then
    //         CloseBook();
    //     ExcelBufferDialogMgt.Close();
    // end;

    var
        myInt: Integer;
}