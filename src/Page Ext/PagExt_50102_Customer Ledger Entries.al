pageextension 50102 CustLedgerEntries extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = all;
                Caption = 'Credit Amount';
            }
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = all;
                Caption = 'Debit Amount';
            }
        }
    }
    actions
    {
        addafter(ShowDocumentAttachment)
        {
            action(CreateCustLedgeEntry)
            {
                ApplicationArea = all;
                Caption = 'Create Cust. Ledge. Entry';
                Image = Create;
                Visible = false;

                trigger OnAction()
                var
                    QBAEventSubscriber: Codeunit "QBA Event Subscriber";
                begin
                    //QBAEventSubscriber.CreateCustLedgerEntry();   Worked on 9th January 2026
                end;
            }
        }
        addafter("Show Document_Promoted")
        {
            actionref(CreateCustLedgeEntry_Promoted; CreateCustLedgeEntry)
            {
            }
        }
    }
}
