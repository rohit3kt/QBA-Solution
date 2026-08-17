pageextension 50074 PostedPurchaseInvoicelines extends "Posted Purchase Invoice Lines"
{
    layout
    {
        modify("Direct Unit Cost")
        {
            CaptionClass = label1;
        }
        modify(Amount)
        {
            CaptionClass = label2;
            Caption = 'Amount Including GST';
        }
    }
    var label1: Label 'Direct Unit Cost Excl. GST';
    label2: label 'Amount Including GST';
}
