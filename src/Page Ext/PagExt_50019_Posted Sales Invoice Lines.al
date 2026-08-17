pageextension 50019 PostedSalesInvoiceLines extends "Posted Sales Invoice Lines"
{
    layout
    {
        // modify(Amount)
        // {
        //     CaptionClass = label;
        // }
        modify("Amount Including VAT")
        {
            CaptionClass = label;
        }
        modify("Unit Price")
        {
            CaptionClass = label2;
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
    var label: label 'Line Amount Excl. GST';
    label2: label 'Unit Price Excl. GST';
}
