pageextension 50111 "QBA Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Rounding Methods")
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
                    UserSetup_G: Record "User Setup";
                begin
                    UserSetup_G.Get(UserId);
                    if UserSetup_G."Special Permission" then
                        if Confirm('Do you want to delete All Sales Order Archive', true, '') then
                            QBACU.DeletSOArchive()
                        else
                            Message('Process Aborted');

                end;
            }
        }
        addafter(Category_Process)
        {
            actionref(DeletPOArchive_Promoted; DeletPOArchive)
            {
            }
        }
    }

    var
        myInt: Integer;
}