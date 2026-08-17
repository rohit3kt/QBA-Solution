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

                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
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

                field(taxPercent; TaxPercent)
                {
                    Caption = 'Tax %';
                    Editable = false;
                }

                field(taxAmount; TaxAmount)
                {
                    Caption = 'Tax Amount';
                    Editable = false;
                }

                field(amountIncludingTax; AmountIncludingTax)
                {
                    Caption = 'Amount Including Tax';
                    Editable = false;
                }

                field(taxCalculationType; TaxCalculationType)
                {
                    Caption = 'Tax Calculation Type';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalculateTaxInformation();
    end;

    var
        TaxableAmount: Decimal;
        TaxPercent: Decimal;
        TaxAmount: Decimal;
        AmountIncludingTax: Decimal;
        TaxCalculationType: Text;

    local procedure CalculateTaxInformation()
    begin
        Clear(TaxableAmount);
        Clear(TaxPercent);
        Clear(TaxAmount);
        Clear(AmountIncludingTax);
        Clear(TaxCalculationType);

        // Only Purchase Orders
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        // Taxable amount
        TaxableAmount := Rec.Amount;

        // VAT/GST percentage
        TaxPercent := Rec."VAT %";

        // Amount including VAT/GST
        AmountIncludingTax := Rec."Amount Including VAT";

        // Tax amount
        TaxAmount := AmountIncludingTax - TaxableAmount;

        // Tax calculation type
        TaxCalculationType := Format(Rec."VAT Calculation Type");
    end;
}