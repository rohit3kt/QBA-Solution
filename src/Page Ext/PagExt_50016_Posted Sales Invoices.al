pageextension 50016 SalesInvoiceList extends "Posted Sales Invoices"
{
    // GST Amount, Net Amount, TDS Amount
    // GST Amount= 
    layout
    {
        addafter(Amount)
        {
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field(GSTAmt; GSTAmt)
            {
                Caption = 'GST Amount';
                ApplicationArea = all;
            }
            field(TotalTDSAmt; TotalTDSAmt)
            {
                Caption = 'TDS Amount';
                ApplicationArea = all;
            }
            field(NetTotal; Rec.Amount + GSTAmt - TotalTDSAmt)
            {
                Caption = 'Net Total';
                ApplicationArea = all;
            }
        }
        modify("Amount Including VAT")
        {
            CaptionClass = label1;
        }
    }
    actions
    {
        addafter("Update Document")
        {
            action("Update Ext Doc No.")
            {
                ApplicationArea = All;
                Caption = 'Update Ext Doc No.';
                Image = Process;
                Ellipsis = true;
                //AccessByPermission = tabledata "Sales Invoice Header" = m;
                Visible = false;
                trigger OnAction()
                var
                    LineNo: Integer;
                    LengthCove: Integer;
                    InputBox: Page "Input Box";
                    InputValue: Date;
                    SalesInvHeader: Record "Sales Invoice Header";
                    GlEntry: Record "G/L Entry";
                    QBA_CU: Codeunit "QBA Event Subscriber";
                begin
                    if Rec."No." <> '' then begin
                        InputBox.LookupMode := true;
                        if InputBox.RunModal() <> Action::LookupOK then
                            Error('Process has been aborted!');
                        InputValue := InputBox.GetComment();
                        QBA_CU.SetDef('SALES', Rec."No.", InputValue);
                        if QBA_CU.Run() then begin
                            Message('External Document No. has been updated for Document No %1', Rec."No.");
                        end;
                    end;
                end;
            }
            action(ExportExcel)
            {
                Caption = 'Export Excell';
                ApplicationArea = All;
                Image = ExportToExcel;
                RunObject = Report "Export Sal inv Data Into Excel";
            }
            action(ImportIRN)
            {
                ApplicationArea = All;
                Caption = 'Import IRN';
                Image = ImportExcel;
                Ellipsis = true;
                trigger OnAction()
                var
                    LineNo: Integer;
                    LengthCove: Integer;
                    InputBox: Page "Input Box";
                    InputValue: Date;
                    SalesInvHeader: Record "Sales Invoice Header";
                    GlEntry: Record "G/L Entry";
                    QBA_CU: Codeunit "QBA Event Subscriber";
                    RecRef: RecordRef;
                begin
                    QBA_CU.ReadExcelSheet();
                    QBA_CU.ImportIRNData();
                end;
            }
            action(HasValue)
            {
                ApplicationArea = All;
                Caption = 'HasValue';
                Image = Process;
                Ellipsis = true;
                Visible = false; // Commented by Rohit Singh
                trigger OnAction()
                var
                    InStreamL: InStream;
                    WorkDescription: Text;
                begin
                    Clear(WorkDescription);
                    Rec.Calcfields("QR Code");
                    If Rec."QR Code".HasValue() then begin
                        Rec."QR Code".CreateInStream(InStreamL);
                        InStreamL.Read(WorkDescription);
                        Message(WorkDescription);
                    end;
                end;
            }
            action(CHeckReport)
            {
                ApplicationArea = All;
                Caption = 'Check Report';
                Ellipsis = true;
                Image = "Report";
                Visible = false; // Commented by Rohit Singh
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset;
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.Find('-') then
                        REPORT.Run(50034, true, false, SalesInvoiceHeader);
                end;
            }
        }
        addafter(Navigate_Promoted)
        {
            actionref("ExportExcel_Promoted"; ExportExcel)
            {
            }
            actionref("ImportIRN_Promoted"; ImportIRN)
            {

            }
            actionref("HasValue_Promoted"; HasValue)
            {
                Visible = false; // Commented by Rohit Singh
            }
            actionref("CHeckReport_Promoted"; CHeckReport)
            {
                Visible = false; // Commented by Rohit Singh
            }

        }
    }
    trigger OnOpenPage()
    var
        QBA_CU: Codeunit "QBA Event Subscriber";
    begin
        QBA_CU.GetAmountLCY();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        GSTAmt := GetGSTAmount(Rec."No.");
        TotalTDSAmt := GetTDSAmount(Rec."No.");
        // TotalSGSTAmt := 0;
        // TotalIGSTAmt := 0;
        // TotalCGSTAmount := 0;
        // AmtVendorTotal := 0;
        // Clear(CGSTAmt);
        // Clear(SGSTAmt);
        // Clear(IGSTAmt);
        // PurchaseLine.Reset();
        // PurchaseLine.SetRange("Document No.", Rec."No.");
        // If PurchaseLine.FindSet() then
        //     repeat // Clear(CGSTAmt);
        //         // Clear(SGSTAmt);
        //         // Clear(IGSTAmt);
        //         GetGSTAmount(PurchaseLine.RecordId);
        //         AmtVendorTotal += (CGSTAmt + SGSTAmt + IGSTAmt + PurchaseLine."Amount Including VAT") - (PurchaseLine."Line Discount Amount");
        //         TotalCGSTAmount += CGSTAmt;
        //         TotalIGSTAmt += IGSTAmt;
        //         TotalSGSTAmt += SGSTAmt;
        //     until PurchaseLine.Next() = 0;
    end;

    var
        GSTAmt: Decimal;
        label1: Label 'Amount Including GST';
        // tdsTotal: Decimal;
        // purchaseLine6: Record 113;
        // RecID: RecordID;
        // TotalCGSTAmount: Decimal;
        // AmtVendorTotal: Decimal;
        // TotalSGSTAmt: Decimal;
        // TotalIGSTAmt: Decimal;
        // TermDesc: text[150];
        // Sub55: Text[500];
        // // recTerms: Record 50073;
        // test: Record "Tax Transaction Value";
        // test2: BigText;
        // blobcomment2: text[500];
        // //  commentBLOB4: Record 50078;
        // recPurHeader9: Record "Purchase Header";
        // recpurline9: Record 113;
        // //  commentBLOB2: Record 50078;// "Comment Blob";
        // //  commentBLOB3: Record 50078;
        // PurCommentLine: Record 43;
        // Subject: Text[500];
        // // LineComment: blob;
        // reportcheck: Report Check;
        // blobcomment: text;
        // amtinwords: array[2] of text[250];
        // GrandTotal: Decimal;
        // RecVLE: Record "Vendor Ledger Entry";
        // GSTPerVar: Decimal;
        // Vendor: Record Vendor;
        // Qty: Decimal;
        // UnitPrice: Decimal;
        // Salesperson: Record "Salesperson/Purchaser";
        // SalespersonText: Text[50];
        // Amount_: Decimal;
        // purchaseLine: Record 113;
        // ctr: Integer;
        // TaxTransactionvalue: Record "Tax Transaction Value";
        // // termCoditionTransaction: Record "Terms & Condition Transaction";
        // CompInfo: Record "Company Information";
        // DimensionSetEntry: Record "Dimension Set Entry";
        // DimCode: Code[20];
        // PurchCommentLine: Record "Purch. Comment Line";
        // ArchiveDate: Date;
        // QuoteDate: Date;
        // Comments: Text;
        // PurchHeaderArchive: Record "Purchase Header Archive";
        // PurchHeaderArchive2: Record "Purchase Header Archive";
        // TransMethod: Record "Transport Method";
        // ShippingMethod: Record "Shipment Method";
        // CountryRegionN: Text;
        // CountryName: Record "Country/Region";
        // Freight: Code[20];
        // ModeOfTransport: Text[100];
        // SrNo: Integer;
        // PrevVend: Code[20];
        // TaxableAmt: Decimal;
        // State: Record State;
        // RecState: Record State;
        // DocDate: Text[10];
        // RecItem: Record Item;
        // SrNo1: Integer;
        // DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        // DisAmt: Decimal;
        // CGSTPer: Decimal;
        // CGSTAmt: Decimal;
        // SGSTPer: Decimal;
        // SGSTAmt: Decimal;
        // IGSTPer: Decimal;
        // IGSTAmt: Decimal;
        // RepCheck: array[2] of Report Check;
        // NoTextExcise: array[2] of Text[80];
        // NoText: array[2] of Text[80];
        // Totalfin: Decimal;
        // TotalTotNoOfPkgs: Decimal;
        // TotalQty: Decimal;
        // TotalLineAmt: Decimal;
        // TotalExciseAmt: Decimal;
        // TotalAmtToCustomer: Decimal;
        // ChargesAmount: Decimal;
        // OtherTaxesAmount: Decimal;
        // paydesc: Text[58];
        // paymentmethod: Record "Payment Method";
        // TotalAmtToCustomerInvrounding: Decimal;
        // AmountToVendor_PL: Decimal;
        // purpose: Text[50];
        // Department: Text[50];
        // GenjnlNartn: Text;
        // GenjnlNartn1: Text;
        // GenjnlNartn2: Text;
        // Location: Record Location;
        // LocState: Text[50];
        // Currency: Text[10];
        // grade: Text[10];
        // VenStateDesc: Text;
        // PaymentTerms: Record "Payment Terms";
        // gcjs: Page "Purchase Order";
        // TdsAmt: Decimal;
        // TdsPer: Decimal;
        TotalTDSAmt: Decimal;
    // PurchLine: Record 113;
    // PurchaeHeaderRec: Record "Purchase Header";


    // local procedure GetGSTAmount(RecID: RecordID)
    // var
    //     TaxTransactionValue: Record "Tax Transaction Value";
    //     GSTSetup: Record "GST Setup";
    //     LpurLine: Record 113;
    // begin
    //     if not GSTSetup.Get() then exit;
    //     TaxTransactionValue.SetRange("Tax Record ID", RecID);
    //     TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
    //     if GSTSetup."Cess Tax Type" <> '' then
    //         TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
    //     else
    //         TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
    //     TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
    //     if TaxTransactionValue.FindFirst() then
    //         repeat
    //             if TaxTransactionValue."Value ID" = 2 then begin
    //                 CGSTAmt += TaxTransactionValue.Amount;
    //                 CGSTPer := TaxTransactionValue.Percent;
    //             end;
    //             if TaxTransactionValue."Value ID" = 6 then begin
    //                 SGSTAmt += TaxTransactionValue.Amount;
    //                 SGSTPer := TaxTransactionValue.Percent;
    //             end;
    //             if TaxTransactionValue."Value ID" = 3 then begin
    //                 IGSTAmt += TaxTransactionValue.Amount;
    //                 IGSTPer := TaxTransactionValue.Percent;
    //             end;
    //         until TaxTransactionValue.Next() = 0;
    // end;

    // local procedure GetTDSAmount(RecID: RecordID)
    // var
    //     TaxTransactionValue: Record "Tax Transaction Value";
    //     GSTSetup: Record "GST Setup";
    // begin
    //     Clear(TdsAmt);
    //     Clear(TdsPer);
    //     if not GSTSetup.Get() then exit;
    //     Clear(tdsTotal);
    //     Clear(TotalTDSAmt);
    //     Clear(TdsAmt);
    //     TaxTransactionValue.SetRange("Tax Record ID", RecID);
    //     TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
    //     TaxTransactionValue.SetRange("Tax Type", 'TDS');
    //     TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
    //     if TaxTransactionValue.FindFirst() then
    //         repeat
    //             TdsAmt := TaxTransactionValue.Amount;
    //             TotalTDSAmt := Round(TdsAmt, 1, '=');
    //         until TaxTransactionValue.Next() = 0;
    //     // tdsTotal := TotalTDSAmt;
    // end;

    local procedure GetGSTAmount(DocNo_P: Code[20]): Decimal
    var
        GStLedgEntry: Record "GST Ledger Entry";
    begin
        GStLedgEntry.Reset();
        GStLedgEntry.SetRange("Source Type", GStLedgEntry."Source Type"::Customer);
        GStLedgEntry.SetRange("Document Type", GStLedgEntry."Document Type"::Invoice);
        GStLedgEntry.SetRange("Transaction Type", GStLedgEntry."Transaction Type"::Sales);
        GStLedgEntry.SetRange("Document No.", DocNo_P);
        if GStLedgEntry.FindFirst() then
            exit(GStLedgEntry."GST Amount" * -1);
    end;

    local procedure GetTDSAmount(DocNo_P: Code[20]): Decimal
    var
        TSDEntry: Record "TDS Entry";
    begin
        TSDEntry.Reset();
        TSDEntry.SetRange("Document No.", DocNo_P);
        if TSDEntry.FindFirst() then
            exit(TSDEntry."TDS Amount" * -1);
    end;
}
