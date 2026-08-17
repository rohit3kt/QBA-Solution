report 50011 "Proforma Invoice Backup"
{
    ApplicationArea = All;
    Caption = 'Proforma Invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(invHeader; 36)
        {
            RequestFilterFields = "No.";

            column(DocNo_; "No.")
            {
            }
            column(exportdeclaration; exportdeclaration)
            {
            }
            column(cStateneme; cStateneme)
            {
            }
            column(ccountryname; ccountryname)
            {
            }
            column(AppliedAmount; AppliedAmount)
            {
            }
            column(Cpicture; reccompinfo.Picture)
            {
            }
            column(HeaderPicture; reccompinfo.Picture2)
            {
            }
            column(msmeno; reccompinfo."MSME No.")
            {
            }
            column(INRorUSDorEURO; INRorUSDorEURO)
            {
            }
            column(Cname; reccompinfo.Name)
            {
            }
            column(header; header)
            {
            }
            // column(Order_No_; "Order No.") { }
            column(External_Document_No_; "External Document No.")
            {
            }
            //  column(IRN; invHeader."IRN Hash") { }
            column(CIN; reccompinfo.CIN)
            {
            }
            column(ARN; reccompinfo."ARN No.")
            {
            }
            column(caddress; (reccompinfo.Address + ', ' + reccompinfo."Address 2" + ', ' + reccompinfo."Post Code" + ', ' + reccompinfo.City + ', ' + cStateneme + ' ,' + ccountryname))
            {
            }
            column(cemail; reccompinfo."E-Mail")
            {
            }
            column(reccompinfopostcode; reccompinfo."Post Code")
            {
            }
            column(CGstreg; reccompinfo."GST Registration No.")
            {
            }
            column(compPAn; reccompinfo."P.A.N. No.")
            {
            }
            //column(QR_Code; "QR Code") { }
            column(custACK; custACK)
            {
            }
            column(custGST; ShiptoGST)
            {
            } //custGST
            column(ShiptoGST2; ShiptoGST2)
            {
            } //custGST
            column(No; "No.")
            {
            }
            column(DocumentDate; format("Document Date"))
            {
            }
            column(DueDate; format("Due Date"))
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BilltoAddress; "Bill-to Address" + ', ' + "Bill-to Address 2" + ', ' + "Bill-to City" + ', ' + "Bill-to Post Code" + ', ' + custstate + ', ' + "Bill-to County")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoContact; "Bill-to Contact")
            {
            }
            column(BilltoContactNo; "Bill-to Contact No.")
            {
            }
            column(BilltoCounty; "Bill-to County")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Comment; Comment)
            {
            }
            column(hidevalue; hidevalue)
            {
            }
            column(hidevalue2; hidevalue2)
            {
            }
            dataitem(SalesInvoiceLine; 37)
            {
                DataItemLink = "document No." = field("No.");

                column(ItemNo_; "No.")
                {
                }
                column(Description; Description + ', ' + "Description 2")
                {
                }
                column(SlNo; SlNo)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(cgstper; cgstper)
                {
                }
                column(CGSTamt; TotalCGSTAmount)
                {
                }
                column(sgstamt; TotalCGSTAmount)
                {
                }
                column(sgstper; sgstper)
                {
                }
                column(Igstper; Igstper)
                {
                }
                column(IGSTamt; TotalIGSTAmt)
                {
                }
                column(NoText; NoText[1])
                {
                }
                column(cgst_amt; "cgst amt")
                {
                }
                column(Igst_amt; "Igst amt")
                {
                }
                column(cgst_per; "cgst per")
                {
                }
                column(Igst_per; "Igst per")
                {
                }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                    Clear(INRorUSDorEURO);
                    ////////////////////////////////////////////////////////////////////////////////
                    PurchaseLine4.Reset();
                    PurchaseLine4.SetRange("Document No.", invHeader."No.");
                    If PurchaseLine4.Findset() then //begin
                        repeat
                            Clear(CGSTAmt2);
                            Clear(SGSTAmt2);
                            Clear(IGSTAmt2);
                            Clear(cgstper2);
                            Clear(Igstper2);
                            GetGSTAmount2(PurchaseLine4.RecordId);
                            // TotalCGSTAmount2 += CGSTAmt2;
                            // TotalIGSTAmt2 += IGSTAmt2;
                            // TotalSGSTAmt2 += SGSTAmt2;
                            if (PurchaseLine4."cgst amt" = 0) or (PurchaseLine4."IGST Amt" = 0) or (PurchaseLine4."IGST per" = 0) or (PurchaseLine4."CGST per" = 0) then begin
                                PurchaseLine4."cgst amt" := CGSTAmt2;
                                PurchaseLine4."IGST Amt" := IGSTAmt2;
                                PurchaseLine4."IGST per" := Igstper2;
                                PurchaseLine4."CGST per" := cgstper2;
                                // CGST_Percent[1] := cgstper2;
                                PurchaseLine4.modify(true);
                                // Message(format(CGST_Percent[1]));
                                // if 
                            end;
                        until PurchaseLine4.Next() = 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    SlNo += 1;
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", invHeader."No.");
                    If PurchaseLine.FindSet() then
                        repeat
                            GetGSTAmount(PurchaseLine.RecordId);
                            TotalCGSTAmount += CGSTAmt;
                            TotalIGSTAmt += IGSTAmt;
                            TotalSGSTAmt += SGSTAmt;
                        until PurchaseLine.Next() = 0;
                    //tds
                    purchaseLine.Reset();
                    purchaseLine.SetRange(purchaseLine."Document No.", invHeader."No.");
                    if purchaseLine.Findfirst() then
                        repeat
                            GetTDSAmount(purchaseLine.RecordId); //TDS
                            tdsTotal += TotalTDSAmt;
                        // TdsPer := 
                        Until purchaseLine.Next() = 0;
                    //
                    //for Amt in words
                    // GrandTotal += TaxableAmt;// + Last(Fields!CGSTAmt.Value) + Last(Fields!IGSTAmt.Value) + Last(Fields!SGSTAmt.Value)
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", invHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    If PurchaseLine.FindSet() then
                        repeat
                            Clear(CGSTAmt);
                            Clear(SGSTAmt);
                            Clear(IGSTAmt);
                            GetGSTAmount(PurchaseLine.RecordId);
                            AmtVendorTotal += (CGSTAmt + SGSTAmt + IGSTAmt + PurchaseLine.Amount) - (PurchaseLine."Line Discount Amount") - (tdsTotal); //"Amount Including VAT"
                            TotalCGSTAmount += CGSTAmt;
                            TotalIGSTAmt += IGSTAmt;
                            TotalSGSTAmt += SGSTAmt;
                        until PurchaseLine.Next() = 0;
                    InitTextVariable();
                    FormatNoText(NoText, Abs(AmtVendorTotal + AppliedAmount), invHeader."Currency Code");
                    //
                    Clear(INRorUSDorEURO);
                    if invHeader."Currency Code" = '' then
                        INRorUSDorEURO := 'INR'
                    else if invHeader."Currency Code" = 'USD' then
                        INRorUSDorEURO := 'USD'
                    else if invHeader."Currency Code" = 'EURO' then INRorUSDorEURO := 'EURO';
                    if SGSTAmt <> 0 then
                        gsrper := SGSTPer * 2
                    else
                        gsrper := igstper;
                    ///////////////////////ship to address
                    //if PurchaseHeader.ShipToOptions= PurchaseHeader.shiptooption::
                    // if PurOrder.ship//ShippingOptionWithLocation
                    // if PurOrder.
                    //if PurchaseHeader."Ship-to Code" = 
                    //"Ship-to Address" + "Ship-to Address 2" + ', ' + "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + locstatecode + ', ' + "Ship-to County") { }
                    if PurchaseHeader."Ship To" = 'Location' then begin
                        shiptoaddress := recloc.Address + ' ,' + recloc."Address 2" + ' ,' + recloc.City + ' ,' + recloc."Post Code" + ' ,' + locstatecode + ' ,' + recloc."Country/Region Code";
                        ShiptoGST := recloc."GST Registration No.";
                        ShipToPAN := CopyStr(recloc."GST Registration No.", 3, 10);
                        ShipToCIN := recloc.CIN;
                        ShipToCode := recloc.Code;
                        ShipToName := recloc.Name;
                    end
                    else if PurchaseHeader."Ship To" = 'Customer Address' then begin
                        reccust.get(invHeader."Sell-to Customer No.");
                        shiptoaddress := reccust.Address + ' ,' + reccust."Address 2" + ' ,' + reccust.City + ' ,' + reccust."Post Code" + ' ,' + reccust."State Code" + ' ,' + reccust."Country/Region Code";
                        ShiptoGST := reccust."GST Registration No.";
                        ShipToPAN := CopyStr(reccust."GST Registration No.", 3, 10);
                        //ShipToCIN := reccust.cin
                        ShipToCIN := recloc.CIN;
                        ShipToCode := reccust."No.";
                        ShipToName := reccust.Name;
                    end
                    else if PurchaseHeader."Ship To" = 'Default (Company Address)' then begin
                        // reccompinfo.get;
                        // reccompinfo.CalcFields(Picture);
                        shiptoaddress := reccompinfo.Address + ' ,' + reccompinfo."Address 2" + ' ,' + reccompinfo.City + ' ,' + reccompinfo."Post Code" + ' ,' + reccompinfo."State Code" + ' ,' + reccompinfo."Country/Region Code";
                        ShiptoGST := reccompinfo."GST Registration No.";
                        ShipToPAN := CopyStr(reccompinfo."GST Registration No.", 3, 10);
                        ShipToCIN := reccompinfo.CIN;
                        // ShipToCode := reccompinfo.co;
                        ShipToName := reccompinfo.Name;
                    end;
                    reccust2.get(invHeader."Sell-to Customer No.");
                    ShiptoGST2 := reccust2."GST Registration No.";
                    // export declaration
                    Clear(exportdeclaration);
                    if invHeader."Currency Code" <> '' then
                        exportdeclaration := true
                    else
                        exportdeclaration := false;
                end;
            }
            trigger OnPreDataItem()
            begin
                reccompinfo.get;
                reccompinfo.CalcFields(Picture);
                reccompinfo.CalcFields(Picture2);
                Clear(printDuplicate);
            end;

            trigger OnAfterGetRecord()
            begin
                if printDuplicate = false then
                    header := 'Original for Recipient'
                else if printDuplicate = true then header := 'Duplicate';
                Clear(printDuplicate);
                if invHeader."Currency Code" <> '' then header := 'Tax Invoice';
                clear(AppliedAmount);
                recCLE.Reset();
                recCLE.SetRange("Document No.", invHeader."Applies-to Doc. No.");
                if recCLE.FindFirst() then recCLE.CalcFields(Amount);
                AppliedAmount := recCLE.Amount;
                ////////////////////////////
                hidevalue := HideShow(invHeader."No.");
                hidevalue2 := HideShow2(invHeader."No.");
                /////////////////////////////////
                Recstate.Reset();
                Recstate.setrange(Code, reccompinfo."State Code");
                if Recstate.FindFirst() then cstateneme := Recstate.Description;
                reccountry.get(reccompinfo."Country/Region Code");
                ccountryname := reccountry.Name;
                recstate2.Reset();
                recstate2.setrange(code, "GST Bill-to State Code");
                if recstate2.FindFirst() then custstate := recstate2.Description;
            end;
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/Proforma Invoice backup.rdl';
        }
    }
    var
        exportdeclaration: Boolean;
        recstate2: Record State;
        Recstate: Record State;
        cStateneme: text;
        reccountry: record "Country/Region";
        ccountryname: text;
        AppliedAmount: Decimal;
        recCLE: Record 21;
        reccust2: Record 18;
        ShiptoGST2: code[20];
        hidevalue: Boolean;
        hidevalue2: Boolean;
        PurchaseLine4: Record 37;
        PurchaseLine: Record 37;
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
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        NoTextAmt: ARRAY[2] OF Text[80];
        NoText: array[2] of Text[80];
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
        printDuplicate: Boolean;
        custACK: text[100];
        SlNo: Integer;
        custGST: code[20];
        TdsPer: Decimal;
        reccompinfo: Record "Company Information";
        recGST: Record "GST Ledger Entry";
        detailedGST: Record "Detailed GST Ledger Entry";
        CGSTamt: Decimal;
        sgstamt: Decimal;
        IGSTamt: Decimal;
        cgstper: Decimal;
        sgstper: Decimal;
        Igstper: Decimal;
        reccustomer: Record Customer;
        custIRN: text[250];
        TdsAmt: Decimal;
        header: Text[30];
        CGSTAmt2: Decimal;
        CGSTPer2: Decimal;
        SGSTAmt2: Decimal;
        SGSTPer2: Decimal;
        IGSTAmt2: Decimal;
        IGSTPer2: Decimal;

    procedure HideShow2(DocNo: Code[20]): Boolean
    var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        SInvLine: Record 37;
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
    //////////////////////////////////////////
    procedure HideShow(DocNo: Code[20]): Boolean
    var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        SInvLine: Record 37;
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

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then Error(exceededStringErr, AddText);
        end;
        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
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
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' DOLLAR');
        end
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, RupeesLbl);
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);
        TensDec := ((No * 100) MOD 100) DIV 10;
        // OnesDec := (No * 100) MOD 10; kallol
        OnesDec := ((No * 1000) MOD 100) DIV 10;
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
        LpurLine: Record 37;
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

    local procedure GetTDSAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        Clear(TdsAmt);
        Clear(TdsPer);
        if not GSTSetup.Get() then exit;
        Clear(tdsTotal);
        Clear(TotalTDSAmt);
        Clear(TdsAmt);
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", 'TDS');
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst() then
            repeat
                TdsAmt := TaxTransactionValue.Amount;
                TotalTDSAmt := Round(TdsAmt, 1, '=');
                TdsPer := TaxTransactionValue.Percent;
            until TaxTransactionValue.Next() = 0;
        // tdsTotal := TotalTDSAmt;
    end;

    local procedure GetGSTAmount2(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 123;
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
}
