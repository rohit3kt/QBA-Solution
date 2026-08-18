page 50029 "QBAAPIV2 - Purchase Order Tax"
{
    PageType = API;

    APIPublisher = 'QBA';
    APIGroup = 'Agentic';
    APIVersion = 'v2.0';

    EntityCaption = 'Purchase Order Tax';
    EntitySetCaption = 'Purchase Order Taxes';

    EntityName = 'purchaseOrderTax';
    EntitySetName = 'purchaseOrderTaxes';

    SourceTable = "Purchase Line";

    ODataKeyFields = SystemId;

    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }

                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                }

                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                }

                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    Editable = false;
                }

                field(itemNo; Rec."No.")
                {
                    Caption = 'Item No.';
                    Editable = false;
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }

                field(taxableAmount; TaxableAmount)
                {
                    Caption = 'Taxable Amount';
                    Editable = false;
                }

                field(cgstPercentage; CGSTPer)
                {
                    Caption = 'CGST Percentage';
                    Editable = false;
                }

                field(cgstAmount; CGSTAmt)
                {
                    Caption = 'CGST Amount';
                    Editable = false;
                }

                field(sgstPercentage; SGSTPer)
                {
                    Caption = 'SGST Percentage';
                    Editable = false;
                }

                field(sgstAmount; SGSTAmt)
                {
                    Caption = 'SGST Amount';
                    Editable = false;
                }

                field(igstPercentage; IGSTPer)
                {
                    Caption = 'IGST Percentage';
                    Editable = false;
                }

                field(igstAmount; IGSTAmt)
                {
                    Caption = 'IGST Amount';
                    Editable = false;
                }

                field(totalCGSTAmount; TotCGSTAmt)
                {
                    Caption = 'Total CGST Amount';
                    Editable = false;
                }

                field(totalSGSTAmount; TotSGSTAmt)
                {
                    Caption = 'Total SGST Amount';
                    Editable = false;
                }

                field(totalIGSTAmount; TotIGSTAmt)
                {
                    Caption = 'Total IGST Amount';
                    Editable = false;
                }

                field(totalGST; TotalGST)
                {
                    Caption = 'Total GST';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ClearTaxVariables();
        CalculateTaxInformation();
    end;

    var
        TaxableAmount: Decimal;

        TotSGSTAmt: Decimal;
        TotCGSTAmt: Decimal;
        TotIGSTAmt: Decimal;

        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;

        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;

        TotalGST: Decimal;

    local procedure ClearTaxVariables()
    begin
        Clear(TaxableAmount);

        Clear(TotSGSTAmt);
        Clear(TotCGSTAmt);
        Clear(TotIGSTAmt);

        Clear(CGSTPer);
        Clear(SGSTPer);
        Clear(IGSTPer);

        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSTAmt);

        Clear(TotalGST);
    end;

    local procedure CalculateTaxInformation()
    var
        GSTSetup: Record "GST Setup";
    begin
        TaxableAmount := Rec."Line Amount";

        if not GSTSetup.Get() then
            exit;

        GetGSTAmounts(Rec, GSTSetup);
    end;

    local procedure GetGSTAmounts(
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup")
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseInvoiceGST: Report "Purchase - Invoice GST";
        ComponentName: Code[30];
        RoundedAmount: Decimal;
    begin
        if PurchaseLine.Type = PurchaseLine.Type::" " then
            exit;

        ComponentName := GetComponentName(PurchaseLine, GSTSetup);

        TaxTransactionValue.Reset();

        TaxTransactionValue.SetRange(
            "Tax Record ID",
            PurchaseLine.RecordId);

        TaxTransactionValue.SetRange(
            "Tax Type",
            GSTSetup."GST Tax Type");

        TaxTransactionValue.SetRange(
            "Value Type",
            TaxTransactionValue."Value Type"::COMPONENT);

        TaxTransactionValue.SetFilter(
            Percent,
            '<>%1',
            0);

        if not TaxTransactionValue.FindSet() then
            exit;

        repeat
            RoundedAmount :=
                Round(
                    TaxTransactionValue.Amount,
                    PurchaseInvoiceGST.GetGSTRoundingPrecision(
                        ComponentName));

            case TaxTransactionValue."Value ID" of

                // CGST
                2:
                    begin
                        CGSTAmt += RoundedAmount;
                        TotCGSTAmt += RoundedAmount;
                        CGSTPer := TaxTransactionValue.Percent;
                    end;

                // SGST
                6:
                    begin
                        SGSTAmt += RoundedAmount;
                        TotSGSTAmt += RoundedAmount;
                        SGSTPer := TaxTransactionValue.Percent;
                    end;

                // IGST
                3:
                    begin
                        IGSTAmt += RoundedAmount;
                        TotIGSTAmt += RoundedAmount;
                        IGSTPer := TaxTransactionValue.Percent;
                    end;
            end;

        until TaxTransactionValue.Next() = 0;

        TotalGST :=
            TotCGSTAmt +
            TotSGSTAmt +
            TotIGSTAmt;
    end;

    local procedure GetComponentName(
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup"): Code[30]
    begin
        if PurchaseLine."GST Jurisdiction Type" =
           PurchaseLine."GST Jurisdiction Type"::Interstate then
            exit('IGST');

        exit('CGST');
    end;
}