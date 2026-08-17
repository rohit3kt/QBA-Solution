pageextension 50096 PostedPurchaseCreditMemo extends "Posted Purchase Credit Memo"
{
    actions
    {
        addafter("&Navigate")
        {
            action(Print2)
            {
                Caption = 'Print Credit Note';
                Promoted = true;
                PromotedIsBig = true;
                Image = Print;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    reccred.Reset();
                    reccred.SetRange("No.", Rec."No.");
                    if reccred.FindFirst() then
                        Report.Run(50037, true, false, reccred);
                end;
            }
        }
        modify("&Print")
        {
            Visible = false;
        }
    }
    var
        reccred: Record "Purch. Cr. Memo Hdr.";
}
