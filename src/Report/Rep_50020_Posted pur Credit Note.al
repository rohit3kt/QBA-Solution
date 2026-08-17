report 50020 "Posted pur Credit Note"
{
    ApplicationArea = All;
    Caption = 'Posted Debit Note new';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    Permissions = 
        tabledata "Company Information" = R,
        tabledata "Country/Region" = R,
        tabledata Currency = R,
        tabledata "GST Setup" = R,
        tabledata "Purch. Cr. Memo Hdr." = R,
        tabledata "Purch. Cr. Memo Line" = RMID,
        tabledata State = R,
        tabledata "Tax Transaction Value" = R,
        tabledata Vendor = R;

    dataset
    {
        dataitem(SalesCrMemoHeader;124) //"Sales Cr.Memo Header"
        {
            RequestFilterFields = "No.";

            //column(po; SalesCrMemoHeader."Return Order No.") { }
            column(Bill_to_Name; SalesCrMemoHeader."Buy-from Vendor Name")
            {
            }
            column(Bill_to_Address; SalesCrMemoHeader."Buy-from Address" + "Buy-from Address 2" + "Buy-from City" + ',  ' + "Buy-from Post Code" + ', ' + statecode2 + ', ' + countryname)
            {
            } // "Bill-to Address" + "Bill-to Address 2" + ' ' + "Bill-to City" + ' ,' + "Bill-to Post Code" + ', ' + "Bill-to Country/Region Code") { }
            column(Amount; Amount)
            {
            }
            column(exportdeclaration; exportdeclaration)
            {
            }
            column(CMdocno; CMdocno)
            {
            }
            column(visibility; visibility)
            {
            }
            column(companyName; reccompanyInfo.Name)
            {
            //  SalesCrMemoHeader.
            }
            column(ICENo; reccompanyInfo."IEC No.")
            {
            }
            column(caddress1; reccompanyInfo.Address)
            {
            }
            column(caddress2; reccompanyInfo."Address 2" + ', ' + reccompanyInfo."Post Code" + ', ' + reccompanyInfo.City + ', ' + statecode5 + ', ' + ccountryname)
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
            column(ExternalDocumentNo;'') //"External Document No."
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
            dataitem(SalesCrMemoLine;125)
            {
                DataItemLink = "Document No."=field("No.");

                // DataItemTableView = where("No." = filter(<> ''));
                column(Item_No; SalesCrMemoLine."No.")
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
                column(Unit_Price; SalesCrMemoLine."Unit Cost")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(SlNo; SlNo)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(cgstper; cgstper)
                {
                }
                column(CGSTamt; CGSTAmt)
                {
                }
                column(sgstamt; SGSTAmt)
                {
                }
                column(sgstper; sgstper)
                {
                }
                column(Igstper; Igstper)
                {
                }
                column(IGSTamt; IGSTAmt)
                {
                }
                column(NoText; NoText[1])
                {
                }
                column(INRorUSDorEURO; INRorUSDorEURO)
                {
                }
                column(CGST_amt; SalesCrMemoLine."CGST amt")
                {
                }
                column(CGST_Per; SalesCrMemoLine."CGST Per")
                {
                }
                column(IGST_amt; SalesCrMemoLine."IGST amt")
                {
                }
                column(IGST_per; SalesCrMemoLine."IGST per")
                {
                }
                trigger OnPreDataItem()
                begin
                    SlNo:=0;
                    PurchaseLine4.Reset();
                    PurchaseLine4.SetRange("Document No.", SalesCrMemoHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    If PurchaseLine4.Findset()then //begin
 repeat // TotalSGSTAmt2 := 0;
                            // TotalIGSTAmt2 := 0;
                            // TotalCGSTAmount2 := 0;
                            // AmtVendorTotal2 := 0;
                            Clear(CGSTAmt2);
                            Clear(SGSTAmt2);
                            Clear(IGSTAmt2);
                            clear(IGSTPer2);
                            clear(cgstper2);
                            GetGSTAmount2(PurchaseLine4.RecordId);
                            // TotalCGSTAmount2 += CGSTAmt2;
                            // TotalIGSTAmt2 += IGSTAmt2;
                            // TotalSGSTAmt2 += SGSTAmt2;
                            //if PurchaseLine4."cgst amt" <> 0 then begin
                            PurchaseLine4."cgst amt":=CGSTAmt2;
                            PurchaseLine4."IGST Amt":=IGSTAmt2;
                            PurchaseLine4."IGST per":=IGSTPer2;
                            PurchaseLine4."CGST per":=cgstper2;
                            PurchaseLine4.modify(true);
                        until PurchaseLine4.Next() = 0;
                end;
                trigger OnAfterGetRecord()
                begin
                    visibility:=false;
                    if(sgstper = 0) and (Igstper = 0)then begin
                        visibility:=true end
                    else
                        visibility:=false;
                    //////
                    recsalescredmemoline.Reset();
                    recsalescredmemoline.SetRange("Document No.", SalesCrMemoHeader."No.");
                    recsalescredmemoline.SetFilter(Quantity, '=%1', 0);
                    if recsalescredmemoline.findfirst then repeat CMdocno:=recsalescredmemoline.Description;
                        until recsalescredmemoline.Next = 0;
                    ////
                    if SalesCrMemoLine.Quantity = 0 then CurrReport.skip;
                    slno:=SlNo + 1;
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
                    ///
                     //for Amt in words
                    // GrandTotal += TaxableAmt;// + Last(Fields!CGSTAmt.Value) + Last(Fields!IGSTAmt.Value) + Last(Fields!SGSTAmt.Value)
                    TotalSGSTAmt:=0;
                    TotalIGSTAmt:=0;
                    TotalCGSTAmount:=0;
                    AmtVendorTotal:=0;
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    If PurchaseLine.FindSet()then repeat Clear(CGSTAmt);
                            Clear(SGSTAmt);
                            Clear(IGSTAmt);
                            GetGSTAmount(PurchaseLine.RecordId);
                            AmtVendorTotal+=(CGSTAmt + SGSTAmt + IGSTAmt + PurchaseLine.Amount) - (PurchaseLine."Line Discount Amount") - (tdsTotal); //"Amount Including VAT"
                            TotalCGSTAmount+=CGSTAmt;
                            TotalIGSTAmt+=IGSTAmt;
                            TotalSGSTAmt+=SGSTAmt;
                        until PurchaseLine.Next() = 0;
                    InitTextVariable();
                    FormatNoText(NoText, Abs(AmtVendorTotal), SalesCrMemoHeader."Currency Code");
                    //
                    if SalesCrMemoHeader."Currency Code" = '' then INRorUSDorEURO:='INR'
                    else if SalesCrMemoHeader."Currency Code" = 'USD' then INRorUSDorEURO:='USD'
                        else if SalesCrMemoHeader."Currency Code" = 'EURO' then INRorUSDorEURO:='EURO';
                    ////////////////////////////////////////////////
                    PurchaseLine4.Reset();
                    PurchaseLine4.SetRange("Document No.", SalesCrMemoHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    If PurchaseLine4.Findset()then //begin
 repeat Clear(CGSTAmt2);
                            Clear(SGSTAmt2);
                            Clear(IGSTAmt2);
                            clear(IGSTPer2);
                            clear(cgstper2);
                            GetGSTAmount2(PurchaseLine4.RecordId);
                            //if PurchaseLine4."cgst amt" <> 0 then begin
                            PurchaseLine4."cgst amt":=CGSTAmt2;
                            PurchaseLine4."IGST Amt":=IGSTAmt2;
                            PurchaseLine4."IGST per":=IGSTPer2;
                            PurchaseLine4."CGST per":=cgstper2;
                            PurchaseLine4.modify(true);
                        until PurchaseLine4.Next() = 0;
                end;
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
                clear(custGST);
                reccust.Reset(); //SalesCrMemoHeader
                reccust.SetRange("No.", SalesCrMemoHeader."Buy-from Vendor No.");
                if reccust.FindFirst()then begin
                    custGST:=reccust."GST Registration No.";
                    // RecState.get(SalesCrMemoHeader.buy)
                    Statecode:=reccust."State Code" end;
                RecState.Reset();
                recstate.SetRange(Code, Statecode);
                if RecState.FindFirst()then statecode2:=RecState.Description;
                country.get(SalesCrMemoHeader."Buy-from Country/Region Code");
                countryname:=country.Name;
                country2.get(reccompanyInfo."Country/Region Code");
                ccountryname:=country2.Name;
                recstate2.reset;
                recstate2.SetRange(Code, reccompanyInfo."State Code");
                if recstate2.FindFirst()then statecode5:=recstate2.Description;
                /////////////////////////
                /////////////////////////////////
                Clear(exportdeclaration);
                if SalesCrMemoHeader."Currency Code" <> '' then exportdeclaration:=true
                else
                    exportdeclaration:=false;
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
            LayoutFile = './src/Report Layout/Posted Credit Note2.rdl';
        }
    }
    var recsalescredmemoline: Record 125;
    exportdeclaration: Boolean;
    CMdocno: text;
    ccountryname: text;
    recstate2: Record State;
    statecode5: text;
    RecState: Record state;
    Statecode: text;
    statecode2: text;
    country: Record "Country/Region";
    country2: Record "Country/Region";
    countryname: text;
    PurchaseLine7: Record 125;
    PurchaseLine4: Record 125;
    hidevalue: Boolean;
    hidevalue2: Boolean;
    visibility: Boolean;
    SlNo: Integer;
    PurchaseHeader: Record 124;
    TotalSGSTAmt: decimal;
    INRorUSDorEURO: Code[5];
    NoText: array[2]of text[150];
    TotalIGSTAmt: Decimal;
    TotalCGSTAmount: Decimal;
    AmtVendorTotal: Decimal;
    TdsPer: Decimal;
    TdsAmt: Decimal;
    custGST: code[20];
    PurchaseLine: Record 125;
    reccompanyInfo: Record "Company Information";
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
    reccust: Record 23;
    OnesText: array[20]of Text[30];
    TensText: array[10]of Text[30];
    ExponentText: array[5]of Text[30];
    NoTextAmt: ARRAY[2]OF Text[80];
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
    CGSTAmt2: Decimal;
    CGSTPer2: Decimal;
    SGSTAmt2: Decimal;
    SGSTPer2: Decimal;
    IGSTAmt2: Decimal;
    IGSTPer2: Decimal;
    local procedure GetGSTAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 125;
    begin
        if not GSTSetup.Get()then exit;
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst()then repeat if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt+=TaxTransactionValue.Amount;
                    CGSTPer:=TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt+=TaxTransactionValue.Amount;
                    SGSTPer:=TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt+=TaxTransactionValue.Amount;
                    IGSTPer:=TaxTransactionValue.Percent;
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
        if not GSTSetup.Get()then exit;
        Clear(tdsTotal);
        Clear(TotalTDSAmt);
        Clear(TdsAmt);
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", 'TDS');
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst()then repeat TdsAmt:=TaxTransactionValue.Amount;
                TotalTDSAmt:=Round(TdsAmt, 1, '=');
                TdsPer:=TaxTransactionValue.Percent;
            until TaxTransactionValue.Next() = 0;
    // tdsTotal := TotalTDSAmt;
    end;
    local procedure GetGSTAmount2(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 115;
    begin
        if not GSTSetup.Get()then exit;
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst()then repeat if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt2+=TaxTransactionValue.Amount;
                    CGSTPer2:=TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt2+=TaxTransactionValue.Amount;
                    SGSTPer2:=TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt2+=TaxTransactionValue.Amount;
                    IGSTPer2:=TaxTransactionValue.Percent;
                end;
            until TaxTransactionValue.Next() = 0;
    end;
    procedure InitTextVariable()
    begin
        OnesText[1]:=OneLbl;
        OnesText[2]:=TwoLbl;
        OnesText[3]:=ThreeLbl;
        OnesText[4]:=FourLbl;
        OnesText[5]:=FiveLbl;
        OnesText[6]:=SixLbl;
        OnesText[7]:=SevenLbl;
        OnesText[8]:=EightLbl;
        OnesText[9]:=NineLbl;
        OnesText[10]:=TenLbl;
        OnesText[11]:=ElevenLbl;
        OnesText[12]:=TwelveLbl;
        OnesText[13]:=ThireentLbl;
        OnesText[14]:=FourteenLbl;
        OnesText[15]:=FifteenLbl;
        OnesText[16]:=SixteenLbl;
        OnesText[17]:=SeventeenLbl;
        OnesText[18]:=EighteenLbl;
        OnesText[19]:=NinteenLbl;
        TensText[1]:='';
        TensText[2]:=TwentyLbl;
        TensText[3]:=ThirtyLbl;
        TensText[4]:=FortyLbl;
        TensText[5]:=FiftyLbl;
        TensText[6]:=SixtyLbl;
        TensText[7]:=SeventyLbl;
        TensText[8]:=EightyLbl;
        TensText[9]:=NinetyLbl;
        ExponentText[1]:='';
        ExponentText[2]:=ThousandLbl;
        ExponentText[3]:=LakhLbl;
        ExponentText[4]:=CroreLbl;
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1])do begin
            NoTextIndex:=NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText)then Error(exceededStringErr, AddText);
        end;
        NoText[NoTextIndex]:=DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
    procedure FormatNoText(var NoText: array[2]of Text[150]; No: Decimal; CurrencyCode: Code[10])
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
        NoTextIndex:=1;
        NoText[1]:='';
        if No < 1 then AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else
            for Exponent:=4 DOWNTO 1 do begin
                PrintExponent:=false;
                if No > 99999 then begin
                    Ones:=No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds:=0;
                end
                else
                begin
                    Ones:=No DIV Power(1000, Exponent - 1);
                    Hundreds:=Ones DIV 100;
                end;
                Tens:=(Ones MOD 100) DIV 10;
                Ones:=Ones MOD 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, HundreadLbl);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end
                else if(Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1)then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        end
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, RupeesLbl);
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndLbl);
        TensDec:=((No * 100) MOD 100) DIV 10;
        OnesDec:=(No * 100) MOD 10;
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end
        else if(TensDec * 10 + OnesDec) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl);
        if(CurrencyCode <> '')then AddToNoText(NoText, NoTextIndex, PrintExponent, OnlyLbl)
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, PaisaOnlyLbl);
    end;
    procedure HideShow2(DocNo: Code[20]): Boolean var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        SInvLine: Record 125;
    begin
        SInvLine.Reset();
        SInvLine.SetRange("Document No.", DocNo);
        if SInvLine.FindSet()then repeat if SInvLine."Line No." = 10000 then begin
                    TempPercent1:=SInvLine."Igst per";
                    TempPercent2:=SInvLine."Igst per";
                end
                else
                    TempPercent2:=SInvLine."Igst per";
                if TempPercent1 <> TempPercent2 then exit(true);
            until SInvLine.Next() = 0;
        exit(false);
    end;
    //////////////////////////////////////////
    procedure HideShow(DocNo: Code[20]): Boolean var
        TempPercent1: Decimal;
        TempPercent2: Decimal;
        SInvLine: Record 125;
    begin
        SInvLine.Reset();
        SInvLine.SetRange("Document No.", DocNo);
        if SInvLine.FindSet()then repeat if SInvLine."Line No." = 10000 then begin
                    TempPercent1:=SInvLine."CGST per";
                    TempPercent2:=SInvLine."CGST per";
                end
                else
                    TempPercent2:=SInvLine."CGST per";
                if TempPercent1 <> TempPercent2 then exit(true);
            until SInvLine.Next() = 0;
        exit(false);
    end;
}
