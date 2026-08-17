pageextension 50082 CashPaymentVoucher extends "Cash Payment Voucher"
{
    layout
    {
        modify(Comment)
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
    trigger OnAfterGetCurrRecord()
    begin
        // recnarration.Reset();
        // recnarration.SetRange("Document No.", rec."Document No.");
        // if recnarration.FindFirst() then
        //     Rec.Comment := recnarration.Narration;
        // Rec.Modify();
        // CurrPage.Update();
    end;

    var
        recnarration: Record "Gen. Journal Narration";
        narration: Record "Gen. Journal Narration";
}
