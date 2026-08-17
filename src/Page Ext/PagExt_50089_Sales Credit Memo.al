pageextension 50089 SalesCreditMemo extends "Sales Credit Memo"
{
    actions
    {
        addafter(Post)
        {
            action(CreditNote)
            {
                Caption = 'Print Credit Note';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RecSalCreditMemoHeader.Reset();
                    RecSalCreditMemoHeader.SetRange("No.", rec."No.");
                    if RecSalCreditMemoHeader.FindFirst() then
                        Report.Run(50001, true, false, RecSalCreditMemoHeader);
                end;
            }
        }
    }
    var
        RecSalCreditMemoHeader: Record 36;
}
