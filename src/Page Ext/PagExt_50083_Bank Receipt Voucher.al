pageextension 50083 bankrecvou extends "Bank Receipt Voucher"
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
        // recVounarration.Reset();
        // recVounarration.SetRange("Document No.", rec."Document No.");
        // if recVounarration.FindFirst() then
        //     Rec."Voucher Narration" := recVounarration.Narration;
        // Rec.Modify();
        // CurrPage.Update();
        // //
        // reclinenarration.Reset();
        // reclinenarration.SetRange("Document No.", rec."Document No.");
        // if reclinenarration.FindFirst() then
        //     rec."Line Narration" := reclinenarration.Narration;
        // rec.Modify();
        // CurrPage.Update();
    end;

    var
        recVounarration: Record "Gen. Journal Narration";
        reclinenarration: Record "Gen. Journal Narration";
}
