pageextension 50106 PurchaseOrderArchive extends "Purchase Order Archive"
{
    actions
    {
        addafter(Print)
        {
            // action(Print_2)
            // {
            //     Caption = 'Print';
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Process;
            //     ApplicationArea = all;
            //     Image = Print;

            //     trigger OnAction()
            //     begin
            //         recsalheader.Reset();
            //         recsalheader.SetRange("No.", Rec."No.");
            //         if recsalheader.FindFirst()then begin
            //             Report.Run(50038, true, false, recsalheader);
            //         end;
            //     end;
            // }
        }
        // modify(Print)
        // {
        //     Visible = false;
        // }
    }
    var
        recsalheader: Record 5109;
}
