report 50027 "QBA Purchase Order"
{
    ApplicationArea = All;
    Caption = 'QBA Purchase Order';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;//

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(INRorUSDorEURO; INRorUSDorEURO) { }
            column(CIN; CompanyInfo.CIN) { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Posting_Date; format("Purchase Header"."Order Date")) { }
            column(ShipToCode; ShipToCode) { }
            column(ShipToName; ShipToName) { }
            column(shiptoaddress; shiptoaddress) { }
            column(ShiptoGST; ShiptoGST) { }
            column(ShipToPAN; ShipToPAN) { }
            column(ShipToCIN; ShipToCIN) { }
            column(vGST; vGST) { }
            column(Vpan; Vpan) { }
            column(CommentLine1; CommentLine[1]) { }
            column(CommentLine2; CommentLine[2]) { }
            column(CommentLine3; CommentLine[3]) { }
            column(CommentLine4; CommentLine[4]) { }
            column(CommentLine5; CommentLine[5]) { }
            column(CommentLine6; CommentLine[6]) { }
            column(Terms_Conditions; Terms_Conditions) { }
            column(VendorMSMENo; VendorMSMENo) { }
            column(LocationMSMENo; LocationMSMENo) { }
            column(VendorPhNo; VendorPhNo) { }
            column(VendorEmail; VendorEmail) { }
            column(LocationPhNo; LocationPhNo) { }
            column(LocationEmail; LocationEmail) { }
            column(SignatureBoolean; SignatureBoolean) { }
            column(Signature_1; TenantMedia_G.Content) { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Requested_Receipt_Date; "Requested Receipt Date") { }
            column(Promised_Receipt_Date; "Promised Receipt Date") { }
            column(TermsAndConditionsTxt; TermsAndConditionsTxt) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("no.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                column(Type; Type) { }//
                column(itemNo_; "No.") { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(cgst_amt; "Purchase Line"."cgst amt") { }
                column(igstamt2; igstamt2) { }
                column(SlNo; SlNo) { }
                column(vendorName; vendorName) { }
                column(Vaddress; Vaddress) { }
                column(Description; Description + ' ' + "Description 2") { }
                column(Quantity; Quantity) { DecimalPlaces = 0 : 5; }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(UnitPrice; "Purchase Line"."Unit Cost") { }
                column(Line_Amount; "Line Amount") { }
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
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    if "Purchase Line".Type <> "Purchase Line".Type::" " then
                        SlNo := SlNo + 1;

                    GSTSetup.Get();
                    GetGSTCaptions(TaxTrnasactionValue, "Purchase Line", GSTSetup);
                    GetGSTAmounts(TaxTrnasactionValue, "Purchase Line", GSTSetup);

                    AmtInWordsG.InitTextVariable();
                    AmtInWordsG.FormatNoText(NoText, Document_Amount, INRorUSDorEURO);
                end;
            }
            trigger OnPreDataItem() // Header
            begin
                //TextBuilder();
                if UserSetup_G.Get(UserId) then
                    if UserSetup_G.Signature_MediaSet.Count > 0 then begin
                        TenantMedia_G.Get(UserSetup_G.Signature_MediaSet.Item(1));
                        TenantMedia_G.CalcFields(Content);
                        SignatureBoolean := true;
                    end else
                        SignatureBoolean := false;

                CompanyInfo.get;
                CompanyInfo.CalcFields(Picture);
                CompanyInfo.CalcFields(Picture2);
                visibility := '';
            end;

            trigger OnAfterGetRecord() // Header
            begin
                // TermsAndConditionsTxt := TnCBuilder.ToText();
                // TermsAndConditionsTxt := TermsAndConditionsTxt.Replace('{{FROM_DATE}}', Format("Requested Receipt Date", 0, '<Day,2>-<Month Text,3>-<Year4>'));
                // TermsAndConditionsTxt := TermsAndConditionsTxt.Replace('{{TO_DATE}}', Format("Promised Receipt Date", 0, '<Day,2>-<Month Text,3>-<Year4>'));
                // TermsAndConditionsTxt := TermsAndConditionsTxt.Replace('{{Terms}}', "Payment Terms Code");

                if Vendor_G.Get("Buy-from Vendor No.") then begin
                    vendorName := Vendor_G.Name;
                    vemail := Vendor_G."E-Mail";
                    vGST := Vendor_G."GST Registration No.";
                    Vpan := Vendor_G."P.A.N. No.";
                    vpostcode := Vendor_G."Post Code";
                    vstatecode := Vendor_G."State Code";
                    if RecState.get(vstatecode) then
                        statename := RecState.Description;
                    vendCountry := Vendor_G."Country/Region Code";
                    if CountryRegion_G.Get(vendCountry) then
                        vcountry := CountryRegion_G.Name;
                    Vaddress := Vendor_G.Address + ', ' + Vendor_G."Address 2" + ', ' + statename + ', ' + vcountry + ', ' + vpostcode;
                    VendorMSMENo := Vendor_G."MSME No.";
                    VendorPhNo := Vendor_G."Phone No.";
                    VendorEmail := Vendor_G."E-Mail";
                end;


                if Location_G.Get("Purchase Header"."Location Code") then begin
                    locGST := Location_G."GST Registration No.";
                    locpan := CopyStr(Location_G."GST Registration No.", 3, 10);
                    locCIN := Location_G.cin;
                    locstatecode := Location_G."State Code";
                    LocationPhNo := Location_G."Phone No.";
                    LocationEmail := Location_G."E-Mail";
                    LocationMSMENo := Location_G."MSME No.";
                end;

                if "Purchase Header"."Ship To" = 'Location' then begin
                    ShiptoGST := Location_G."GST Registration No.";
                    ShipToPAN := CopyStr(Location_G."GST Registration No.", 3, 10);
                    ShipToCIN := Location_G.CIN;
                    ShipToCode := Location_G.Code;
                    ShipToName := Location_G.Name;
                    if State_G.Get(Location_G."State Code") then
                        LocState := State_G.Description;
                    if CountryRegion_G.Get(Location_G."Country/Region Code") then
                        loccountry := CountryRegion_G.Name;
                    shiptoaddress := Location_G.Address + ' ,' + Location_G."Address 2" + ' ,' + Location_G.City + ' ,' + Location_G."Post Code" + ' ,' + LocState + ' ,' + loccountry;
                end;

                if "Purchase Header"."Ship To" = 'Customer Address' then begin
                    reccust.Get("Purchase Header"."Sell-to Customer No.");
                    ShiptoGST := reccust."GST Registration No.";
                    ShipToPAN := CopyStr(reccust."GST Registration No.", 3, 10);
                    ShipToCIN := Location_G.CIN;
                    ShipToCode := reccust."No.";
                    ShipToName := reccust.Name;
                    shiptoaddress := reccust.Address + ' ,' + reccust."Address 2" + ' ,' + reccust.City + ' ,' + reccust."Post Code" + ' ,' + reccust."State Code" + ' ,' + reccust."Country/Region Code";
                end;

                if "Purchase Header"."Ship To" = 'Default (Company Address)' then begin
                    ShiptoGST := CompanyInfo."GST Registration No.";
                    ShipToPAN := CopyStr(CompanyInfo."GST Registration No.", 3, 10);
                    ShipToCIN := CompanyInfo.CIN;
                    ShipToName := CompanyInfo.Name;
                    if reccompstate.get(CompanyInfo."State Code") then compstate := reccompstate.Description;
                    if CountryRegion_G.Get(CompanyInfo."Country/Region Code") then
                        compcountry := CountryRegion_G.Name;
                    shiptoaddress := CompanyInfo.Address + ' ,' + CompanyInfo."Address 2" + ' ,' + CompanyInfo.City + ' ,' + CompanyInfo."Post Code" + ' ,' + compstate + ' ,' + compcountry;
                end;

                // >> 003 
                GenLedSetupG.Get();
                if "Purchase Header"."Currency Code" = '' then
                    INRorUSDorEURO := GenLedSetupG."LCY Code"
                else
                    INRorUSDorEURO := "Purchase Header"."Currency Code";
                // << 003

                //"Purchase Header".CalcFields(Amount);

                //Amount In Word.....++
                //AmtInWords.InitTextVariable();
                //AmtInWords.FormatNoText(NoText, Abs(PurchaseHeader.Amount + (TotCGSTAmt + TotSGSTAmt + TotIGSTAmt)), PurchaseHeader."Currency Code");
                //Amount In Word.....--
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    Caption = 'Filter : Purchase Order';
                    field(Terms_Conditions; Terms_Conditions)
                    {
                        ApplicationArea = all;
                    }
                }

            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/QBA Purchase Order.rdl';
        }
    }
    var
        SignatureBoolean: Boolean;
        LocationPhNo: Text[30];
        LocationEmail: Text[80];
        VendorPhNo: Text[30];
        VendorEmail: Text[80];
        VendorMSMENo: Code[20];
        LocationMSMENo: Code[20];
        Terms_Conditions: Boolean;
        CheckReport: Report Check;
        hidevalue2: Boolean;
        cstate: Record state;
        //ccountry: Record "Country/Region";
        cstatename: text;
        ccountryname: text;
        reccompstate: Record state;
        CountryRegion_G: Record "Country/Region";
        compstate: text;
        compcountry: text;
        State_G: Record state;
        //recloccountry: Record "Country/Region";
        locstatename: text;
        loccountry: text;
        //reccountry: Record "Country/Region";
        vcountry: text;
        statename: text;
        TotalSGSTAmt2: decimal;
        TotalIGSTAmt2: decimal;
        TotalCGSTAmount2: decimal;
        AmtVendorTotal2: decimal;
        visibility: text;
        //PurchaseLine4: Record 39;
        //PurchaseLine2: Record 39;
        vendCountry: text[20];
        IGSTPer2: Decimal;
        cgstper2: Decimal;
        sgstper2: Decimal;
        igstamt2: Decimal;
        cgstamt2: Decimal;
        sgstamt2: Decimal;
        ShipToCode: code[20];
        ShipToName: text[150];
        ShiptoGST: code[20];
        ShipToPAN: code[15];
        ShipToCIN: text[30];
        PurOrder: page 50;
        shiptoaddress: text[200];
        vstatecode: code[5];
        locstatecode: Code[15];
        locCIN: Code[30];
        LineComments: array[10] of text[100];
        recpurchasecomment: Record "Purch. Comment Line";
        INRorUSDorEURO: code[5];
        vpostcode: code[10];
        //gsrper: Decimal;
        NoText: array[2] of Text[500];
        AmtInWordsG: Codeunit "Amount In Words";
        locGST: Code[20];
        locpan: code[15];
        reccust: Record 18;
        Location_G: Record Location;
        vGST: code[20];
        Vpan: code[10];
        vendorName: text[100];
        Vaddress: text[200];
        vemail: Text[100];
        SlNo: Integer;
        Vendor_G: Record Vendor;
        CompanyInfo: Record "Company Information";
        //compname: text[100];
        //compaddress1: text[100];
        //compaddress2: text[100];
        //compcity: text[30];
        //compemail: text[100];
        //compphone: code[20];
        //compGST: code[20];
        //compPAN: code[10];
        //recGST: Record "GST Ledger Entry";
        //recHSN: Record "HSN/SAC";
        //comment: Record "Sales Comment Line";
        //comment2: text;
        //purchaseLine6: Record 39;
        //RecID: RecordID;
        //TotalCGSTAmount: Decimal;
        //AmtVendorTotal: Decimal;
        //TotalSGSTAmt: Decimal;
        //TotalIGSTAmt: Decimal;
        //TermDesc: text[150];
        //Sub55: Text[500];
        //test: Record "Tax Transaction Value";
        //test2: BigText;
        //blobcomment2: text[500];
        //recPurHeader9: Record "Purchase Header";
        //recpurline9: Record "Purchase Line";
        //PurCommentLine: Record 43;
        //Subject: Text[500];
        //reportcheck: Report Check;
        //blobcomment: text;
        //GrandTotal: Decimal;
        //RecVLE: Record "Vendor Ledger Entry";
        //GSTPerVar: Decimal;
        //Vendor: Record Vendor;
        //Qty: Decimal;
        UnitPrice: Decimal;
        Salesperson: Record "Salesperson/Purchaser";
        SalespersonText: Text[50];
        Amount_: Decimal;
        recpurchaseLine: Record 39;
        ctr: Integer;
        TaxTransactionvalue: Record "Tax Transaction Value";
        CompInfo: Record "Company Information";
        DimensionSetEntry: Record "Dimension Set Entry";
        DimCode: Code[20];
        PurchCommentLine: Record "Purch. Comment Line";
        ArchiveDate: Date;
        QuoteDate: Date;
        Comments: Text;
        PurchHeaderArchive: Record "Purchase Header Archive";
        PurchHeaderArchive2: Record "Purchase Header Archive";
        TransMethod: Record "Transport Method";
        ShippingMethod: Record "Shipment Method";
        CountryRegionN: Text;
        CountryName: Record "Country/Region";
        Freight: Code[20];
        ModeOfTransport: Text[100];
        SrNo: Integer;
        PrevVend: Code[20];
        TaxableAmt: Decimal;
        State: Record State;
        RecState: Record State;
        DocDate: Text[10];
        RecItem: Record Item;
        SrNo1: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        DisAmt: Decimal;
        CGSTPer: Decimal;
        CGSTAmt: Decimal;
        SGSTPer: Decimal;
        SGSTAmt: Decimal;
        IGSTPer: Decimal;
        IGSTAmt: Decimal;
        //Totalfin: Decimal;
        //TotalTotNoOfPkgs: Decimal;
        //TotalQty: Decimal;
        //TotalLineAmt: Decimal;
        //TotalExciseAmt: Decimal;
        //TotalAmtToCustomer: Decimal;
        //ChargesAmount: Decimal;
        //OtherTaxesAmount: Decimal;
        //paydesc: Text[58];
        //paymentmethod: Record "Payment Method";
        //TotalAmtToCustomerInvrounding: Decimal;
        //AmountToVendor_PL: Decimal;
        //purpose: Text[50];
        //Department: Text[50];
        //GenjnlNartn: Text;
        //GenjnlNartn1: Text;
        //GenjnlNartn2: Text;
        //Location: Record Location;
        LocState: Text[50];
        //Currency: Text[10];
        //grade: Text[10];
        //VenStateDesc: Text;
        //PaymentTerms: Record "Payment Terms";
        //gcjs: Page "Purchase Order";
        //TdsAmt: Decimal;
        //TdsPer: Decimal;
        //TotalTDSAmt: Decimal;
        //PurchLine: Record "Sales Line";
        //PurchaeHeaderRec: Record "Purchase Header";
        //OnesText: array[20] of Text[30];
        //TensText: array[10] of Text[30];
        //ExponentText: array[5] of Text[30];
        //NoTextAmt: ARRAY[2] OF Text[80];
        //hidevalue: Boolean;
        CommentLine: array[10] of Text[200];
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
        UserSetup_G: Record "User Setup";
        TenantMedia_G: Record "Tenant Media";
        TnCBuilder: TextBuilder;
        TermsAndConditionsTxt: Text;

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
          PurchaseLine: Record "Purchase Line";
          GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
        GSTPurchaseInvoice: Report "Purchase - Invoice GST";
    begin
        ComponentName := GetComponentName(PurchaseLine, GSTSetup);
        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
                                TotSGSTAmt += SGSTAmt;
                                SGSTPER := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
                                TotCGSTAmt += CGSTAmt;
                                CGSTPER := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
                                TotIGSTAmt += IGSTAmt;
                                IGSTPER := TaxTransactionValue.Percent;
                            end;

                    end;
                    Total_Line_CGST_SGST_IGST := TotSGSTAmt + TotCGSTAmt + TotIGSTAmt;
                until TaxTransactionValue.Next() = 0;

            Sum_Of_LineAmount := Sum_Of_LineAmount + PurchaseLine."Line Amount";
            Document_Amount := Sum_Of_LineAmount + Total_Line_CGST_SGST_IGST;

        end;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
               GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    local procedure GetGSTCaptions(TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup")
    begin
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
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

    // local procedure TextBuilder()
    // var
    //     Bullet: Text[1];
    //     BulletD: Text[1];
    // begin
    //     Bullet := '➣';
    //     TnCBuilder.AppendLine('                                                                                                         Terms & Conditions');
    //     TnCBuilder.AppendLine('');
    //     TnCBuilder.AppendLine(Bullet + ' Only Written orders are deemed to be valid. Verbal agreements must be confirmed in writing. In all cases, we expect a written Confirmation');
    //     TnCBuilder.AppendLine('    of the order.');
    //     TnCBuilder.AppendLine('');
    //     TnCBuilder.AppendLine('➣  The purchaser reserves the right to amend at any time part / full purchase order. The Subsequent amended purchase order will be the agreed');
    //     TnCBuilder.AppendLine('    document between supplier and purchaser.');
    //     TnCBuilder.AppendLine('➣  The Purchase order shall remain in effect for the period {{FROM_DATE}} to {{TO_DATE}}.');
    //     TnCBuilder.AppendLine('➣  Unless otherwise agreed, the prices are deemed to be door delivery to Quantum Business Advisory Private Limited at DN 52, P S Srijan');
    //     TnCBuilder.AppendLine('    Tech Park, 5th Floor, Salt Lake, Sector V, Kolkata – 700091.');
    //     TnCBuilder.AppendLine('➣  In case of Input Tax Credit loss due to not filling of correct GST returns in time by supplier/ service provider, Quantum Business Advisory');
    //     TnCBuilder.AppendLine('    Private Limited shall debit the tax amount and interest to Supplier/Service provider.');
    //     TnCBuilder.AppendLine('➣  Payment shall be made as per agreed terms i.e. {{Terms}} days from the date of receiving of approved / correct invoice.');
    //     TnCBuilder.AppendLine('➣  The terms for payment commence on the date of receipt of the approved/correct invoice.');
    //     TnCBuilder.AppendLine('➣  The supplier should not use the name, logo and abbreviations of Quantum Business Advisory Private Limited for advertising purposes');
    //     TnCBuilder.AppendLine('    without our prior consent.');
    //     TnCBuilder.AppendLine('➣  Invoice must be supported with proof of materials/ service delivered from the respective manager.');
    //     TnCBuilder.AppendLine('➣  The material should be delivered within X days from the date of Purchase Order.');
    //     TnCBuilder.AppendLine('➣  Statutory Liability to be borne by the seller as per the rules.');
    //     TnCBuilder.AppendLine('➣  Taxes as applicable will be deducted at the time of payment.');
    //     TnCBuilder.AppendLine('➣  Invoices to be submitted to invoice.payable@qbadvisory.com. This also implies to the vendors submitting the invoices in the form of Hard');
    //     TnCBuilder.AppendLine('    Copy.');
    //     TnCBuilder.AppendLine('➣  Suppliers must have insurance to safeguard any claim to the buyer in terms of monetary and material.');
    //     TnCBuilder.AppendLine('➣  Invoice to be submitted Within 5 days from date of receipt of material or approval of service from respective manager.');
    //     TnCBuilder.AppendLine('➣  Warranty: Warranty for all above products shall be governed by the policies of the respective OEMs or by their authorized service center.');
    //     TnCBuilder.AppendLine('➣  PO value is based on estimation. The invoice will be issued based on the actual Goods / Services supply.');
    //     TnCBuilder.AppendLine('');
    //     TnCBuilder.AppendLine('➣  Supporting Documents to be provided: -');
    //     TnCBuilder.AppendLine('                 o  Delivery Confirmation');
    //     TnCBuilder.AppendLine('                 o  PF paid challan and ECR');
    //     TnCBuilder.AppendLine('                 o  ESIC Paid Challan');
    //     TnCBuilder.AppendLine('                 o  Professional Tax Paid Challan');
    //     TnCBuilder.AppendLine('                 o  Labour Welfare Fund');
    //     TnCBuilder.AppendLine('');
    //     TnCBuilder.AppendLine('➤  Points to be mandatary mentioned in the invoice: -');
    //     TnCBuilder.AppendLine('');
    //     TnCBuilder.AppendLine('   SL. NO.                                    BUYER                                                                                                  SELLER');
    //     TnCBuilder.AppendLine('   -------------------------------------------------------------------------------------------------------------------------------------------------');
    //     TnCBuilder.AppendLine('     01.                   Trade Name & Address as per GST Certificate                                 Good & Service Tax Number      ');
    //     TnCBuilder.AppendLine('     02.                   Purchase Order Number & Date                                                       MSME Number (If Applicable)    ');
    //     TnCBuilder.AppendLine('     03.                   Goods & Service Tax Number                                                           Letter of Undertaking Number (If Applicable)');
    //     TnCBuilder.AppendLine('     04.                   UOM, Unit & Rate                                                                             Import and Export Code (If Applicable)');
    //     TnCBuilder.AppendLine('     05.                   Payment Terms                                                                                 Permanent Account Number');
    //     TnCBuilder.AppendLine('     06.                   Name of Resource along with period of Service                                                                            ');
    //     TnCBuilder.AppendLine('                             material description in case of supply of material                            Bank Details                   ');
    //     TnCBuilder.AppendLine('     07.                   Cost Centre as mentioned in the Purchase Order                            Company Registration Number    ');
    //     TnCBuilder.AppendLine('     08.                   Permanent Account Number                                                            Contact Information            ');
    //     TnCBuilder.AppendLine('     09.                   Company Registration Number                                                                                              ');
    // end;
}
