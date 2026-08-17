report 50002 "Sales Invoice Domestic"
{
    ApplicationArea = All;
    Caption = 'Sales Invoice Domestic';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

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
            column(Order_No_; "Order No.")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(IRN; SalesInvoiceHeader."IRN Hash")
            {
            }
            column(CIN; reccompinfo.CIN)
            {
            }
            column(ARN; reccompinfo."ARN No.")
            {
            }
            column(caddress; (reccompinfo.Address + ', ' + reccompinfo."Address 2" + ', ' + reccompinfo."Post Code" + ', ' + reccompinfo.City + ', ' + reccompinfo."State Code" + ' ,' + reccompinfo."Country/Region Code"))
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
            column(QR_Code; "QR Code")
            {
            }
            column(custACK; custACK)
            {
            }
            column(custGST; custGST)
            {
            }
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
            // column(bill)
            column(Cpicture; reccompinfo.Picture)
            {
            }
            column(HeaderPicture; reccompinfo.Picture2)
            {
            }
            //  column(QR_Code; "QR Code") { }
            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                // DataItemTableView = where("No." = filter(<> ''));
                column(No_; "No.")
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
                column(NoText; NoText[1])
                {
                }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    SlNo := SlNo + 1;
                    // if SalesInvoiceLine."No." = '' then
                    //   CurrReport.Skip();
                    Clear(cgstper);
                    Clear(CGSTamt);
                    Clear(sgstamt);
                    Clear(sgstper);
                    Clear(Igstper);
                    Clear(IGSTamt);
                    detailedGST.Reset();
                    detailedGST.SetRange("Document No.", SalesInvoiceLine."Document No.");
                    detailedGST.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                    if detailedGST.FindFirst() then begin
                        if detailedGST."GST Component Code" = 'IGST' then begin
                            Igstper := detailedGST."GST %";
                            IGSTamt := detailedGST."GST Amount";
                        end
                        else if detailedGST."GST Component Code" <> 'IGST' then begin
                            cgstper := detailedGST."GST %";
                            CGSTamt := detailedGST."GST Amount";
                            sgstper := detailedGST."GST %";
                            sGSTamt := detailedGST."GST Amount";
                        end;
                    end;
                    ///amt to word
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                    //  SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    If SalesInvoiceLine.FindSet() then
                        repeat
                            Clear(CGSTAmt);
                            Clear(SGSTAmt);
                            Clear(IGSTAmt);
                            GetGSTAmount(SalesInvoiceLine.RecordId);
                            AmtVendorTotal += (CGSTAmt + SGSTAmt + IGSTAmt + SalesInvoiceLine."Amount Including VAT") - (SalesInvoiceLine."Line Discount Amount");
                            TotalCGSTAmount += CGSTAmt;
                            TotalIGSTAmt += IGSTAmt;
                            TotalSGSTAmt += SGSTAmt;
                        until SalesInvoiceLine.Next() = 0;
                    InitTextVariable();
                    FormatNoText(NoText, Abs(AmtVendorTotal), SalesInvoiceHeader."Currency Code");
                    //
                    if SalesInvoiceHeader."Currency Code" = '' then
                        INRorUSDorEURO := 'INR'
                    else if SalesInvoiceHeader."Currency Code" = 'USD' then
                        INRorUSDorEURO := 'USD'
                    else if SalesInvoiceHeader."Currency Code" = 'EURO' then INRorUSDorEURO := 'EURO';
                end;
            }
            trigger OnPreDataItem()
            begin
                reccompinfo.get;
                reccompinfo.CalcFields(Picture);
                reccompinfo.CalcFields(Picture2);
                SalesInvoiceHeader.CalcFields("QR Code");
                Clear(header);
                // if printDuplicate = false then
                //     header := 'Duplicate'
                // else
                //     if printDuplicate <> false then
                //         header := 'Original for Recipient';
            end;

            trigger OnAfterGetRecord()
            begin
                if printDuplicate = false then
                    header := 'Original for Recipient'
                else if printDuplicate = true then header := 'Duplicate';
                SalesInvoiceHeader.CalcFields("QR Code");
                //
                ///
                reccustomer.Reset();
                reccustomer.SetRange("No.", "Bill-to Customer No.");
                if reccustomer.FindFirst() then begin
                    // custIRN := reccustomer.irn
                    custGST := reccustomer."GST Registration No.";
                    custACK := reccustomer."ARN No.";
                    custstate := reccustomer."State Code";
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
                    field(printDuplicate; printDuplicate)
                    {
                        Caption = 'Print Duplicate';
                        ApplicationArea = all;
                    }
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
            LayoutFile = './src/Report Layout/Sales Invoice Domestic.rdl';
        }
    }
    var
        custstate: code[15];
        INRorUSDorEURO: code[6];
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
        header: Text[30];

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
        LpurLine: Record 113;
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
