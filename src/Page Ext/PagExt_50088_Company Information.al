pageextension 50088 Company_Information extends "Company Information"
{
    layout
    {
        addafter("Company Status")
        {
            field("MSME Vendor Type"; Rec."MSME Vendor Type")
            {
                ApplicationArea = all;
            }
            field("MSME Type"; Rec."MSME Type")
            {
                ApplicationArea = all;
            }
            field("MSME No."; Rec."MSME No.")
            {
                ApplicationArea = all;
            }
            field("IEC No."; Rec."IEC No.")
            {
                ApplicationArea = all;
                caption = 'IEC No.';
            }
            field(CIN; Rec.CIN)
            {
                ApplicationArea = all;
            }
            field("Clear All Record"; Rec."Clear All Record")
            {
                ApplicationArea = All;
            }
        }
        addafter(Picture)
        {
            field(Picture2; Rec.Picture2)
            {
                Caption = 'Letter Headr Picture';
                ApplicationArea = all;
            }
        }
        modify(Picture)
        {
            Caption = 'Company Logo Picture';
        }
    }
}
