pageextension 50070 SalesLines extends "Sales Lines"
{
    layout
    {
        modify("Line Amount")
        {
            Caption = 'Line Amount Excl GST';
            Visible = false;

            trigger onaftervalidate()
            begin
            end;
        }
        addafter("No.")
        {
            field("Line Amount Excl. GST"; rec."Line Amount")
            {
                Caption = 'Line Amount Excl. GST';
                ApplicationArea = all;
                ToolTip = '';
                ShowCaption = true;
                CaptionClass = lebel1;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
    //   h."Amount Including VAT"
    end;
    var lebel1: Label 'Line Amount Excl. GST';
    l: Record 37;
    h: Record 36;
}
