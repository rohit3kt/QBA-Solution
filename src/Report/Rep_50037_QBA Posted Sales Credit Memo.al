report 50037 "QBA Posted Sales Credit Memo"
{
    ApplicationArea = All;
    Caption = 'QBA Posted Sales Credit Memo';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = "QBA Posted Sales Credit Memo";
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(DocNo_; "No.") { }
            column(exportdeclaration; exportdeclaration) { }
            column(cStateneme; cStateneme) { }
            column(ccountryname; ccountryname) { }
            column(AppliedAmount; AppliedAmount) { }
            column(Cpicture; reccompinfo.Picture2) { }
            column(msmeno; reccompinfo."MSME No.") { }
            column(INRorUSDorEURO; INRorUSDorEURO) { }
            column(Cname; reccompinfo.Name) { }
            column(External_Document_No_; "External Document No.") { }
            column(CIN; reccompinfo.CIN) { }
            column(ARN; reccompinfo."ARN No.") { }
            column(caddress; (reccompinfo.Address + ', ' + reccompinfo."Address 2")) { }
            column(caddress2; (reccompinfo."Post Code" + ', ' + reccompinfo.City + ', ' + cStateneme + ' ,' + ccountryname)) { }
            column(cemail; reccompinfo."E-Mail") { }
            column(reccompinfopostcode; reccompinfo."Post Code") { }
            column(CGstreg; reccompinfo."GST Registration No.") { }
            column(compPAn; reccompinfo."P.A.N. No.") { }
            column(custACK; custACK) { }
            column(custGST; ShiptoGST) { }
            column(ShiptoGST2; ShiptoGST2) { }
            column(No; "No.") { }
            column(DocumentDate; format("Document Date")) { }
            column(DueDate; format("Due Date")) { }
            column(PaymentMethodCode; "Payment Method Code") { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(PostingDate; "Posting Date") { }
            column(QuoteNo; '') { }
            column(ReasonCode; "Reason Code") { }
            column(BalAccountNo; "Bal. Account No.") { }
            column(BilltoAddress; "Bill-to Address" + ', ' + "Bill-to Address 2" + ', ' + "Bill-to City" + ', ' + "Bill-to Post Code" + ', ' + custstate + ', ' + "Bill-to County") { }
            column(BilltoAddress2; "Bill-to Address 2") { }
            column(BilltoCity; "Bill-to City") { }
            column(BilltoContact; "Bill-to Contact") { }
            column(BilltoContactNo; "Bill-to Contact No.") { }
            column(BilltoCounty; "Bill-to County") { }
            column(BilltoName; "Bill-to Name") { }
            column(BilltoPostCode; "Bill-to Post Code") { }
            column(BilltoCustomerNo; "Bill-to Customer No.") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Comment; Comment) { }
            column(IRN_Hash; "IRN Hash") { }
            column(Acknowledgement_No_; "Acknowledgement No.") { }
            column(Acknowledgement_Date; "Acknowledgement Date") { }
            column(QR_Code; "QR Code") { }
            column(ReportHeading; ReportHeading) { }
            column(BankAccName; BankAcc[1]) { }
            column(BankAccBranch; BankAcc[2]) { }
            column(BankAccNo; BankAcc[3]) { }
            column(BankAccIFSC; BankAcc[4]) { }
            column(BankAccSWIFT; BankAcc[5]) { }
            column(TDSNote; TDSNote) { }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                column(ItemNo_; "No.") { }
                column(Description; Description + ', ' + "Description 2") { }
                column(SlNo; SlNo) { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(NoText; NoText[1]) { }
                column(cgst_amt; "cgst amt") { }
                column(Igst_amt; "Igst amt") { }
                column(cgst_per; "cgst per") { }
                column(Igst_per; "Igst per") { }
                column(CGSTPer; CGSTPer) { }
                column(SGSTPer; SGSTPer) { }
                column(IGSTPer; IGSTPer) { }
                column(CGSTAmt; CGSTAmt) { }
                column(SGSTAmt; SGSTAmt) { }
                column(IGSTAmt; IGSTAmt) { }
                column(TotSGSTAmt; TotSGSTAmt) { }
                column(TotCGSTAmt; TotCGSTAmt) { }
                column(TotIGSTAmt; TotIGSTAmt) { }
                column(Total_Line_CGST_SGST_IGST; Total_Line_CGST_SGST_IGST) { }
                column(amtinwords; NoText[1] + ' ' + NoText[2]) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                trigger OnPreDataItem()// Line
                begin
                    SlNo := 0;
                    "Sales Cr.Memo Line".SetFilter(Quantity, '<>%1', 0);
                end;

                trigger OnAfterGetRecord()// Line
                begin

                    SlNo += 1;
                    GSTSetup.Get();
                    //GetGSTCaptions(TaxTrnasactionValue, "Sales Line", GSTSetup);
                    //GetGSTAmounts(TaxTrnasactionValue, "Sales Line", GSTSetup);
                    GstComponent("Sales Cr.Memo Line");



                end;
            }
            trigger OnPreDataItem()// Header
            begin
                Clear(ReportHeading);
                reccompinfo.get;
                reccompinfo.CalcFields(Picture2);
                Clear(printDuplicate);
            end;

            trigger OnAfterGetRecord()// Header
            begin
                if StrPos("Sales Cr.Memo Header"."No.", 'QBAEX') <> 0 then
                    ReportHeading := ExportInvoiceLabel
                else
                    ReportHeading := TaxInvoiceLabel;

                clear(AppliedAmount);
                CustLedgerEntry_G.Reset();
                CustLedgerEntry_G.SetRange("Document No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                if CustLedgerEntry_G.FindFirst() then begin
                    CustLedgerEntry_G.CalcFields(Amount);
                    AppliedAmount := CustLedgerEntry_G.Amount;
                end;
                if State_G.Get(reccompinfo."State Code") then
                    cstateneme := State_G.Description;

                if CountryRegion_G.get(reccompinfo."Country/Region Code") then
                    ccountryname := CountryRegion_G.Name;

                if State_G.Get("GST Bill-to State Code") then
                    custstate := State_G.Description;

                Clear(INRorUSDorEURO);
                if "Sales Cr.Memo Header"."Currency Code" = '' then
                    INRorUSDorEURO := 'INR'
                else if "Sales Cr.Memo Header"."Currency Code" = 'EUR' then
                    INRorUSDorEURO := 'EUR'
                else if "Sales Cr.Memo Header"."Currency Code" = 'USD' then
                    INRorUSDorEURO := 'USD'
                else if "Sales Cr.Memo Header"."Currency Code" = 'GBP' then
                    INRorUSDorEURO := 'GBP';

                if SGSTAmt <> 0 then
                    gsrper := SGSTPer * 2
                else
                    gsrper := igstper;

                if PurchaseHeader."Ship To" = 'Location' then begin
                    shiptoaddress := recloc.Address + ' ,' + recloc."Address 2" + ' ,' + recloc.City + ' ,' + recloc."Post Code" + ' ,' + locstatecode + ' ,' + recloc."Country/Region Code";
                    ShiptoGST := recloc."GST Registration No.";
                    ShipToPAN := CopyStr(recloc."GST Registration No.", 3, 10);
                    ShipToCIN := recloc.CIN;
                    ShipToCode := recloc.Code;
                    ShipToName := recloc.Name;
                end;

                if PurchaseHeader."Ship To" = 'Customer Address' then begin
                    reccust.get("Sales Cr.Memo Header"."Sell-to Customer No.");
                    shiptoaddress := reccust.Address + ' ,' + reccust."Address 2" + ' ,' + reccust.City + ' ,' + reccust."Post Code" + ' ,' + reccust."State Code" + ' ,' + reccust."Country/Region Code";
                    ShiptoGST := reccust."GST Registration No.";
                    ShipToPAN := CopyStr(reccust."GST Registration No.", 3, 10);
                    ShipToCIN := recloc.CIN;
                    ShipToCode := reccust."No.";
                    ShipToName := reccust.Name;
                end;

                if PurchaseHeader."Ship To" = 'Default (Company Address)' then begin
                    shiptoaddress := reccompinfo.Address + ' ,' + reccompinfo."Address 2" + ' ,' + reccompinfo.City + ' ,' + reccompinfo."Post Code" + ' ,' + reccompinfo."State Code" + ' ,' + reccompinfo."Country/Region Code";
                    ShiptoGST := reccompinfo."GST Registration No.";
                    ShipToPAN := CopyStr(reccompinfo."GST Registration No.", 3, 10);
                    ShipToCIN := reccompinfo.CIN;
                    ShipToName := reccompinfo.Name;
                end;

                if Customer_G.Get("Sales Cr.Memo Header"."Sell-to Customer No.") then
                    ShiptoGST2 := Customer_G."GST Registration No.";

                Clear(exportdeclaration);
                if "Sales Cr.Memo Header"."Currency Code" <> '' then
                    exportdeclaration := true
                else
                    exportdeclaration := false;

                AmtInWordsG.InitTextVariable();
                AmtInWordsG.FormatNoText(NoText, GetDocumentAmount("Sales Cr.Memo Header"), INRorUSDorEURO);

                //GenerateQRCode("Sales Invoice Header");

                //....Banks Details.......++
                if "Sales Cr.Memo Header"."Currency Code" = '' then begin
                    BankAccounts.Get('B010');
                    BankAcc[1] := 'ICICI Bank Ltd.';
                    BankAcc[2] := BankAccounts."Bank Branch No.";
                    BankAcc[3] := BankAccounts."Bank Account No.";
                    BankAcc[4] := BankAccounts."IFSC Code";
                    BankAcc[5] := BankAccounts."SWIFT Code";
                end;
                if "Sales Cr.Memo Header"."Currency Code" = 'EUR' then begin
                    BankAccounts.Get('B020');
                    BankAcc[1] := 'ICICI Bank Ltd.';
                    BankAcc[2] := BankAccounts."Bank Branch No.";
                    BankAcc[3] := BankAccounts."Bank Account No.";
                    BankAcc[4] := BankAccounts."IFSC Code";
                    BankAcc[5] := BankAccounts."SWIFT Code";
                end;
                if "Sales Cr.Memo Header"."Currency Code" = 'USD' then begin
                    BankAccounts.Get('B030');
                    BankAcc[1] := 'ICICI Bank Ltd.';
                    BankAcc[2] := BankAccounts."Bank Branch No.";
                    BankAcc[3] := BankAccounts."Bank Account No.";
                    BankAcc[4] := BankAccounts."IFSC Code";
                    BankAcc[5] := BankAccounts."SWIFT Code";
                end;
                if "Sales Cr.Memo Header"."Currency Code" = 'GBP' then begin
                    BankAccounts.Get('B040');
                    BankAcc[1] := 'ICICI Bank Ltd.';
                    BankAcc[2] := BankAccounts."Bank Branch No.";
                    BankAcc[3] := BankAccounts."Bank Account No.";
                    BankAcc[4] := BankAccounts."IFSC Code";
                    BankAcc[5] := BankAccounts."SWIFT Code";
                end;
                //....Bank Details........--

                // if TDSNoteBoolean then
                //     TDSNote := TDSNoteLabel
                // else
                //     TDSNote := '';

                if RecCustomer.Get("Sales Cr.Memo Header"."Sell-to Customer No.") then begin
                    if TDSNoteBoolean then
                        TDSNote := RecCustomer."TDS Note"
                    else
                        TDSNote := '';
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(TDSNoteBoolean; TDSNoteBoolean)
                    {
                        Caption = 'Print TDS Note';
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }
    rendering
    {
        layout("QBA Posted Sales Credit Memo")
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/QBA Posted Sales Credit Memo.rdl';
        }
    }
    var
        AmtInWordsG: Codeunit "Amount In Words";
        exportdeclaration: Boolean;
        State_G: Record State;
        cStateneme: text;
        CountryRegion_G: record "Country/Region";
        ccountryname: text;
        AppliedAmount: Decimal;
        CustLedgerEntry_G: Record "Cust. Ledger Entry";
        Customer_G: Record Customer;
        ShiptoGST2: code[20];
        ShipToCIN: text[30];
        locstatecode: code[10];
        ShipToCode: code[20];
        ShipToPAN: Code[10];
        ShiptoGST: Code[20];
        shiptoaddress: Text[200];
        PurchaseHeader: record 36;
        gsrper: Decimal;
        recloc: Record Location;
        reccust: Record 18;
        ShipToName: text[100];
        TotalTDSAmt: Decimal;
        custstate: code[15];
        INRorUSDorEURO: code[6];
        tdsTotal: Decimal;
        TotalCGSTAmount: Decimal;
        TotalIGSTAmt: Decimal;
        TotalSGSTAmt: Decimal;
        AmtVendorTotal: Decimal;
        NoText: array[2] of Text[80];
        ExceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';
        printDuplicate: Boolean;
        custACK: text[100];
        SlNo: Integer;
        custGST: code[20];
        TdsPer: Decimal;
        reccompinfo: Record "Company Information";
        recGST: Record "GST Ledger Entry";
        detailedGST: Record "Detailed GST Ledger Entry";
        reccustomer: Record Customer;
        custIRN: text[250];
        //TdsAmt: Decimal;
        //header: Text[30];

        GSTSetup: Record "GST Setup";
        GSTCESSLbl: Label 'GST CESS';
        GSTLbl: Label 'GST';
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        GSTComponentCodeName: array[10] of Code[20];
        TaxTrnasactionValue: Record "Tax Transaction Value";
        GenLedSetupG: Record "General Ledger Setup";
        TotSGSTAmt: Decimal;
        TotCGSTAmt: Decimal;
        TotIGSTAmt: Decimal;
        Total_Line_CGST_SGST_IGST: Decimal;
        Sum_Of_LineAmount: Decimal;
        Document_Amount: Decimal;
        CGSTPer: Decimal;
        CGSTAmt: Decimal;
        SGSTPer: Decimal;
        SGSTAmt: Decimal;
        IGSTPer: Decimal;
        IGSTAmt: Decimal;
        //QRCode: Text;
        TaxInvoiceLabel: Label 'Sales Credit Note';
        ExportInvoiceLabel: Label 'Export Invoice';
        ReportHeading: Text;
        BankAcc: array[8] of Text[50];
        BankAccounts: Record "Bank Account";
        TDSNoteLabel: Label 'Kindly Note TDS applicable will be @ 1.00% u/s 194J based on LDC Certificate';
        TDSNote: Text;
        TDSNoteBoolean: Boolean;


    local procedure GstComponent(Line: Record "Sales Cr.Memo Line")
    var
        DetGSTLedgEntry: Record "Detailed GST Ledger Entry";
        //Salesinvline: Record "Sales Invoice line";
        TotalAmountwithoutGST: Decimal;
    begin
        //ClearVariable();
        DetGSTLedgEntry.Reset();
        DetGSTLedgEntry.SetRange("Transaction Type", DetGSTLedgEntry."Transaction Type"::Sales);
        DetGSTLedgEntry.SetRange("Document Type", DetGSTLedgEntry."Document Type"::"Credit Memo");
        DetGSTLedgEntry.SetRange("Source Type", DetGSTLedgEntry."Source Type"::Customer);
        DetGSTLedgEntry.SetRange("Document No.", Line."Document No.");
        DetGSTLedgEntry.SetRange("Document Line No.", Line."Line No.");
        if DetGSTLedgEntry.FindSet() then begin
            repeat
                if DetGSTLedgEntry."GST Component Code" = 'IGST' then begin
                    IGSTAmt := ABS(DetGSTLedgEntry."GST Amount");
                    TotIGSTAmt += IGSTAmt;
                    IGSTPER := ABS(DetGSTLedgEntry."GST %");
                end;
                if DetGSTLedgEntry."GST Component Code" = 'CGST' then begin//
                    CGSTAmt := ABS(DetGSTLedgEntry."GST Amount");
                    TotCGSTAmt += CGSTAmt;
                    CGSTPER := ABS(DetGSTLedgEntry."GST %");
                end;
                if DetGSTLedgEntry."GST Component Code" = 'SGST' then begin
                    SGSTAmt := ABS(DetGSTLedgEntry."GST Amount");
                    TotSGSTAmt += SGSTAmt;
                    SGSTPER := ABS(DetGSTLedgEntry."GST %");
                end;
            until DetGSTLedgEntry.Next() = 0;
        end;

        Total_Line_CGST_SGST_IGST := TotSGSTAmt + TotCGSTAmt + TotIGSTAmt;

        //Sum_Of_LineAmount := Sum_Of_LineAmount + GetGSTAmountsSalesLine."Line Amount";
        Document_Amount := Sum_Of_LineAmount + Total_Line_CGST_SGST_IGST;
    end;

    local procedure GetDocumentAmount(SIH_P: Record "Sales Cr.Memo Header"): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        TempAmt: Decimal;
    begin
        Clear(TempAmt);
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
        CustLedgEntry.SetRange("Document No.", SIH_P."No.");
        CustLedgEntry.SetRange("Customer No.", SIH_P."Sell-to Customer No.");
        if CustLedgEntry.FindFirst() then begin
            CustLedgEntry.CalcFields(Amount);
            TempAmt := Abs(CustLedgEntry.Amount);
        end;
        exit(TempAmt);
    end;
}
