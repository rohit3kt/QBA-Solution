report 50021 "Purchase report Archive"
{
    ApplicationArea = All;
    Caption = 'Purchase Order Archive';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(PurchaseHeader; 5109)
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            {
            }
            column(reccompinfo; reccompinfo.Picture)
            {
            }
            column(INRorUSDorEURO; INRorUSDorEURO)
            {
            }
            column(CIN; reccompinfo.CIN)
            {
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }
            column(Posting_Date; format(PurchaseHeader."Posting Date"))
            {
            }
            column(ShipToCode; ShipToCode)
            {
            }
            column(ShipToName; ShipToName)
            {
            }
            column(shiptoaddress; shiptoaddress)
            {
            }
            column(ShiptoGST; ShiptoGST)
            {
            }
            column(ShipToPAN; ShipToPAN)
            {
            }
            column(ShipToCIN; ShipToCIN)
            {
            }
            column(vGST; vGST)
            {
            }
            column(Vpan; Vpan)
            {
            }
            column(hidevalue; hidevalue)
            {
            }
            column(hidevalue2; hidevalue2)
            {
            }
            column(CommentLine1; CommentLine[1])
            {
            }
            column(CommentLine2; CommentLine[2])
            {
            }
            column(CommentLine3; CommentLine[3])
            {
            }
            column(CommentLine4; CommentLine[4])
            {
            }
            column(CommentLine5; CommentLine[5])
            {
            }
            column(CommentLine6; CommentLine[6])
            {
            }
            dataitem(PurchaseLine; 5110)
            {
                DataItemLink = "Document No." = field("no.");
                RequestFilterFields = "Document No.";

                column(itemNo_; "No.")
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(cgst_amt; PurchaseLine."cgst amt")
                {
                } //"cgst amt"//CGSTAmt2
                column(IGST_Amt; PurchaseLine."IGST Amt")
                {
                }
                column(IGST_per; PurchaseLine."IGST per")
                {
                }
                column(CGST_per; PurchaseLine."CGST per")
                {
                }
                column(igstamt2; igstamt2)
                {
                }
                column(SlNo; SlNo)
                {
                }
                column(amtinwords; NoText[1])
                {
                }
                column(vendorName; vendorName)
                {
                }
                column(Vaddress; Vaddress)
                {
                }
                column(Description; Description + ' ' + "Description 2")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(UnitPrice; PurchaseLine."Unit Cost")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(gsrper; gsrper)
                {
                }
                column(CGSTPer; CGSTPer)
                {
                }
                column(SGSTPer; SGSTPer)
                {
                }
                column(IGSTPer; IGSTPer)
                {
                }
                column(TdsPer; TdsPer)
                {
                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(tdsTotal; tdsTotal)
                {
                }
                column(IGSTAmt; IGSTAmt)
                {
                }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                    reccompinfo.get;
                    reccompinfo.CalcFields(Picture2);
                    reccompinfo.CalcFields(Picture);
                    // ///////////////////
                    PurchaseLine4.Reset();
                    PurchaseLine4.SetRange("Document No.", PurchaseHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    If PurchaseLine4.Findset() then //begin
                        repeat
                            TotalSGSTAmt2 := 0;
                            TotalIGSTAmt2 := 0;
                            TotalCGSTAmount2 := 0;
                            AmtVendorTotal2 := 0;
                            Clear(CGSTAmt2);
                            Clear(SGSTAmt2);
                            Clear(IGSTAmt2);
                            clear(IGSTPer2);
                            clear(cgstper2);
                            GetGSTAmount2(PurchaseLine4.RecordId);
                            TotalCGSTAmount2 += CGSTAmt2;
                            TotalIGSTAmt2 += IGSTAmt2;
                            TotalSGSTAmt2 += SGSTAmt2;
                            //if PurchaseLine4."cgst amt" <> 0 then begin
                            PurchaseLine4."cgst amt" := CGSTAmt2;
                            PurchaseLine4."IGST Amt" := IGSTAmt2;
                            PurchaseLine4."IGST per" := IGSTPer2;
                            PurchaseLine4."CGST per" := cgstper2;
                            PurchaseLine4.modify(true);
                        until PurchaseLine4.Next() = 0;
                    ///////////////////////////////////////////////////////////
                end;

                trigger OnAfterGetRecord()
                begin
                    reccompinfo.get;
                    reccompinfo.CalcFields(Picture2);
                    reccompinfo.CalcFields(Picture);
                    SlNo := SlNo + 1;
                    PurchaseLine4.Reset();
                    PurchaseLine4.SetRange("Document No.", PurchaseHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    If PurchaseLine4.Findset() then //begin
                        repeat
                            TotalSGSTAmt2 := 0;
                            TotalIGSTAmt2 := 0;
                            TotalCGSTAmount2 := 0;
                            AmtVendorTotal2 := 0;
                            Clear(CGSTAmt2);
                            Clear(SGSTAmt2);
                            Clear(IGSTAmt2);
                            clear(IGSTPer2);
                            clear(cgstper2);
                            GetGSTAmount2(PurchaseLine4.RecordId);
                            TotalCGSTAmount2 += CGSTAmt2;
                            TotalIGSTAmt2 += IGSTAmt2;
                            TotalSGSTAmt2 += SGSTAmt2;
                            //if PurchaseLine4."cgst amt" <> 0 then begin
                            PurchaseLine4."cgst amt" := CGSTAmt2;
                            PurchaseLine4."IGST Amt" := IGSTAmt2;
                            PurchaseLine4."IGST per" := IGSTPer2;
                            PurchaseLine4."CGST per" := cgstper2;
                            PurchaseLine4.modify(true);
                        until PurchaseLine4.Next() = 0;
                    ///////////////////////////////////////////////////////////
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    PurchaseLine2.Reset();
                    PurchaseLine2.SetRange("Document No.", PurchaseHeader."No.");
                    If PurchaseLine2.FindSet() then
                        repeat
                            GetGSTAmount(PurchaseLine2.RecordId);
                            TotalCGSTAmount += CGSTAmt;
                            TotalIGSTAmt += IGSTAmt;
                            TotalSGSTAmt += SGSTAmt;
                        until PurchaseLine2.Next() = 0;
                    //
                    // if PurchaseHeader."Ship To" = 'Location' then begin
                    //     ShiptoGST := recloc."GST Registration No.";
                    //     ShipToPAN := CopyStr(recloc."GST Registration No.", 3, 10);
                    //     ShipToCIN := recloc.CIN;
                    //     ShipToCode := recloc.Code;
                    //     ShipToName := recloc.Name;
                    //     shiptoaddress := recloc.Address + ' ,' + recloc."Address 2" + ' ,' + recloc.City + ' ,' + recloc."Post Code" + ' ,' + locstate + ' ,' + loccountry;
                    // end else
                    //     if PurchaseHeader."Ship To" = 'Customer Address' then begin
                    //         reccust.get(PurchaseHeader."Sell-to Customer No.");
                    //         ShiptoGST := reccust."GST Registration No.";
                    //         ShipToPAN := CopyStr(reccust."GST Registration No.", 3, 10);
                    //         ShipToCIN := recloc.CIN;
                    //         ShipToCode := reccust."No.";
                    //         ShipToName := reccust.Name;
                    //         shiptoaddress := reccust.Address + ' ,' + reccust."Address 2" + ' ,' + reccust.City + ' ,' + reccust."Post Code" + ' ,' + reccust."State Code" + ' ,' + reccust."Country/Region Code";
                    //     end else
                    //         if PurchaseHeader."Ship To" = 'Default (Company Address)' then begin
                    //             ShiptoGST := reccompinfo."GST Registration No.";
                    //             ShipToPAN := CopyStr(reccompinfo."GST Registration No.", 3, 10);
                    //             ShipToCIN := reccompinfo.CIN;
                    //             ShipToName := reccompinfo.Name;
                    //             cstate.get(reccompinfo."State Code");
                    //             ccountry.get(reccompinfo."Country/Region Code");
                    //             cstatename := cstate.Description;
                    //             ccountryname := ccountry.Name;
                    //             shiptoaddress := reccompinfo.Address + ' ,' + reccompinfo."Address 2" + ' ,' + reccompinfo.City + ' ,' + reccompinfo."Post Code" + ' ,' + cstatename + ' ,' + ccountryname;
                    //         end else
                    //             if PurchaseHeader."Ship To" = 'Default (Company Address)' then begin
                    //                 if "Bill to-Location(POS)" <> '' then begin
                    //                 end;
                    //             end;
                end;
            }
            dataitem(PurchCommentLine2; "Purch. Comment Line")
            {
                DataItemLink = "No." = field("No."); //, "Line No." = field("Line No.");

                column(Comment; Comment)
                {
                }
                column(Line_No_2; "Line No.")
                {
                }
                column(No_comment; "No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // Comment2 += Comment;
                end;
            }
            trigger OnPreDataItem()
            begin
                reccompinfo.get;
                reccompinfo.CalcFields(Picture);
                reccompinfo.CalcFields(Picture2);
                visibility := '';
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(vendorName);
                Clear(Vaddress);
                Clear(vemail);
                Clear(vGST);
                Clear(Vpan);
                recvendor.Reset();
                recvendor.SetRange("No.", "Buy-from Vendor No.");
                if recvendor.FindFirst() then begin
                    vendorName := recvendor.Name;
                    vemail := recvendor."E-Mail";
                    vGST := recvendor."GST Registration No.";
                    Vpan := recvendor."P.A.N. No.";
                    vpostcode := recvendor."Post Code";
                    vstatecode := recvendor."State Code";
                    if RecState.get(vstatecode) then statename := RecState.Description;
                    vendCountry := recvendor."Country/Region Code";
                    if reccountry.get(vendCountry) then vcountry := reccountry.Name;
                    Vaddress := recvendor.Address + ', ' + recvendor."Address 2" + ', ' + /*+ vpostcode + ', ' +*/ statename + ', ' + vcountry + ', ' + vpostcode;
                end;
                //
                Clear(locGST);
                Clear(locpan);
                recloc.Reset();
                recloc.SetRange(Code, PurchaseHeader."Location Code");
                if recloc.FindFirst() then begin
                    locGST := recloc."GST Registration No.";
                    locpan := CopyStr(recloc."GST Registration No.", 3, 10);
                    locCIN := recloc.cin;
                    locstatecode := recloc."State Code";
                end;
                // if PurchaseHeader."Ship To" = 'Location' then begin
                //     ShiptoGST := recloc."GST Registration No.";
                //     ShipToPAN := CopyStr(recloc."GST Registration No.", 3, 10);
                //     ShipToCIN := recloc.CIN;
                //     ShipToCode := recloc.Code;
                //     ShipToName := recloc.Name;
                //     if reclocstate.get(recloc."State Code") then
                //         LocState := reclocstate.Description;
                //     if recloccountry.get(recloc."Country/Region Code") then
                //         loccountry := recloccountry.Name;
                //     shiptoaddress := recloc.Address + ' ,' + recloc."Address 2" + ' ,' + recloc.City + ' ,' + recloc."Post Code" + ' ,' + LocState + ' ,' + loccountry;
                // end else
                //     if PurchaseHeader."Ship To" = 'Customer Address' then begin
                //         reccust.get(PurchaseHeader."Sell-to Customer No.");
                //         ShiptoGST := reccust."GST Registration No.";
                //         ShipToPAN := CopyStr(reccust."GST Registration No.", 3, 10);
                //         ShipToCIN := recloc.CIN;
                //         ShipToCode := reccust."No.";
                //         ShipToName := reccust.Name;
                //         shiptoaddress := reccust.Address + ' ,' + reccust."Address 2" + ' ,' + reccust.City + ' ,' + reccust."Post Code" + ' ,' + reccust."State Code" + ' ,' + reccust."Country/Region Code";
                //     end else
                //         if PurchaseHeader."Ship To" = 'Default (Company Address)' then begin
                //             ShiptoGST := reccompinfo."GST Registration No.";
                //             ShipToPAN := CopyStr(reccompinfo."GST Registration No.", 3, 10);
                //             ShipToCIN := reccompinfo.CIN;
                //             ShipToName := reccompinfo.Name;
                //             /////
                //             if reccompstate.get(reccompinfo."State Code") then
                //                 compstate := reccompstate.Description;
                //             if reccompcountry.get(reccompinfo."Country/Region Code") then
                //                 compcountry := reccompcountry.Name;
                //             //////
                //             shiptoaddress := reccompinfo.Address + ' ,' + reccompinfo."Address 2" + ' ,' + reccompinfo.City + ' ,' + reccompinfo."Post Code" + ' ,' + compstate + ' ,' + compcountry;
                //         end else
                //             if PurchaseHeader."Ship To" = 'Default (Company Address)' then begin
                //                 if "Bill to-Location(POS)" <> '' then begin
                //                 end;
                //             end;
                ////////////////////////////////
                if SGSTAmt <> 0 then
                    gsrper := SGSTPer * 2
                else
                    gsrper := igstper;
                ////////////////////
                Clear(locGST);
                Clear(locpan);
                recloc.Reset();
                recloc.SetRange(Code, PurchaseHeader."Location Code");
                if recloc.FindFirst() then begin
                    locGST := recloc."GST Registration No.";
                    locpan := CopyStr(recloc."GST Registration No.", 3, 10);
                    locCIN := recloc.cin;
                    locstatecode := recloc."State Code";
                end;
                //tds
                Clear(TotalTDSAmt);
                purchaseLine6.Reset();
                purchaseLine6.SetRange(purchaseLine6."Document No.", PurchaseHeader."No.");
                if purchaseLine6.FindSet then
                    repeat
                        GetTDSAmount(purchaseLine6.RecordId);
                        tdsTotal += TotalTDSAmt;
                    Until purchaseLine6.Next() = 0;
                //for Amt in words
                // GrandTotal += TaxableAmt;// + Last(Fields!CGSTAmt.Value) + Last(Fields!IGSTAmt.Value) + Last(Fields!SGSTAmt.Value)
                TotalSGSTAmt := 0;
                TotalIGSTAmt := 0;
                TotalCGSTAmount := 0;
                AmtVendorTotal := 0;
                Clear(CGSTAmt);
                Clear(SGSTAmt);
                Clear(IGSTAmt);
                PurchaseLine2.Reset();
                PurchaseLine2.SetRange("Document No.", PurchaseHeader."No.");
                // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                If PurchaseLine2.FindSet() then
                    repeat //  begin
                        GetGSTAmount(PurchaseLine2.RecordId);
                        TotalCGSTAmount := CGSTAmt;
                        TotalIGSTAmt := IGSTAmt;
                        TotalSGSTAmt := SGSTAmt;
                        // AmtVendorTotal += ((CGSTAmt + SGSTAmt + IGSTAmt + PurchaseLine.Amount) - (PurchaseLine."Line Discount Amount") - (tdsTotal));//"Amount Including VAT"
                        AmtVendorTotal += ((TotalCGSTAmount + TotalIGSTAmt + TotalSGSTAmt) - (PurchaseLine2."Line Discount Amount") - (TotalTDSAmt)); //"Amount Including VAT"
                    until PurchaseLine2.Next() = 0;
                // AmtVendorTotal += ((TotalCGSTAmount + TotalIGSTAmt + TotalSGSTAmt + PurchaseLine."Line Amount") - (PurchaseLine."Line Discount Amount") - (tdsTotal));//"Amount Including VAT"
                // end;
                PurchaseHeader.CalcFields(Amount);
                InitTextVariable();
                // FormatNoText(NoText, Abs(AmtVendorTotal), PurchaseHeader."Currency Code");
                FormatNoText(NoText, Abs(PurchaseHeader.Amount + (CGSTAmt + IGSTAmt + SGSTAmt) - (tdsTotal)), PurchaseHeader."Currency Code");
                if PurchaseHeader."Currency Code" = '' then
                    INRorUSDorEURO := 'INR'
                else if PurchaseHeader."Currency Code" = 'USD' then
                    INRorUSDorEURO := 'USD'
                else if PurchaseHeader."Currency Code" = 'EURO' then
                    INRorUSDorEURO := 'EURO'
                else if PurchaseHeader."Currency Code" = 'GBP' then INRorUSDorEURO := 'GBP';
                if SGSTAmt <> 0 then
                    gsrper := SGSTPer * 2
                else
                    gsrper := igstper;
                ////////////////////
                hidevalue := HideShow(PurchaseHeader."No.");
                hidevalue2 := HideShow2(PurchaseHeader."No.");
                //////////////////////////////////////////////
                AddComment(PurchaseHeader."No.");
            end;
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/Purchase_Order_Archive.rdl';
        }
    }
    var
        hidevalue2: Boolean;
        cstate: Record state;
        // hidevalue: Boolean;
        ccountry: Record "Country/Region";
        cstatename: text;
        ccountryname: text;
        reccompstate: Record state;
        reccompcountry: Record "Country/Region";
        compstate: text;
        compcountry: text;
        reclocstate: Record state;
        recloccountry: Record "Country/Region";
        locstatename: text;
        loccountry: text;
        reccountry: Record "Country/Region";
        vcountry: text;
        statename: text;
        TotalSGSTAmt2: decimal;
        TotalIGSTAmt2: decimal;
        TotalCGSTAmount2: decimal;
        AmtVendorTotal2: decimal;
        visibility: text;
        PurchaseLine4: Record 5110;
        PurchaseLine2: Record 5110;
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
        gsrper: Decimal;
        NoText: array[2] of Text[80];
        locGST: Code[20];
        locpan: code[15];
        reccust: Record 18;
        recloc: Record 14;
        vGST: code[20];
        Vpan: code[10];
        vendorName: text[100];
        Vaddress: text[200];
        vemail: Text[100];
        SlNo: Integer;
        recvendor: Record Vendor;
        reccompinfo: Record 79;
        compname: text[100];
        compaddress1: text[100];
        compaddress2: text[100];
        compcity: text[30];
        compemail: text[100];
        compphone: code[20];
        compGST: code[20];
        compPAN: code[10];
        recGST: Record "GST Ledger Entry";
        recHSN: Record "HSN/SAC";
        comment: Record "Sales Comment Line";
        comment2: text;
        tdsTotal: Decimal;
        purchaseLine6: Record 5110;
        RecID: RecordID;
        TotalCGSTAmount: Decimal;
        AmtVendorTotal: Decimal;
        TotalSGSTAmt: Decimal;
        TotalIGSTAmt: Decimal;
        TermDesc: text[150];
        Sub55: Text[500];
        test: Record "Tax Transaction Value";
        test2: BigText;
        blobcomment2: text[500];
        recPurHeader9: Record "Purchase Header";
        recpurline9: Record "Purchase Line";
        PurCommentLine: Record 43;
        Subject: Text[500];
        reportcheck: Report Check;
        blobcomment: text;
        amtinwords: array[2] of text[250];
        GrandTotal: Decimal;
        RecVLE: Record "Vendor Ledger Entry";
        GSTPerVar: Decimal;
        Vendor: Record Vendor;
        Qty: Decimal;
        UnitPrice: Decimal;
        Salesperson: Record "Salesperson/Purchaser";
        SalespersonText: Text[50];
        Amount_: Decimal;
        recpurchaseLine: Record 5110;
        ctr: Integer;
        TaxTransactionvalue: Record "Tax Transaction Value";
        // termCoditionTransaction: Record "Terms & Condition Transaction";
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
        Totalfin: Decimal;
        TotalTotNoOfPkgs: Decimal;
        TotalQty: Decimal;
        TotalLineAmt: Decimal;
        TotalExciseAmt: Decimal;
        TotalAmtToCustomer: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        paydesc: Text[58];
        paymentmethod: Record "Payment Method";
        TotalAmtToCustomerInvrounding: Decimal;
        AmountToVendor_PL: Decimal;
        purpose: Text[50];
        Department: Text[50];
        GenjnlNartn: Text;
        GenjnlNartn1: Text;
        GenjnlNartn2: Text;
        Location: Record Location;
        LocState: Text[50];
        Currency: Text[10];
        grade: Text[10];
        VenStateDesc: Text;
        PaymentTerms: Record "Payment Terms";
        gcjs: Page "Purchase Order";
        TdsAmt: Decimal;
        TdsPer: Decimal;
        TotalTDSAmt: Decimal;
        PurchLine: Record "Sales Line";
        PurchaeHeaderRec: Record 5109;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        NoTextAmt: ARRAY[2] OF Text[80];
        OneLbl: Label 'ONE';
        TwoLbl: Label 'TWO';
        ThreeLbl: Label 'THREE';
        FourLbl: Label 'FOUR';
        FiveLbl: Label 'FIVE';
        SixLbl: Label 'SIX';
        SevenLbl: Label 'SEVEN';
        EightLbl: Label 'EIGHT';
        NineLbl: Label 'NINE';
        TenLbl: Label 'TEN';
        ElevenLbl: Label 'ELEVEN';
        TwelveLbl: Label 'TWELVE';
        ThireentLbl: Label 'THIRTEEN';
        FourteenLbl: Label 'FOURTEEN';
        FifteenLbl: Label 'FIFTEEN';
        SixteenLbl: Label 'SIXTEEN';
        SeventeenLbl: Label 'SEVENTEEN';
        EighteenLbl: Label 'EIGHTEEN';
        NinteenLbl: Label 'NINETEEN';
        TwentyLbl: Label 'TWENTY';
        ThirtyLbl: Label 'THIRTY';
        FortyLbl: Label 'FORTY';
        FiftyLbl: Label 'FIFTY';
        SixtyLbl: Label 'SIXTY';
        SeventyLbl: Label 'SEVENTY';
        EightyLbl: Label 'EIGHTY';
        NinetyLbl: Label 'NINETY';
        ThousandLbl: Label 'THOUSAND';
        LakhLbl: Label 'LAKH';
        CroreLbl: Label 'CRORE';
        ZeroLbl: Label 'ZERO';
        OnlyLbl: Label 'ONLY';
        DrLbl: Label 'Dr';
        ToLbl: Label 'To';
        RupeesLbl: Label 'RUPEES';
        PaisaOnlyLbl: Label ' PAISA ONLY';
        DatedLbl: Label '  Dated: ';
        RsLbl: Label 'Rs. ';
        ChequeNoLbl: Label 'Cheque No: ';
        DateLbl: Label 'Date: ';
        HundreadLbl: Label 'HUNDRED';
        AndLbl: Label 'AND';
        ExceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';
        hidevalue: Boolean;
        CommentLine: array[10] of Text[200];
    // requestpage
    // {
    //     layout
    //     // {
    //     //     area(content)
    //     //     {
    //     //         group(GroupName)
    //     //         {
    //     //         }
    //     //     }
    //     // }
    //         actions
    //         {
    //             area(processing)
    //             {
    //             }
    //         }
    //     }
    //////////////////////////////////
    procedure HideShow2(DocNo: Code[20]): Boolean
    var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        TempPercent3: Decimal;
        TempPercent4: Decimal;
        SInvLine: Record 5110;
    begin
        SInvLine.Reset();
        SInvLine.SetRange("Document No.", DocNo);
        if SInvLine.FindSet() then
            repeat
                if SInvLine."Line No." = 10000 then begin
                    TempPercent1 := SInvLine."Igst per";
                    TempPercent2 := SInvLine."Igst per";
                end
                else
                    TempPercent2 := SInvLine."Igst per";
                if TempPercent1 <> TempPercent2 then exit(true);
            until SInvLine.Next() = 0;
        exit(false);
    end;
    ///////////////////////////////////
    procedure HideShow(DocNo: Code[20]): Boolean
    var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        SInvLine: Record 5110;
    begin
        SInvLine.Reset();
        SInvLine.SetRange("Document No.", DocNo);
        if SInvLine.FindSet() then
            repeat
                if SInvLine."Line No." = 10000 then begin
                    TempPercent1 := SInvLine."CGST per";
                    TempPercent2 := SInvLine."CGST per";
                end
                else
                    TempPercent2 := SInvLine."CGST per";
                if TempPercent1 <> TempPercent2 then exit(true);
            until SInvLine.Next() = 0;
        exit(false);
    end;

    procedure AddComment(Docno: Code[20])
    var
        PurchCommentLine: Record "Purch. Comment Line";
    begin
        PurchCommentLine.Reset();
        PurchCommentLine.SetCurrentKey(Code);
        PurchCommentLine.SetRange("No.", Docno);
        //PurchCommentLine.SetRange(Code, Code);
        if PurchCommentLine.FindSet() then
            repeat
                if PurchCommentLine.Code = '1' then CommentLine[1] += PurchCommentLine.Comment + ' ';
                if PurchCommentLine.Code = '2' then CommentLine[2] += PurchCommentLine.Comment + ' ';
                if PurchCommentLine.Code = '3' then CommentLine[3] += PurchCommentLine.Comment + ' ';
                if PurchCommentLine.Code = '4' then CommentLine[4] += PurchCommentLine.Comment + ' ';
                if PurchCommentLine.Code = '5' then CommentLine[5] += PurchCommentLine.Comment + ' ';
                if PurchCommentLine.Code = '6' then CommentLine[6] += PurchCommentLine.Comment + ' ';
                if PurchCommentLine.Code = '7' then CommentLine[7] += PurchCommentLine.Comment + ' ';
            until PurchCommentLine.Next() = 0;
        CommentLine[1] := CommentLine[1].TrimEnd(',');
        CommentLine[2] := CommentLine[2].TrimEnd(',');
        CommentLine[3] := CommentLine[3].TrimEnd(',');
        CommentLine[4] := CommentLine[4].TrimEnd(',');
        CommentLine[5] := CommentLine[5].TrimEnd(',');
        CommentLine[6] := CommentLine[6].TrimEnd(',');
        CommentLine[7] := CommentLine[7].TrimEnd(',');
    end;
    ////////////////////////////////////////////////////////////////
    local procedure GetGSTAmount2(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 5110;
    begin
        if not GSTSetup.Get() then exit;
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst() then
            repeat
                if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt2 += TaxTransactionValue.Amount;
                    CGSTPer2 := TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt2 += TaxTransactionValue.Amount;
                    SGSTPer2 := TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt2 += TaxTransactionValue.Amount;
                    IGSTPer2 := TaxTransactionValue.Percent;
                end;
            until TaxTransactionValue.Next() = 0;
    end;
    /////////////////////////////////tds
    local procedure GetTDSAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        Clear(TdsAmt);
        //Clear(TdsPer);
        if not GSTSetup.Get() then exit;
        Clear(TotalTDSAmt);
        Clear(TdsAmt);
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", 'TDS');
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet then begin
            repeat
                TdsAmt := TaxTransactionValue.Amount;
                TdsPer := TaxTransactionValue.Percent;
            until TaxTransactionValue.Next() = 0;
            TotalTDSAmt := Round(TdsAmt, 1, '=');
        end;
    end;
    //////////////////////////////////
    procedure InitTextVariable()
    begin
        OnesText[1] := OneLbl;
        OnesText[2] := TwoLbl;
        OnesText[3] := ThreeLbl;
        OnesText[4] := FourLbl;
        OnesText[5] := FiveLbl;
        OnesText[6] := SixLbl;
        OnesText[7] := SevenLbl;
        OnesText[8] := EightLbl;
        OnesText[9] := NineLbl;
        OnesText[10] := TenLbl;
        OnesText[11] := ElevenLbl;
        OnesText[12] := TwelveLbl;
        OnesText[13] := ThireentLbl;
        OnesText[14] := FourteenLbl;
        OnesText[15] := FifteenLbl;
        OnesText[16] := SixteenLbl;
        OnesText[17] := SeventeenLbl;
        OnesText[18] := EighteenLbl;
        OnesText[19] := NinteenLbl;
        TensText[1] := '';
        TensText[2] := TwentyLbl;
        TensText[3] := ThirtyLbl;
        TensText[4] := FortyLbl;
        TensText[5] := FiftyLbl;
        TensText[6] := SixtyLbl;
        TensText[7] := SeventyLbl;
        TensText[8] := EightyLbl;
        TensText[9] := NinetyLbl;
        ExponentText[1] := '';
        ExponentText[2] := ThousandLbl;
        ExponentText[3] := LakhLbl;
        ExponentText[4] := CroreLbl;
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[150]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then Error(exceededStringErr, AddText);
        end;
        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure FormatNoText(var NoText: array[2] of Text[150]; No: Decimal; CurrencyCode: Code[10])
    var
        Currency: Record Currency;
        PrintExponent: Boolean;
        NoTextIndex: Integer;
        TensDec: Integer;
        OnesDec: Integer;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '';
        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else
            for Exponent := 4 DOWNTO 1 do begin
                PrintExponent := false;
                if No > 99999 then begin
                    Ones := No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds := 0;
                end
                else begin
                    Ones := No DIV Power(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                end;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, HundreadLbl);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end
                else if (Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        end
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, RupeesLbl);
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);
        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end
        else if (TensDec * 10 + OnesDec) > 0 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl);
        if (CurrencyCode <> '') then
            AddToNoText(NoText, NoTextIndex, PrintExponent, OnlyLbl)
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, PaisaOnlyLbl);
    end;

    local procedure GetGSTAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 5110;
    begin
        if not GSTSetup.Get() then exit;
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst() then
            repeat
                if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt += TaxTransactionValue.Amount;
                    CGSTPer := TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt += TaxTransactionValue.Amount;
                    SGSTPer := TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt += TaxTransactionValue.Amount;
                    IGSTPer := TaxTransactionValue.Percent;
                end;
            until TaxTransactionValue.Next() = 0;
    end;
}
