report 50028 "QBA Proforma Invoice"
{
    ApplicationArea = All;
    Caption = 'QBA Proforma Invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
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
            column(caddress; (reccompinfo.Address + ', ' + reccompinfo."Address 2" + ', ' + reccompinfo."Post Code" + ', ' + reccompinfo.City + ', ' + cStateneme + ' ,' + ccountryname)) { }
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
            column(QuoteNo; "Quote No.") { }
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
            dataitem("Sales Line"; "Sales Line")
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
                trigger OnPreDataItem()// Line
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord()// Line
                begin

                    SlNo += 1;
                    GSTSetup.Get();
                    //GetGSTCaptions(TaxTrnasactionValue, "Sales Line", GSTSetup);
                    GetGSTAmounts(TaxTrnasactionValue, "Sales Line", GSTSetup);

                    AmtInWordsG.InitTextVariable();
                    AmtInWordsG.FormatNoText(NoText, Document_Amount, INRorUSDorEURO);

                end;
            }
            trigger OnPreDataItem()// Header
            begin
                reccompinfo.get;
                reccompinfo.CalcFields(Picture2);
                Clear(printDuplicate);
            end;

            trigger OnAfterGetRecord()// Header
            begin

                clear(AppliedAmount);
                CustLedgerEntry_G.Reset();
                CustLedgerEntry_G.SetRange("Document No.", "Sales Header"."Applies-to Doc. No.");
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
                if "Sales Header"."Currency Code" = '' then
                    INRorUSDorEURO := 'INR'
                else if "Sales Header"."Currency Code" = 'USD' then
                    INRorUSDorEURO := 'USD'
                else if "Sales Header"."Currency Code" = 'EURO' then INRorUSDorEURO := 'EURO';
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
                    reccust.get("Sales Header"."Sell-to Customer No.");
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

                if Customer_G.Get("Sales Header"."Sell-to Customer No.") then
                    ShiptoGST2 := Customer_G."GST Registration No.";

                Clear(exportdeclaration);
                if "Sales Header"."Currency Code" <> '' then
                    exportdeclaration := true
                else
                    exportdeclaration := false;
            end;
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/QBA Proforma Invoice.rdl';
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


    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
          GetGSTAmountsSalesLine: Record "Sales Line";
          GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName(GetGSTAmountsSalesLine, GSTSetup);
        if (GetGSTAmountsSalesLine.Type <> GetGSTAmountsSalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", GetGSTAmountsSalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                TotSGSTAmt += SGSTAmt;
                                SGSTPER := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                TotCGSTAmt += CGSTAmt;
                                CGSTPER := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                TotIGSTAmt += IGSTAmt;
                                IGSTPER := TaxTransactionValue.Percent;
                            end;

                    end;
                    Total_Line_CGST_SGST_IGST := TotSGSTAmt + TotCGSTAmt + TotIGSTAmt;
                until TaxTransactionValue.Next() = 0;

            Sum_Of_LineAmount := Sum_Of_LineAmount + GetGSTAmountsSalesLine."Line Amount";
            Document_Amount := Sum_Of_LineAmount + Total_Line_CGST_SGST_IGST;

        end;
    end;

    local procedure GetComponentName(GetComponentSalesLineRec: Record "Sales Line";
               GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if GetComponentSalesLineRec."GST Jurisdiction Type" = GetComponentSalesLineRec."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    local procedure GetGSTCaptions(TaxTransactionValue: Record "Tax Transaction Value";
        GetGSTCaptionsSalesLine: Record "Sales Line";
        GSTSetup: Record "GST Setup")
    begin
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", GetGSTCaptionsSalesLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    6:
                        GSTComponentCodeName[6] := SGSTLbl;
                    2:
                        GSTComponentCodeName[2] := CGSTLbl;
                    3:
                        GSTComponentCodeName[3] := IGSTLbl;
                end;
            until TaxTransactionValue.Next() = 0;
    end;

    // Shoha

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then exit;
        GSTSetup.TestField("GST Tax Type");
        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;


    // shobha

    // local procedure GetTotalGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
    // SalesLine: Record "Sales Line";
    // GSTSetup: Record "GST Setup"): Decimal
    // var
    //     ComponentName: Code[30];
    // begin
    //     SGSTAmt := 0;
    //     CGSTAmt := 0;
    //     IGSTAmt := 0;
    //     SGSTPer := 0;
    //     CGSTPer := 0;
    //     IGSTPer := 0;
    //     ComponentName := GetComponentName(SalesLine, GSTSetup);
    //     if (SalesLine.Type <> SalesLine.Type::" ") then begin
    //         TaxTransactionValue.Reset();
    //         TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
    //         TaxTransactionValue.SetRange("Tax Type", 'GST');
    //         TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
    //         TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
    //         if TaxTransactionValue.FindSet() then
    //             repeat
    //                 case TaxTransactionValue."Value ID" of
    //                     6:
    //                         begin
    //                             SGSTAmt := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision('SGST'));
    //                             // SGSTPer := Round(TaxTransactionValue.Percent, GetGSTRoundingPrecision('SGST'));
    //                             TotSGSTAmt += SGSTAmt;
    //                         end;
    //                     2:
    //                         begin
    //                             CGSTAmt := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision('CGST'));
    //                             // CGSTPer := Round(TaxTransactionValue.Percent, GetGSTRoundingPrecision('CGST'));
    //                             TotCGSTAmt += CGSTAmt;
    //                         end;
    //                     3:
    //                         begin
    //                             IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision('IGST'));
    //                             //  IGSTPer := Round(TaxTransactionValue.Percent, GetGSTRoundingPrecision('IGST'));
    //                             TotIGSTAmt += IGSTAmt;
    //                         end;
    //                 end;
    //             until TaxTransactionValue.Next() = 0;
    //     end;
    //     exit(SGSTAmt + CGSTAmt + IGSTAmt)
    // end;



}
