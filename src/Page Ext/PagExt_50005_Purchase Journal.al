pageextension 50005 PurchaseJournal extends "Purchase Journal"
{
    layout
    {
        // modify(Comment)
        // {
        //     Caption = 'Remarks';
        // }
        addafter(ShortcutDimCode8)
        {
            field(Comment_; Rec.Comment)
            {
                Caption = 'Remarks';
                ApplicationArea = all;
            }
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
