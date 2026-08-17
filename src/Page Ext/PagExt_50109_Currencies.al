pageextension 50109 "QBA Currencies" extends Currencies
{
    layout
    {
        // Add changes to page layout here
        addafter("ISO Numeric Code")
        {
            field("Currency Numeric Description"; Rec."Currency Numeric Description")
            {
                ApplicationArea = All;
            }
            field("Currency Decimal Description"; Rec."Currency Decimal Description")
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