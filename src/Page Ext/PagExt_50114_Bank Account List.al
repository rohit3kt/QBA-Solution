pageextension 50114 "QBA Bank Account List" extends "Bank Account List"
{
    layout
    {
        // Add changes to page layout here
        modify("Bank Account No.")
        {
            Visible = true;
        }
        moveafter(Name; "Bank Account No.")
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}