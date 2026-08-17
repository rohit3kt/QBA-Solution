pageextension 50015 PurchaseOrdersubform2 extends "Purchase Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Description2"; Rec."Description 2")
            {
                ApplicationArea = all;
                Caption = 'Description 2';
            }
        }
        addafter("Location Code")
        {
            field(Amount_; Rec.Amount)
            {
                Caption = 'Amount';
                ApplicationArea = all;
            }
        }
        modify("Line Amount")
        {
            Caption = 'Line Amount Excl. GST';
            CaptionClass = label3;
        }
        modify("Direct Unit Cost")
        {
            Caption = 'Direct Unit Cost Excl. GST';
            CaptionClass = label4;
        }
        addafter("Direct Unit Cost")
        {
            field("Total GST(INR)"; Total_GST_INR)
            {
                ApplicationArea = all;
                Caption = 'Total GST(INR)';
            }
            field("Total Amount Including GST"; Total_Amt_Inc_GST)
            {
                ApplicationArea = all;
            }
        }
        addafter("Over-Receipt Code")
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
        }

    }
    var
        label1: Label 'Total Amount Excl. GST';
        label2: Label 'Total Amount Incl. GST';
        label3: label 'Line Amount Excl. GST';
        label4: label 'Direct Unit Cost Excl. GST';
        l7: Label 'Total GST(INR)';
        l5: Label 'Subtotal Including GST';

    trigger OnAfterGetRecord()
    var
    begin
        Clear(Total_GST_INR);
        Clear(Total_Amt_Inc_GST);

        if Rec.Type <> Rec.Type::" " then begin
            Total_GST_INR := GetGSTAmounts(Rec);
            Total_Amt_Inc_GST := GetGSTAmounts(Rec) + Rec."Line Amount";
        end;
    end;

    var

        PurchaseLine: Record "Purchase Line";
        Total_GST_INR: Decimal;
        Total_Amt_Inc_GST: Decimal;
        CompInfo: Record "Company Information";
        CGSTPer: Decimal;
        CGSTAmt: Decimal;
        SGSTPer: Decimal;
        SGSTAmt: Decimal;
        IGSTPer: Decimal;
        IGSTAmt: Decimal;
        GSTLbl: Label 'GST';
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        GSTCESSLbl: Label 'GST CESS';
    //Totalfin: Decimal;
    //PurchaeHeaderRec: Record "Purchase Header";

    // local procedure GetGSTAmount(RecID: RecordID): Decimal
    // var
    //     TaxTransactionValue: Record "Tax Transaction Value";
    //     GSTSetup: Record "GST Setup";
    // begin
    //     ClearVariable();
    //     if not GSTSetup.Get() then
    //         exit;

    //     TaxTransactionValue.SetRange("Tax Record ID", RecID);
    //     TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
    //     if GSTSetup."Cess Tax Type" <> '' then
    //         TaxTransactionValue.SetRange("Tax Type", GSTSetup."Cess Tax Type")
    //     else
    //         TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
    //     TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
    //     if TaxTransactionValue.FindSet() then
    //         repeat
    //             if TaxTransactionValue."Value ID" = 2 then begin
    //                 CGSTAmt += TaxTransactionValue.Amount;
    //                 CGSTPer := TaxTransactionValue.Percent;
    //             end;
    //             if TaxTransactionValue."Value ID" = 6 then begin
    //                 SGSTAmt += TaxTransactionValue.Amount;
    //                 SGSTPer := TaxTransactionValue.Percent;
    //             end;
    //             if TaxTransactionValue."Value ID" = 3 then begin
    //                 IGSTAmt += TaxTransactionValue.Amount;
    //                 IGSTPer := TaxTransactionValue.Percent;
    //             end;
    //         until TaxTransactionValue.Next() = 0;
    //     exit(CGSTAmt + SGSTAmt + IGSTAmt);
    // end;


    local procedure GetGSTAmounts(PurchaseLine: Record "Purchase Line"): Decimal
    var
        ComponentName: Code[30];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTPurchaseInvoice: Report "Purchase - Invoice GST";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        ComponentName := GetComponentName(PurchaseLine, GSTSetup);
        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
                                //TotSGSTAmt += SGSTAmt;
                                SGSTPER := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
                                //TotCGSTAmt += CGSTAmt;
                                CGSTPER := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
                                //TotIGSTAmt += IGSTAmt;
                                IGSTPER := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
        exit(CGSTAmt + SGSTAmt + IGSTAmt);
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
           GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    local procedure ClearVariable()
    begin
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSTAmt);
        Clear(CGSTPer);
        Clear(SGSTPer);
        Clear(IGSTPer);
    end;
}
