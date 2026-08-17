pageextension 50072 PostedPurchaseInvSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        modify("Direct Unit Cost")
        {
            CaptionClass = label1;
            Caption = 'Direct Unit Cost Excl. GST';
            Visible = false;
        }
        modify("Total VAT Amount")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            CaptionClass = label2;
            Caption = 'Line Amount Excl. GST';
            Visible = false;
        }
        modify("Total Amount Excl. VAT")
        {
            //Visible=fal
            CaptionClass = l3;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = false;
        }
        addafter("Invoice Discount Amount")
        {
            field(Testing; Rec.Amount)
            {
                ApplicationArea = all;
                Caption = 'Amount Excl. GST';
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
    var label1: label 'Direct Unit Cost Excl. GST';
    label2: label 'Line Amount Excl. GST';
    l3: Label 'Total Amount Excl. GST';
}
