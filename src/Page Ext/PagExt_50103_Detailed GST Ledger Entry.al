pageextension 50103 GSTLedgerEntry extends "Detailed GST Ledger Entry"
{
    layout
    {
        addafter("GST Base Amount")
        {
        // field("CreditAmount"; Rec.cred) { ApplicationArea = all; Caption = 'Credit Amount'; }
        // field("DebitAmount"; Rec."Debit Amount") { ApplicationArea = all; Caption = 'Debit Amount'; }
        }
    }
}
