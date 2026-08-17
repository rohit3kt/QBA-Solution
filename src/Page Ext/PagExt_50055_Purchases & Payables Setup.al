pageextension 50055 PurchasesPayablesSetup extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Background Posting")
        {
            group("Reverse Charge")
            {
                Caption = 'Reverse Charge';

                field("Reverse Charge VAT Posting Group"; Rec.ReverseChargeVATPostingGroup)
                {
                    ApplicationArea = all;
                }
                field("Domestic Vendors"; Rec."Domestic Vendors")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        addafter("Vendor Posting Groups")
        {
            action(DeletPOArchive)
            {
                ApplicationArea = All;
                Caption = 'Delete PO Archive';
                Image = Process;
                Ellipsis = true;
                trigger OnAction()
                var
                    QBACU: Codeunit "QBA Event Subscriber";
                    PurchaseLineArchive: Record "Purchase Line Archive";
                    PurchCommentLineArchive: Record "Purch. Comment Line Archive";
                    DeferralHeaderArchive: Record "Deferral Header Archive";
                    UserSetup_G: Record "User Setup";
                begin
                    // UserSetup_G.Get(UserId);
                    // if UserSetup_G."Special Permission" then begin
                    //     QBACU.DeletPOArchive();
                    //     Message('PO Archive Deleted');
                    // end else
                    //     Error('You are not authorized for this process');


                    UserSetup_G.Get(UserId);
                    if UserSetup_G."Special Permission" then
                        if Confirm('Do you want to delete All Purchase Order Archive', true, '') then
                            QBACU.DeletPOArchive()
                        else
                            Message('Process Aborted');



                end;
            }
        }
        addafter("Vendor Posting Groups_Promoted")
        {
            actionref(DeletPOArchive_Promoted; DeletPOArchive)
            {
            }
        }
    }
}
