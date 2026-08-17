pageextension 50062 PurchaseOrderArchives extends "Purchase Order Archives"
{
    layout
    {
        addafter("Location Code")
        {
            field(TotGSTamt; TotalCGSTAmount + TotalIGSTAmt + TotalSGSTAmt)
            {
                Caption = 'GST Amount';
                ApplicationArea = all;
            }
            field(TotalTDSAmt; TotalTDSAmt)
            {
                Caption = 'TDS Amount';
                ApplicationArea = all;
            }
        }
    }
    var tdsTotal: Decimal;
    purchaseLine6: Record 39;
    RecID: RecordID;
    TotalCGSTAmount: Decimal;
    AmtVendorTotal: Decimal;
    TotalSGSTAmt: Decimal;
    TotalIGSTAmt: Decimal;
    TermDesc: text[150];
    Sub55: Text[500];
    // recTerms: Record 50073;
    test: Record "Tax Transaction Value";
    test2: BigText;
    blobcomment2: text[500];
    //  commentBLOB4: Record 50078;
    recPurHeader9: Record "Purchase Header";
    recpurline9: Record 39;
    //  commentBLOB2: Record 50078;// "Comment Blob";
    //  commentBLOB3: Record 50078;
    PurCommentLine: Record 43;
    Subject: Text[500];
    // LineComment: blob;
    reportcheck: Report Check;
    blobcomment: text;
    amtinwords: array[2]of text[250];
    GrandTotal: Decimal;
    RecVLE: Record "Vendor Ledger Entry";
    GSTPerVar: Decimal;
    Vendor: Record Vendor;
    Qty: Decimal;
    UnitPrice: Decimal;
    Salesperson: Record "Salesperson/Purchaser";
    SalespersonText: Text[50];
    Amount_: Decimal;
    purchaseLine: Record 39;
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
    RepCheck: array[2]of Report Check;
    NoTextExcise: array[2]of Text[80];
    NoText: array[2]of Text[80];
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
    PurchLine: Record 39;
    PurchaeHeaderRec: Record "Purchase Header";
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
    ChequeNoLbl: Label 'Cheque No: ';
    DateLbl: Label 'Date: ';
    HundreadLbl: Label 'HUNDRED';
    AndLbl: Label 'AND';
    ExceededStringErr: Label '%1 results in a written number that is too long.', Comment = '%1= AddText';
    tdsentry: Record "TDS Entry";
    fs: Record "FA Ledger Entry";
    trigger OnAfterGetRecord()
    begin
        Clear(TotalSGSTAmt);
        purchaseLine6.Reset();
        purchaseLine6.SetRange("Document No.", rec."No.");
        if purchaseLine6.FindFirst()then begin
            DetailedGSTLedgerEntry.reset;
            DetailedGSTLedgerEntry.SetRange("Document No.", purchaseLine6."Document No.");
            DetailedGSTLedgerEntry.SetRange("Document Line No.", purchaseLine6."Line No.");
            if DetailedGSTLedgerEntry.FindFirst()then begin
                if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then repeat TotalSGSTAmt+=DetailedGSTLedgerEntry."GST Amount";
                    until DetailedGSTLedgerEntry.Next() = 0
                else if DetailedGSTLedgerEntry."GST Component Code" <> 'IGST' then repeat TotalSGSTAmt+=(DetailedGSTLedgerEntry."GST Amount");
                        until DetailedGSTLedgerEntry.Next() = 0;
            end;
        end;
        //tds
        Clear(TotalTDSAmt);
        tdsentry.Reset();
        tdsentry.SetRange("Document No.", Rec."No.");
        if tdsentry.findfirst then TotalTDSAmt:=tdsentry."TDS Amount";
    end;
    local procedure GetTDSAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "TDS Setup"; //"GST Setup";
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
            until TaxTransactionValue.Next() = 0;
    // tdsTotal := TotalTDSAmt;
    end;
}
