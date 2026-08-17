pageextension 50009 SalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        modify("Unit Price")
        {
            CaptionClass = label1;
            ApplicationArea = all;
        }
        modify("Line Amount")
        {
            CaptionClass = label1;
            ApplicationArea = all;
        }
        modify("Total Amount Excl. VAT")
        {
            Caption = 'Total Amount Excl. GST';
            CaptionClass = l3;
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionClass = l4;
            Caption = 'Total Amount Incl. GST';
            Visible = false;
        }
        modify("TotalSalesLine.""Line Amount""")
        {
            CaptionClass = l5;
        }
        modify("Invoice Discount Amount")
        {
            CaptionClass = l6;
        }
        modify("Total VAT Amount")
        {
            // Caption = 'Total GST(INR)';
            // CaptionClass = l7;
            Visible = false;
        }
        addafter("Total Amount Excl. VAT")
        {
            field("Total GST(INR)"; TotalCGSTAmount + TotalSGSTAmt + TotalIGSTAmt)
            {
                ApplicationArea = all;
                Caption = 'Total GST';
            }
            field("Total Amount Including GST"; TotalCGSTAmount + TotalSGSTAmt + TotalIGSTAmt + Rec."Amount Including VAT")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("Description2"; Rec."Description 2")
            {
                ApplicationArea = all;
                Caption = 'Description 2';
            }
            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        TotalSGSTAmt:=0;
        TotalIGSTAmt:=0;
        TotalCGSTAmount:=0;
        AmtVendorTotal:=0;
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSTAmt);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", Rec."Document No.");
        If PurchaseLine.FindSet()then repeat GetGSTAmount(PurchaseLine.RecordId);
                TotalCGSTAmount+=CGSTAmt;
                TotalIGSTAmt+=IGSTAmt;
                TotalSGSTAmt+=SGSTAmt;
            until PurchaseLine.Next() = 0;
    end;
    var tdsTotal: Decimal;
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
    recpurline9: Record 37;
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
    var recline: Record 37;
    var label1: Label 'Unit Price Excl. GST';
    label2: label 'Line Amount Excl. GST';
    l3: Label 'Total Amount Excl. GST';
    l4: Label 'Total Amount Incl. GST';
    l5: Label 'Subtotal Excl. GST(INR)';
    l6: Label 'Inv. Discount Amount Excl. GST (INR)';
    l7: label 'Total GST(INR)';
}
