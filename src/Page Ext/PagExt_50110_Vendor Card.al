pageextension 50110 "3KT Vendor Card" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("P.A.N. Reference No.")
        {
            field("MSME Vendor Type"; Rec."MSME Vendor Type")
            {
                ApplicationArea = All;
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

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}