pageextension 50014 "QBA Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("ARN No.")
        {
            field("TDS Note"; Rec."TDS Note")
            {
                Caption = 'TDS Note';
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