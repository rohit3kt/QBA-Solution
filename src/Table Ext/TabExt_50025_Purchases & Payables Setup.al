tableextension 50025 PurchasesPayablesSetup extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "ReverseChargeVATPostingGroup"; Code[25])
        {
            Caption = 'Reverse Charge VAT Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group".Code;
        }
        field(50001; "Domestic Vendors"; Code[20])
        {
            Caption = 'Domestic Vendors';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group".Code;
        }
    }
}
