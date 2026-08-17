pageextension 50101 VendorLedgerEntries extends "Vendor Ledger Entries"
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
        addafter("Location GST Reg. No.")
        {
            field(Exported; Rec.Exported)
            {
                ApplicationArea = All;
                Editable = true;
                trigger OnValidate()
                var
                    Usersetup: Record "User Setup";
                begin
                    Usersetup.Get(UserId);
                    if not Usersetup."Special Permission" then
                        Error('You are not Authorize to Modify Vendor Ledger Entries');
                end;
            }
        }
    }
}
