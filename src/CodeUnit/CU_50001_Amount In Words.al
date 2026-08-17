codeunit 50001 "Amount In Words"
{
    var
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Enum "Gen. Journal Account Type";
        TDSAmount: Decimal;
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocType: Text[30];
        DocNo: Text[30];
        ExtDocNo: Text[35];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        PrintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PrintedStub: Boolean;
        TotalText: Text[10];
        JournalPostingDate: Date;
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        LineAmount2: Decimal;
        NotPreviewLbl: Label 'Preview is not allowed.';
        LastCheckLbl: Label 'Last Check No. must be filled in.';
        FilterLbl: Label 'Filters on %1 and %2 are not allowed.', Comment = '%1 = Line No. %2 = Document No.';
        CheckCompAddLbl: Label 'XXXXXXXXXXXXXXXX';
        MustLbl: Label 'must be entered.';
        SamecurrencyLbl: Label 'The Bank Account and the General Journal Line must have the same currency.';
        SalespersonLbl: Label 'Salesperson';
        PurchaserLbl: Label 'Purchaser';
        BankcurrencyLbl: Label 'Both Bank Accounts must have the same currency.';
        ContactLbl: Label 'Our Contact';
        DocExtNoLbl: Label 'XXXXXXXXXX';
        ChckNoLbl: Label 'XXXX';
        CheckDateLbl: Label 'XX.XXXXXXXXXX.XXXX';
        AlreadyLbl: Label '%1 already exists.', Comment = '%1 =UseCheckNo';
        BAlTypeNoLbl: Label 'Check for %1 %2', Comment = '%1 Balance Type %2 No.';
        DocTypeLbl: Label 'Payment';
        CHeckRepLbl: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        DocType1Lbl: Label 'XXX';
        TotalTExtLbl: Label 'Total';
        TotAmtPosLbl: Label 'The total amount of check %1 is %2. The amount must be positive.', Comment = '%1 Use Check No %2 Total Line Amt';
        TotVoidLbl: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        NonNegoLbl: Label 'NON-NEGOTIABLE';
        TestPrintLbl: Label 'Test print';
        CheckAmttextLbl: Label 'XXXX.XX';
        DescripLineLbl: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        ZeroLbl: Label 'Zero';
        HundreadLbl: Label 'Hundred';
        AndLbl: Label 'and';
        exceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';
        DocTypeCustVendLbl: Label ' is already applied to %1 %2 for customer %3.', Comment = '%1 Doc Type %2 Customer NO. And %3 Vendor NO';
        OneLbl: Label 'One';
        TwoLbl: Label 'Two';
        ThreeLbl: Label 'Three';
        FourLbl: Label 'Four';
        FiveLbl: Label 'Five';
        SixLbl: Label 'Six';
        SevenLbl: Label 'Seven';
        EightLbl: Label 'Eight';
        NineLbl: Label 'Nine';
        TenLbl: Label 'Ten';
        ElevenLbl: Label 'Eleven';
        TwelveLbl: Label 'Twelve';
        ThirteenLbl: Label 'Thirteen';
        FourteenLbl: Label 'Fourteen';
        FifteenLbl: Label 'Fifteen';
        SixteenLbl: Label 'Sixteen';
        SeventeenLbl: Label 'Seventeen';
        EighteenLbl: Label 'Eignteen';
        NinteenLbl: Label 'Nineteen';
        TwentyLbl: Label 'Twenty';
        ThirtyLbl: Label 'Thirty';
        FortyLbl: Label 'Forty';
        FiftyLbl: Label 'Fifty';
        SixtyLbl: Label 'Sixty';
        SeventyLbl: Label 'Seventy';
        EightyLbl: Label 'Eighty';
        NinetyLbl: Label 'Ninety';
        ThousandLbl: Label 'Thousand';
        LakhLbl: Label 'Lakh';
        CroreLbl: Label 'Crore';
        Text062Lbl: Label 'G/L Account,Customer,Vendor,Bank Account';
        NetAmtLbl: Label 'Net Amount %1', Comment = '%1 Gen Jrn Line Currency code';
        FieldCapTableCapLbl: Label '%1 must not be %2 for %3 %4.', Comment = '%1 Field Caption %2 Vend Blocked %3 Table Caption  %4 vend&Cust No.';
        SubTotLbl: Label 'Subtotal';
        CheckNoCaptionLbl: Label 'Check No.';
        NetAmtCaptionLbl: Label 'Net Amount';
        DiscCaptionLbl: Label 'Discount';
        AmtCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        CurrCodeCaptionLbl: Label 'Currency Code';
        YourDocNoCaptionLbl: Label 'Your Doc. No.';
        TDSCaptionLbl: Label 'TDS';
        TransportCaptionLbl: Label 'Transport';

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        CurrRec: Record Currency;
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        // NoText[1] := '****';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else
            for Exponent := 4 DOWNTO 1 do begin
                PrintExponent := false;
                if No > 99999 then begin
                    Ones := No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds := 0;
                end else begin
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
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        if CurrencyCode <> '' then begin
            CurrRec.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrRec."Currency Numeric Description");
        end else
            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);

        TensDec := ((No * 100) MOD 100) DIV 10;
        // OnesDec := (No * 100) MOD 10;
        OnesDec := ROUND((No * 100) MOD 10, 1, '=');
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl);
        if (CurrencyCode <> '') then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrRec."Currency Decimal Description" + ' Only')
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + ' Only');

    end;

    procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal
    begin
        if Abs(Decimal1) < Abs(Decimal2) then
            exit(Decimal1);
        exit(Decimal2);
    end;

    procedure InputBankAccount()
    begin
        if BankAcc2."No." <> '' then begin
            BankAcc2.Get(BankAcc2."No.");
            BankAcc2.TestField("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        end;
    end;

    local procedure AddToNoText(
        var NoText: array[2] of Text[80];
        var NoTextIndex: Integer;
        var PrintExponent: Boolean;
        AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(exceededStringErr, AddText);
        end;

        NoText[NoTextIndex] := CopyStr(DelChr(NoText[NoTextIndex] + ' ' + AddText, '<'), 1, 80);
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
        OnesText[13] := ThirteenLbl;
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

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean)
    begin
        if BankAcc <> '' then
            if BankAcc2.Get(BankAcc) then begin
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                PrintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PrintedStub := NewPreprintedStub;
            end;
    end;

    local procedure ExchangeAmt(CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        if (CurrencyCode <> '') and (CurrencyCode2 = '') then
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                JournalPostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(JournalPostingDate, CurrencyCode))
        else
            if (CurrencyCode = '') and (CurrencyCode2 <> '') then
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    JournalPostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(JournalPostingDate, CurrencyCode2))
            else
                if (CurrencyCode <> '') and (CurrencyCode2 <> '') and (CurrencyCode <> CurrencyCode2) then
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(JournalPostingDate, CurrencyCode2, CurrencyCode, Amount)
                else
                    Amount2 := Amount;
    end;

    procedure EnableBooleanButton()
    var
    begin
        // GenLedSetup.get();
        // if not GenLedSetup."Enable 3kt Reports" then
        //     Error('%1 must be enabled', GenLedSetup.FieldCaption("Enable 3kt Reports"));
    end;

    var
        GenLedSetup: Record "General Ledger Setup";
        aaa: Report "GSTR-1 File Format";
        bbb: Report "GSTR_2 File Format";
        ccc: Report "GSTR-3B";
        GSTR1EXPQuery: Query GSTR1ExpQuery;
        sads: Record "GST Ledger Entry";
        saasA: Record "Detailed GST Ledger Entry";
        sss: Page "Purchase Order Archive";

}