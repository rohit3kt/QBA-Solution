pageextension 50094 PostedSalesCreditMemo extends "Posted Sales Credit Memo"
{
    actions
    {
        addafter(Print)
        {
            action("Print Credit Memo")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                var
                    RecSalesCrMemo: Record "Sales Cr.Memo Header";
                begin
                    RecSalesCrMemo.Reset();
                    RecSalesCrMemo.SetRange("No.", Rec."No.");
                    if RecSalesCrMemo.FindFirst() then
                        Report.Run(50037, true, false, RecSalesCrMemo);
                end;
            }
        }
    }
    var
}
