pageextension 50092 LocationCard extends "Location Card"
{
    layout
    {
        addafter("GST Registration No.")
        {
            field(CIN; Rec.CIN)
            {
                ApplicationArea = all;
            }
            field("MSME Type"; Rec."MSME Type")
            {
                ApplicationArea = All;
            }
            field("MSME No."; Rec."MSME No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
