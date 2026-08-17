pageextension 50012 SalesInvoiceSubform extends "Sales Invoice Subform"
{
    layout
    {
        modify("Unit Price")
        {
            CaptionClass = label1;
        }
        modify("Line Amount")
        {
            CaptionClass = label2;
        }
        modify("Total Amount Excl. VAT")
        {
            Caption = 'Total Amount Excl. GST';
            CaptionClass = l3;
        }
        // modify("Total Amount Incl. VAT")
        // {
        //     CaptionClass = l4;
        //     Caption = 'Total Amount Incl. GST';
        // }
        modify("TotalSalesLine.""Line Amount""")
        {
            CaptionClass = l5;
        }
        modify("Invoice Discount Amount")
        {
            CaptionClass = l6;
        }
        // modify("Total VAT Amount")
        // {
        //     CaptionClass = l7;
        // }
        addafter("Total VAT Amount")
        {
            field("Total GST Amount"; TotalGST)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("Description2"; Rec."Description 2")
            {
                ApplicationArea = all;
                Caption = 'Description 2';
            }
        }
    }
    var label1: Label 'Unit Price Excl. GST';
    label2: label 'Line Amount Excl. GST';
    l3: Label 'Total Amount Excl. GST';
    l4: Label 'Total Amount Incl. GST';
    l5: Label 'Subtotal Excl. GST(INR)';
    l6: Label 'Inv. Discount Amount Excl. GST (INR)';
    l7: label 'Total GST Amount';
    CGSTAmt: Decimal;
    CGSTPer: Decimal;
    SGSTAmt: Decimal;
    SGSTPer: Decimal;
    IGSTAmt: Decimal;
    IGSTPer: Decimal;
    PurchaseLine: Record 37;
    TotalCGSTAmount: Decimal;
    TotalIGSTAmt: Decimal;
    TotalSGSTAmt: Decimal;
    TotalGST: Decimal;
    trigger OnAfterGetRecord()
    begin
        TotalSGSTAmt:=0;
        TotalIGSTAmt:=0;
        TotalCGSTAmount:=0;
        // AmtVendorTotal := 0;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", rec."Document No.");
        // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        If PurchaseLine.FindSet()then repeat Clear(CGSTAmt);
                Clear(SGSTAmt);
                Clear(IGSTAmt);
                GetGSTAmount(PurchaseLine.RecordId);
                // AmtVendorTotal += (CGSTAmt + SGSTAmt + IGSTAmt + PurchaseLine.Amount) - (PurchaseLine."Line Discount Amount") - (tdsTotal);//"Amount Including VAT"
                TotalCGSTAmount+=CGSTAmt;
                TotalIGSTAmt+=IGSTAmt;
                TotalSGSTAmt+=SGSTAmt;
                TotalGST:=CGSTAmt + SGSTAmt + IGSTAmt;
            until PurchaseLine.Next() = 0;
    end;
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
}
