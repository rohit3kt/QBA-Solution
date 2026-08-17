report 50001 "Credit Note"
{
    ApplicationArea = All;
    Caption = 'Credit Note';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(SalesCrMemoHeader; 36)
        {
            RequestFilterFields = "No.";

            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(exportdeclaration; exportdeclaration)
            {
            }
            column(refdocno; refdocno)
            {
            }
            column(Bill_to_Address; "Bill-to Address" + "Bill-to Address 2" + ' ' + "Bill-to City" + ' ,' + "Bill-to Post Code" + ', ' + "GST Bill-to State Code" + ', ' + "Bill-to Country/Region Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(companyName; reccompanyInfo.Name)
            {
                // Caption = 'cname';
            }
            column(IceNo; reccompanyInfo."IEC No.")
            {
            }
            column(caddress1; reccompanyInfo.Address)
            {
            }
            column(caddress2; reccompanyInfo."Address 2" + ', ' + reccompanyInfo."Post Code" + ', ' + reccompanyInfo.City + ', ' + reccompanyInfo."State Code" + ', ' + reccompanyInfo."Country/Region Code")
            {
            }
            column(reccompanyInfo; reccompanyInfo."Post Code")
            {
            }
            column(companyInfoemail; reccompanyInfo."E-Mail")
            {
            }
            column(ompanyInfoPicture; reccompanyInfo.Picture)
            {
            }
            column(companyInfoIBAN; reccompanyInfo.IBAN)
            {
            }
            column(CompanyInfoGST; reccompanyInfo."GST Registration No.")
            {
            }
            column(companyInfoPAN; reccompanyInfo."P.A.N. No.")
            {
            }
            column(reccompanyInfoARN; reccompanyInfo."ARN No.")
            {
            }
            column(cin; reccompanyInfo.CIN)
            {
            }
            column(msmeno; reccompanyInfo."MSME No.")
            {
            }
            column(headerpicture; reccompanyInfo.Picture2)
            {
            }
            column(Comment; Comment)
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyFactor; "Currency Factor")
            {
            }
            // column(CustLedgerEntryNo; "Cust. Ledger Entry No.")
            // {
            // }
            column(DocumentDate; Format("Document Date"))
            {
            }
            column(DueDate; format("Due Date"))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(No; "No.")
            {
            }
            // column(OrderDate; "Order Date")
            // {
            // }
            // column(OrderNo; "Order No.")
            // {
            // }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            // column(PrepaymentOrderNo; "Prepayment Order No.")
            // {
            // }
            // column(QuoteNo; "Quote No.")
            // {
            // }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            // column(SourceCode; "Source Code")
            // {
            // }
            column(custGST; custGST)
            {
            }
            column(custIRN; custIRN)
            {
            }
            column(hidevalue; hidevalue)
            {
            }
            column(hidevalue2; hidevalue2)
            {
            }
            dataitem(SalesCrMemoLine; 37)
            {
                DataItemLink = "Document No." = field("No.");

                //DataItemTableView = where("No." = filter(<> ''));
                column(Item_No; SalesCrMemoLine."No.")
                {
                }
                column(cgst_amt; "cgst amt")
                {
                }
                column(cgst_per; "cgst per")
                {
                }
                column(Igst_amt; "Igst amt")
                {
                }
                column(Igst_per; "Igst per")
                {
                }
                column(Description; Description + "Description 2")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Unit_Price; SalesCrMemoLine."Unit Price")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(SlNo; SlNo)
                {
                }
                column(NoText; NoText[1])
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(cgstper; cgstper)
                {
                }
                column(CGSTamt; CGSTamt)
                {
                }
                column(sgstamt; sgstamt)
                {
                }
                column(sgstper; sgstper)
                {
                }
                column(Igstper; Igstper)
                {
                }
                column(IGSTamt; IGSTamt)
                {
                }
                column(INRorUSDorEURO; INRorUSDorEURO)
                {
                }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    if Quantity = 0 then CurrReport.skip;
                    slno := SlNo + 1;
                    // if SalesCrMemoLine."No." = '' then
                    //     CurrReport.Skip();
                    // Clear(CGSTamt);
                    // Clear(cgstper);
                    // Clear(sgstamt);
                    // Clear(sgstper);
                    // Clear(Igstper);
                    // Clear(IGSTamt);
                    // detailedGST.Reset();
                    // detailedGST.SetRange("Document No.", SalesCrMemoLine."Document No.");
                    // detailedGST.SetRange("Document Line No.", SalesCrMemoLine."Line No.");
                    // if detailedGST.FindFirst() then begin
                    //     if detailedGST."GST Component Code" = 'IGST' then begin
                    //         Igstper := detailedGST."GST %";
                    //         IGSTamt := detailedGST."GST Amount";
                    //     end else
                    //         if detailedGST."GST Component Code" <> 'IGST' then begin
                    //             cgstper := detailedGST."GST %";
                    //             CGSTamt := detailedGST."GST Amount";
                    //             sgstper := detailedGST."GST %";
                    //             sGSTamt := detailedGST."GST Amount";
                    //         end;
                    // end;
                    //
                    ///
                     //for Amt in words
                    // GrandTotal += TaxableAmt;// + Last(Fields!CGSTAmt.Value) + Last(Fields!IGSTAmt.Value) + Last(Fields!SGSTAmt.Value)
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", SalesCrMemoHeader."No.");
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
                    FormatNoText(NoText, Abs(AmtVendorTotal), SalesCrMemoHeader."Currency Code");
                    //
                    if SalesCrMemoHeader."Currency Code" = '' then
                        INRorUSDorEURO := 'INR'
                    else if SalesCrMemoHeader."Currency Code" = 'USD' then
                        INRorUSDorEURO := 'USD'
                    else if SalesCrMemoHeader."Currency Code" = 'EURO' then INRorUSDorEURO := 'EURO';
                    //
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                    If PurchaseLine.FindSet() then
                        repeat
                            GetGSTAmount(PurchaseLine.RecordId);
                            TotalCGSTAmount += CGSTAmt;
                            TotalIGSTAmt += IGSTAmt;
                            TotalSGSTAmt += SGSTAmt;
                        until PurchaseLine.Next() = 0;
                    //tds
                    purchaseLine.Reset();
                    purchaseLine.SetRange(purchaseLine."Document No.", SalesCrMemoHeader."No.");
                    if purchaseLine.Findfirst() then
                        repeat
                            GetTDSAmount(purchaseLine.RecordId); //TDS
                            tdsTotal += TotalTDSAmt;
                        // TdsPer := 
                        Until purchaseLine.Next() = 0;
                end;
                //end;
                //
            }
            trigger OnPreDataItem()
            begin
                reccompanyInfo.get;
                reccompanyInfo.CalcFields(Picture);
                reccompanyInfo.CalcFields(Picture2);
            end;

            trigger OnAfterGetRecord()
            begin
                reccompanyInfo.get;
                reccompanyInfo.CalcFields(Picture);
                reccompanyInfo.CalcFields(Picture2);
                //
                reccust.Reset();
                reccust.SetRange("No.", "Bill-to Customer No.");
                if reccust.FindFirst() then begin
                    custGST := reccust."GST Registration No.";
                    ////////////////////////////////////
                    hidevalue := HideShow(SalesCrMemoHeader."No.");
                    hidevalue2 := HideShow2(SalesCrMemoHeader."No.");
                    /////
                    Clear(exportdeclaration);
                    if SalesCrMemoHeader."Currency Code" <> '' then
                        exportdeclaration := true
                    else
                        exportdeclaration := false; ///////////////
                    ////////////////////////////////
                    Clear(refdocno);
                    salLine.Reset();
                    salLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                    salLine.SetFilter(Quantity, '=%1', 0);
                    if salLine.FindFirst() then refdocno := salLine.Description;
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/Credit Note.rdl';
        }
    }
    var
        refdocno: text;
        salLine: Record 37;
        exportdeclaration: Boolean;
        hidevalue: Boolean;
        hidevalue2: Boolean;
        PurchaseLine: Record 37;
        INRorUSDorEURO: code[5];
        NoText: array[2] of text[150];
        SlNo: Integer;
        custGST: code[20];
        reccompanyInfo: Record "Company Information";
        recGST: Record "GST Ledger Entry";
        detailedGST: Record "Detailed GST Ledger Entry";
        CGSTamt: Decimal;
        TotalSGSTAmt: Decimal;
        TotalIGSTAmt: Decimal;
        TotalCGSTAmount: Decimal;
        AmtVendorTotal: Decimal;
        sgstamt: Decimal;
        IGSTamt: Decimal;
        cgstper: Decimal;
        sgstper: Decimal;
        Igstper: Decimal;
        reccustomer: Record Customer;
        custIRN: text[250];
        reccust: Record 18;
        TdsAmt: Decimal;
        TdsPer: Decimal;
        // tdsTotal: Decimal;
        // TotalTDSAmt: Decimal;
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
        tdsTotal: Decimal;
        ChequeNoLbl: Label 'Cheque No: ';
        DateLbl: Label 'Date: ';
        HundreadLbl: Label 'HUNDRED';
        AndLbl: Label 'AND';
        TotalTDSAmt: Decimal;
        ExceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';

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
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' DOLLAR ');
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

    procedure HideShow2(DocNo: Code[20]): Boolean
    var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        TempPercent3: Decimal;
        TempPercent4: Decimal;
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
}
