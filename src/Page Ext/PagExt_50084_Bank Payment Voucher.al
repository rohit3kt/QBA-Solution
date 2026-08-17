pageextension 50084 bankpaymentvou extends "Bank Payment Voucher"
{
    layout
    {
        // modify(Comments)
        // {
        //     Caption = 'Remarks';
        // }
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
