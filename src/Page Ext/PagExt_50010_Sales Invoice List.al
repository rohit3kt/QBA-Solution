pageextension 50010 SalesInvoices extends "Sales Invoice List"
{
    layout
    {
        addafter(Amount)
        {
            field(GSTamount; CGSTAmt + SGSTAmt + IGSTAmt)
            {
                Caption = 'GST Amount';
                ApplicationArea = all;
            }
            field(TDSamount; TotalTDSAmt)
            {
                Caption = 'TDS Amount';
                ApplicationArea = all;
            }
            field(NetTotal; rec.Amount + CGSTAmt + SGSTAmt + IGSTAmt - TotalTDSAmt)
            {
                Caption = 'Net Total';
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        TotalSGSTAmt:=0;
        TotalIGSTAmt:=0;
        TotalCGSTAmount:=0;
        AmtVendorTotal:=0;
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSTAmt);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", Rec."No.");
        If PurchaseLine.FindSet()then repeat GetGSTAmount(PurchaseLine.RecordId);
                AmtVendorTotal+=(CGSTAmt + SGSTAmt + IGSTAmt + PurchaseLine."Amount Including VAT") - (PurchaseLine."Line Discount Amount");
                TotalCGSTAmount+=CGSTAmt;
                TotalIGSTAmt+=IGSTAmt;
                TotalSGSTAmt+=SGSTAmt;
            until PurchaseLine.Next() = 0;
    end;
    var gst: Record "GST Ledger Entry";
    GSTamount: Decimal;
    TDSamount: Decimal;
    NetTotal: Decimal;
    tdsTotal: Decimal;
    purchaseLine6: Record 37;
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
    purchaseLine: Record 37;
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
    PurchLine: Record 37;
    PurchaeHeaderRec: Record "Purchase Header";
    local procedure GetGSTAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 37;
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
            until TaxTransactionValue.Next() = 0;
    end;
}
