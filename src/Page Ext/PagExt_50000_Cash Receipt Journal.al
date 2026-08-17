pageextension 50000 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        modify(Comments)
        {
            Caption = 'Remarks';
        }
        addafter(Amount)
        {
            field("CreditAmount"; Rec."Credit Amount")
            {
                Caption = 'Credit Amount';
                ApplicationArea = all;
            }
            field("DebitAmount"; Rec."Debit Amount")
            {
                Caption = 'Debit Amount';
                ApplicationArea = all;
            }
        }
    }
}
