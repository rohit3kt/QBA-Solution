page 50010 "QBAAPIV2-Sale Order Lines Test"
{
    APIVersion = 'v2.0';
    EntityCaption = 'Sales Order Line';
    EntitySetCaption = 'Sales Order Lines';
    APIPublisher = 'QBA';
    APIGroup = 'Agentic';
    PageType = API;
    ODataKeyFields = SystemId;
    EntityName = 'QBAsalesOrderLine';
    EntitySetName = 'QBAsalesOrderLines';
    SourceTable = "Sales Line Staging";
    Extensible = false;
    DelayedInsert = true;
    AboutText = 'Exposes detailed sales order line data including item, variant, location, quantity, pricing, discounts, tax amounts, and shipment dates. Supports full CRUD operations to create, update, and delete individual order lines, enabling seamless integration with external web shops, marketplaces, and CRM systems for dynamic order capture and synchronization. Integrates with related entities such as sales orders, items, units of measure, and inventory to ensure accurate pricing and availability during order processing.';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(documentId; Rec."Document Id")
                {
                    Caption = 'Document Id';

                }
                field(sequence; Rec."Line No.")
                {
                    Caption = 'Sequence';

                }
                field(itemId; Rec."Item Id")
                {
                    Caption = 'Item Id';

                }
                field(accountId; Rec."Account Id")
                {
                    Caption = 'Account Id';

                }
                field(lineType; Rec."API Type")
                {
                    Caption = 'Line Type';
                }
                field(lineObjectNumber; Rec."No.")
                {
                    Caption = 'Line Object No.';


                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';

                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';

                }
                field(unitOfMeasureId; Rec."Unit of Measure Id")
                {
                    Caption = 'Unit Of Measure Id';

                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit Of Measure Code';

                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';

                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';

                }
                field(discountAmount; Rec."Line Discount Amount")
                {
                    Caption = 'Discount Amount';

                }
                field(discountPercent; Rec."Line Discount %")
                {
                    Caption = 'Discount Percent';
                }
                field(discountAppliedBeforeTax; Rec."Discount Applied Before Tax")
                {
                    Caption = 'Discount Applied Before Tax';
                    Editable = false;
                }
                field(amountExcludingTax; Rec."Line Amount Excluding Tax")
                {
                    Caption = 'Amount Excluding Tax';
                    Editable = false;
                }
                field(taxCode; Rec."Tax Code")
                {
                    Caption = 'Tax Code';
                }
                field(taxPercent; Rec."VAT %")
                {
                    Caption = 'Tax Percent';
                    Editable = false;
                }
                field(totalTaxAmount; Rec."Line Tax Amount")
                {
                    Caption = 'Total Tax Amount';
                    Editable = false;
                }
                field(amountIncludingTax; Rec."Line Amount Including Tax")
                {
                    Caption = 'Amount Including Tax';
                    Editable = false;
                }
                field(invoiceDiscountAllocation; Rec."Inv. Discount Amount Excl. VAT")
                {
                    Caption = 'Invoice Discount Allocation';
                    Editable = false;
                }
                field(netAmount; Rec.Amount)
                {
                    Caption = 'Net Amount';
                    Editable = false;
                }
                field(netTaxAmount; Rec."Tax Amount")
                {
                    Caption = 'Net Tax Amount';
                    Editable = false;
                }
                field(netAmountIncludingTax; Rec."Amount Including VAT")
                {
                    Caption = 'Net Amount Including Tax';
                    Editable = false;
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';

                }
                field(shippedQuantity; Rec."Quantity Shipped")
                {
                    Caption = 'Shipped Quantity';
                }
                field(invoicedQuantity; Rec."Quantity Invoiced")
                {
                    Caption = 'Invoiced Quantity';

                }
                field(invoiceQuantity; Rec."Qty. to Invoice")
                {
                    Caption = 'Invoice Quantity';

                }
                field(shipQuantity; Rec."Qty. to Ship")
                {
                    Caption = 'Ship Quantity';

                }
                field(itemVariantId; Rec."Variant Id")
                {
                    Caption = 'Item Variant Id';
                }
                field(locationId; Rec."Location Id")
                {
                    Caption = 'Location Id';

                }
            }
        }
    }
}