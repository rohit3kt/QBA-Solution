pageextension 50067 VendorBankAccountCard extends "Vendor Bank Account Card"
{
    layout
    {
        modify("Bank Clearing Code")
        {
            Caption = 'IFSC Code';
        }
        addafter("Phone No.")
        {
            field("Beneficiary ID"; Rec."Beneficiary ID")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Name"; Rec."Beneficiary Name")
            {
                ApplicationArea = All;
            }
            field("Payment Mode"; Rec."Payment Mode")
            {
                ApplicationArea = All;
            }
        }
    }
}
