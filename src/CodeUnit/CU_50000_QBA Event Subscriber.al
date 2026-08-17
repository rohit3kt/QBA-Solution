codeunit 50000 "QBA Event Subscriber"
{
    Permissions = tabledata "Purchase Header Archive" = D,
                  tabledata "Purchase Line Archive" = D,
                  tabledata "Sales Header Archive" = D,
                  TableData "Sales Invoice Header" = irm,
                  TableData "Cust. Ledger Entry" = rim,
                  TableData "Detailed Cust. Ledg. Entry" = rm,
                  TableData "G/L Entry" = rm,
                  TableData "Vendor Ledger Entry" = rmid,
                  TableData "Detailed Vendor Ledg. Entry" = rm,
                  TableData "GST Ledger Entry" = rm,
                  TableData "Detailed GST Ledger Entry" = rm,
                  TableData "Detailed GST Ledger Entry Info" = rm,
                  TableData "Value Entry" = rm,
                  TableData "Sales Cr.Memo Header" = irm;
    trigger OnRun()
    begin
        case Method of
            'SALES':
                begin
                    //ChangePostingDateOfSalesDoc();
                end;
        end;
    end;

    var
        myInt: Integer;
        DocNo: Code[20];
        Method: Code[20];
        InputValue: Date;
        //.....................................++
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TransName: Code[10];
        SheetName: Text[100];
        FileName: Text[100];
    //.....................................--

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnCodeOnAfterGenJnlPostBatchRun', '', false, false)]
    local procedure "Gen. Jnl.-Post_OnCodeOnAfterGenJnlPostBatchRun"(var GenJnlLine: Record "Gen. Journal Line")
    begin
        // recgenjn."comment 2" := 
    end;

    procedure DeletPOArchive()
    var
        PurchaseHeaderArchive: Record "Purchase Header Archive";
        PurchaseLineArchive: Record "Purchase Line Archive";
    begin
        PurchaseHeaderArchive.Reset();
        if PurchaseHeaderArchive.FindSet() then
            repeat
                PurchaseHeaderArchive.Delete(true);
            until PurchaseHeaderArchive.Next() = 0;
        Message('PO Archive Deleted');
    end;

    procedure DeletSOArchive()
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        SalesHeaderArchive.Reset();
        if SalesHeaderArchive.FindSet() then
            repeat
                SalesHeaderArchive.Delete(true);
            until SalesHeaderArchive.Next() = 0;
    end;

    procedure GetAmountLCY()
    var
        DetailedCustLedgeEntry: Record "Detailed Cust. Ledg. Entry";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        SalesInvHeader.Reset();
        SalesInvHeader.SetFilter("Amount (LCY)", '=%1', 0);
        if SalesInvHeader.FindSet() then begin
            repeat
                DetailedCustLedgeEntry.Reset();
                DetailedCustLedgeEntry.SetRange("Entry Type", DetailedCustLedgeEntry."Entry Type"::"Initial Entry");
                DetailedCustLedgeEntry.SetRange("Document Type", DetailedCustLedgeEntry."Document Type"::Invoice);
                DetailedCustLedgeEntry.SetRange("Document No.", SalesInvHeader."No.");
                DetailedCustLedgeEntry.SetRange("Customer No.", SalesInvHeader."Bill-to Customer No.");
                if DetailedCustLedgeEntry.FindFirst() then begin
                    SalesInvHeader."Amount (LCY)" := DetailedCustLedgeEntry."Amount (LCY)";
                    SalesInvHeader.Modify();
                end;
            until SalesInvHeader.Next() = 0;
        end;
    end;

    procedure SetDef(Method_P: Code[20]; DocNo_P: Code[20]; InputValue_P: Date)
    begin
        Method := Method_P;
        DocNo := DocNo_P;
        InputValue := InputValue_P;
    end;

    //............................................................................++
    procedure ReadExcelSheet()
    var
        FileManagent: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
        FileName: Text[100];
        SheetName: Text[100];

        UploadMsg: Label 'Please choose the Excel file';
        NoFileMsg: Label 'No Excel file found';
    begin
        UploadIntoStream(UploadMsg, '', '', FromFile, Istream);
        if FromFile <> '' then begin
            FileName := FileManagent.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(Istream);

        end else
            Error(NoFileMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(Istream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    procedure ImportIRNData()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        RowNo: Integer;
        ColNo: Integer;
        LineNO: Integer;
        MaxRow: Integer;
        ExcelImportSuccess: Label 'Excel imported successfully';
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        FieldRef: FieldRef;
        TempDateTime: DateTime;
        AcknowledgementDateTimeText: Text;
        AcknowledgementDate: Date;
        AcknowledgementTime: Time;
        RecRef: RecordRef;
        QRCodeTempText: Text;
    begin

        RowNo := 0;
        ColNo := 0;
        MaxRow := 0;
        LineNO := 0;

        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRow := TempExcelBuffer."Row No.";
        end;


        for RowNo := 2 to MaxRow do begin
            if SalesInvoiceHeader.Get(GetValueAtCell(RowNo, 5)) then begin
                Clear(RecRef);
                RecRef.GetTable(SalesInvoiceHeader);

                //SalesInvoiceHeader."IRN Hash" := GetValueAtCell(RowNo, 2);
                FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("IRN Hash"));
                FieldRef.Value := GetValueAtCell(RowNo, 2);

                //SalesInvoiceHeader."Acknowledgement No." := GetValueAtCell(RowNo, 3);
                FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement No."));
                FieldRef.Value := GetValueAtCell(RowNo, 3);

                //SalesInvoiceHeader."Acknowledgement Date" := TempExcelBuffer.ConvertDateTimeDecimalToDateTime(AcknowledgementDateTimeDecimal);

                // AcknowledgementDateTimeText := GetValueAtCell(RowNo, 4);
                // Evaluate(AcknowledgementDateTimeDecimal, AcknowledgementDateTimeText);
                // FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));
                // FieldRef.Value := TempExcelBuffer.ConvertDateTimeDecimalToDateTime(AcknowledgementDateTimeDecimal);
                //.................
                AcknowledgementDateTimeText := GetValueAtCell(RowNo, 4);
                Evaluate(AcknowledgementDate, CopyStr(AcknowledgementDateTimeText, 1, 10));
                Evaluate(AcknowledgementTime, CopyStr(AcknowledgementDateTimeText, 12, 8));
                TempDateTime := CreateDateTime(AcknowledgementDate, AcknowledgementTime);
                FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));
                FieldRef.Value := TempDateTime;
                //.................


                // SalesInvoiceHeader."QR Code".CreateOutStream(Outstream);
                // Outstream.WriteText(GetValueAtCell(RowNo, 11));
                //SalesInvoiceHeader.Modify();
                QRCodeTempText := GetQRCodeText(RowNo, 11);
                QRGenerator.GenerateQRCodeImage(QRCodeTempText, TempBlob);
                FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
                TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
                RecRef.Modify();
            end;
        end;
        Message(ExcelImportSuccess);
    end;

    procedure ImportIRNDataIntoCrMemo()
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RowNo: Integer;
        ColNo: Integer;
        LineNO: Integer;
        MaxRow: Integer;
        ExcelImportSuccess: Label 'Excel imported successfully';
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        FieldRef: FieldRef;
        TempDateTime: DateTime;
        AcknowledgementDateTimeText: Text;
        AcknowledgementDate: Date;
        AcknowledgementTime: Time;
        RecRef: RecordRef;
        QRCodeTempText: Text;
    begin

        RowNo := 0;
        ColNo := 0;
        MaxRow := 0;
        LineNO := 0;

        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRow := TempExcelBuffer."Row No.";
        end;


        for RowNo := 2 to MaxRow do begin
            if SalesCrMemoHeader.Get(GetValueAtCell(RowNo, 5)) then begin
                Clear(RecRef);
                RecRef.GetTable(SalesCrMemoHeader);

                //.................
                FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("IRN Hash"));
                FieldRef.Value := GetValueAtCell(RowNo, 2);
                //.................

                //.................
                FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement No."));
                FieldRef.Value := GetValueAtCell(RowNo, 3);
                //.................

                //.................
                AcknowledgementDateTimeText := GetValueAtCell(RowNo, 4);
                Evaluate(AcknowledgementDate, CopyStr(AcknowledgementDateTimeText, 1, 10));
                Evaluate(AcknowledgementTime, CopyStr(AcknowledgementDateTimeText, 12, 8));
                TempDateTime := CreateDateTime(AcknowledgementDate, AcknowledgementTime);
                FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement Date"));
                FieldRef.Value := TempDateTime;
                //.................

                //.................
                QRCodeTempText := GetQRCodeText(RowNo, 11);
                QRGenerator.GenerateQRCodeImage(QRCodeTempText, TempBlob);
                FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
                TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
                RecRef.Modify();
                //.................
            end;
        end;
        Message(ExcelImportSuccess);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text

    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    procedure GetQRCodeText(RowNo: Integer; ColNo: Integer) WorkDescription: Text
    var
        MyInStream: InStream;
    begin
        Clear(WorkDescription);
        if TempExcelBuffer.Get(RowNo, ColNo) then begin
            TempExcelBuffer.Calcfields("Cell Value as Blob");
            If TempExcelBuffer."Cell Value as Blob".HasValue() then begin
                TempExcelBuffer."Cell Value as Blob".CreateInStream(MyInStream);
                MyInStream.Read(WorkDescription);
            end;
        end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Excel Buffer", 'OnBeforeParseCellValue', '', false, false)]
    // local procedure "Excel Buffer_OnBeforeParseCellValue"(
    //     var ExcelBuffer: Record "Excel Buffer";
    //     var FormatString: Text;
    //     var Value: Text;
    //     var IsHandled: Boolean
    // )
    // var
    //     Test: Text[250];
    //     //"QBA Cell Value as Text"
    //     OutStream: OutStream;
    //     Decimal: Decimal;
    //     RoundingPrecision: Decimal;
    // begin
    //     if StrLen(Value) > 250 then
    //         IsHandled := true;

    //     ExcelBuffer.NumberFormat := CopyStr(FormatString, 1, 30);

    //     Clear(ExcelBuffer."Cell Value as Blob");
    //     if FormatString = '@' then begin
    //         ExcelBuffer."Cell Type" := ExcelBuffer."Cell Type"::Text;
    //         ExcelBuffer."QBA Cell Value as Text" := CopyStr(Value, 1, MaxStrLen(ExcelBuffer."QBA Cell Value as Text"));

    //         if StrLen(Value) <= MaxStrLen(ExcelBuffer."QBA Cell Value as Text") then
    //             exit; // No need to store anything in the blob

    //         ExcelBuffer."Cell Value as Blob".CreateOutStream(OutStream, TEXTENCODING::Windows);
    //         OutStream.Write(Value);
    //         exit;
    //     end;

    //     Evaluate(Decimal, Value);

    //     if StrPos(FormatString, ':') <> 0 then begin
    //         // Excel Time is stored in OADate format
    //         ExcelBuffer."Cell Type" := ExcelBuffer."Cell Type"::Time;
    //         ExcelBuffer."Cell Value as Text" := Format(DT2Time(ExcelBuffer.ConvertDateTimeDecimalToDateTime(Decimal)));
    //         exit;
    //     end;

    //     if ((StrPos(FormatString, 'y') <> 0) or
    //         (StrPos(FormatString, 'm') <> 0) or
    //         (StrPos(FormatString, 'd') <> 0)) and
    //        (StrPos(FormatString, 'Red') = 0)
    //     then begin
    //         ExcelBuffer."Cell Type" := ExcelBuffer."Cell Type"::Date;
    //         ExcelBuffer."Cell Value as Text" := Format(DT2Date(ExcelBuffer.ConvertDateTimeDecimalToDateTime(Decimal)));
    //         exit;
    //     end;

    //     ExcelBuffer."Cell Type" := ExcelBuffer."Cell Type"::Number;
    //     RoundingPrecision := 0.000001;
    //     //OnParseCellValueOnBeforeRoundDecimal(Rec, Decimal, RoundingPrecision);
    //     ExcelBuffer."Cell Value as Text" := Format(Round(Decimal, RoundingPrecision), 0, 1);
    // end;
    //............................................................................--


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlEntry', '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertGlEntry"(
        var GenJnlLine: Record "Gen. Journal Line";
        var GLEntry: Record "G/L Entry";
        var IsHandled: Boolean)
    var
        Test: Text[10];
    begin
        Test := '111';
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure "Purch.-Post_OnBeforeInsertGlEntry"(
        PurchInvHdrNo: Code[20];
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        GLEntry: Record "G/L Entry";
        PurchInvLine: Record "Purch. Inv. Line";
        TempText: Text;
    begin
        if PurchInvHdrNo <> '' then begin
            PurchInvLine.Reset();
            PurchInvLine.SetRange("Document No.", PurchInvHdrNo);
            if PurchInvLine.FindSet() then
                repeat
                    TempText += PurchInvLine.Remark + ', ';
                until PurchInvLine.Next() = 0;
            GLEntry.Reset();
            GLEntry.SetRange("Document No.", PurchInvHdrNo);
            GLEntry.SetRange("Gen. Posting Type", GLEntry."Gen. Posting Type"::Purchase);
            if GLEntry.FindFirst() then begin
                GLEntry.Comment += TempText.TrimEnd(',');
                GLEntry.Modify();
            end;
        end;
    end;

    procedure UpdateVendorLedgerEntry(EntryNo: Integer)
    var
        RecVendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if RecVendLedgerEntry.Get(EntryNo) then begin
            RecVendLedgerEntry.Exported := true;
            RecVendLedgerEntry."QBA Payment Amount" := 0;
            RecVendLedgerEntry.Modify();
            //Commit();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Vend. Entry-Edit", OnBeforeVendLedgEntryModify, '', false, false)]
    local procedure "Vend. Entry-Edit_OnBeforeVendLedgEntryModify"(var VendLedgEntry: Record "Vendor Ledger Entry"; FromVendLedgEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgEntry.Validate(Exported, FromVendLedgEntry.Exported);
        VendLedgEntry."QBA Payment Amount" := FromVendLedgEntry."QBA Payment Amount";
    end;


    //....TDS 26Q Export Report.....++
    // [EventSubscriber(ObjectType::Report, Report::"TDS 26Q Export", OnAfterMakeExcelHeader, '', false, false)]
    // local procedure "TDS 26Q Export_OnAfterMakeExcelHeader"
    //                 (
    //                 var TempExcelBuffer: Record "Excel Buffer"
    //                 )
    // var

    // begin
    //     TempExcelBuffer.AddColumn('Invoice No.', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
    // end;

    // [EventSubscriber(ObjectType::Report, Report::"TDS 26Q Export", OnAfterCreateExcelBody, '', false, false)]
    // local procedure "TDS 26Q Export_OnAfterCreateExcelBody"
    //                 (
    //                     TDS27Q: Query "TDS 27Q";
    //                     var TempExcelBuffer: Record "Excel Buffer"
    //                 )
    // var
    //     TDSEntry: Record "TDS Entry";
    //     TempDoc: Text;
    //     Test: Text;
    // begin
    //     Clear(TempDoc);
    //     TDSEntry.Reset();
    //     TDSEntry.SetRange("Deductee PAN No.", TDS27Q.Deductee_PAN_No_);
    //     TDSEntry.SetRange("Vendor No.", TDS27Q.Vendor_No_);
    //     TDSEntry.SetRange(Section, TDS27Q.Section);
    //     TDSEntry.SetRange("Posting Date", TDS27Q.Posting_Date);
    //     TDSEntry.SetRange("Invoice Amount", TDS27Q.Invoice_Amount);
    //     TDSEntry.SetRange("TDS Amount", TDS27Q.TDS_Amount);
    //     TDSEntry.SetRange("TDS %", TDS27Q.TDS__);
    //     if TDSEntry.FindFirst() then begin
    //         TempDoc := TDSEntry."Document No.";
    //         if ((TempDoc = 'PPIN/24-25/0218') OR (TempDoc = 'PPIN/24-25/0220')) then
    //             Test := '1111';
    //         TempExcelBuffer.AddColumn(TempDoc, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    //     end;
    // end;
    //....TDS 26Q Export Report.....--
    procedure CreateCLE(TempEntryNo: Integer; TempCustomerNo: Code[20]): Boolean
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        if CLE.Get(TempEntryNo) then
            exit(false);

        if (TempEntryNo <> 0) then begin
            CLE."Entry No." := TempEntryNo;
            CLE.Validate("Customer No.", TempCustomerNo);
            CLE.Insert(true);
            exit(true);
        end;
    end;

    // //.....................................++ Worked on 9th January 2026
    // procedure CreateCustLedgerEntry()
    // var
    //     CustLedgerEntry: Record "Cust. Ledger Entry";
    // begin
    //     CustLedgerEntry.Init();
    //     CustLedgerEntry."Entry No." := 730;
    //     CustLedgerEntry."Customer No." := 'C00003';
    //     CustLedgerEntry.Insert();
    // end;
}