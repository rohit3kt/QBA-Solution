pageextension 50069 PurchaseLines extends "Purchase Lines"
{
    layout
    {
        modify("Direct Unit Cost")
        {
            Caption = 'Direct Unit Cost Excl. GST';
            CaptionClass = label1;
        }
        modify("Line Amount")
        {
            Caption = 'Line Amount Excl. GST';
            CaptionClass = label2;
        }
    }
    var label1: Label 'Direct Unit Cost Excl. GST';
    label2: label 'Line Amount Excl. GST';
}
