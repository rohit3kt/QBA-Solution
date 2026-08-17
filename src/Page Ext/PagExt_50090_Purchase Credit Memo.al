pageextension 50090 PurchaseCreditMemo extends "Purchase Credit Memo"
{
    actions
    {
        addafter(Post)
        {
            action(DebititNote)
            {
                Caption = 'Print Debit Note';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                PromotedIsBig = true;
                Image = Print;

                trigger OnAction()
                begin
                    RecSalCreditMemoHeader.Reset();
                    RecSalCreditMemoHeader.SetRange("No.", rec."No.");
                    if RecSalCreditMemoHeader.FindFirst()then Report.Run(50005, true, false, RecSalCreditMemoHeader);
                end;
            }
        }
    }
    var RecSalCreditMemoHeader: Record 38;
}
