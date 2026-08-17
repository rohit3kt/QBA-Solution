pageextension 50097 PostedSalesCrMemoSubform extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Total Amount Incl. VAT")
        {
            field(TotalGST; TotalCGSTAmount + TotalSGSTAmt + TotalIGSTAmt)
            {
                Caption = 'Total GST Amount';
                ApplicationArea = all;
            }
            field(TotalAmountInclGST; TotalCGSTAmount + TotalSGSTAmt + TotalIGSTAmt + TotalLineAmount)
            {
                Caption = 'Total Amount Including GST';
                ApplicationArea = all;
            }
        //  field(Rec;Rec."Amount Including VAT")
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
        // modify("TotalSalesLine.""Line Amount""")
        // {
        //     CaptionClass = l5;
        // }
        modify("Invoice Discount Amount")
        {
            CaptionClass = l6;
        }
    }
    var label1: Label 'Unit Price Excl. GST';
    label2: label 'Line Amount Excl. GST';
    l3: Label 'Total Amount Excl. GST';
    l4: Label 'Total Amount Incl. GST';
    l5: Label 'Subtotal Excl. GST(INR)';
    l6: Label 'Inv. Discount Amount Excl. GST (INR)';
    l7: label 'Total GST(INR)';
    DisAmt: Decimal;
    CGSTPer: Decimal;
    CGSTAmt: Decimal;
    SGSTPer: Decimal;
    SGSTAmt: Decimal;
    IGSTPer: Decimal;
    IGSTAmt: Decimal;
    Totalfin: Decimal;
    TotalSGSTAmt: Decimal;
    TotalIGSTAmt: Decimal;
    TotalCGSTAmount: Decimal;
    AmtVendorTotal: Decimal;
    PurchaseLine: Record 115;
    TotalGST: Decimal;
    TotalLineAmount: Decimal;
    trigger OnAfterGetCurrRecord()
    var
    begin
        TotalLineAmount:=0;
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
                TotalLineAmount+=PurchaseLine."Line Amount";
            until PurchaseLine.Next() = 0;
    // TotalGST := TotalCGSTAmount + TotalCGSTAmount + TotalSGSTAmt;
    end;
    local procedure GetGSTAmount(RecID: RecordID)
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
}
