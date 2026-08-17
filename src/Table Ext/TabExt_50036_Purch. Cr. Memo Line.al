tableextension 50036 "Purch. Cr. Memo Line QBA" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "cgst amt"; Decimal)
        {
            Caption = 'cgst amt';
            DataClassification = ToBeClassified;
        }
        field(50001; "Igst amt"; Decimal)
        {
            Caption = 'Igst amt';
            DataClassification = ToBeClassified;
        }
        field(50002; "cgst per"; Decimal)
        {
            Caption = 'cgst per';
            DataClassification = ToBeClassified;
        }
        field(50003; "Igst per"; Decimal)
        {
            Caption = 'Igst per';
            DataClassification = ToBeClassified;
        }
    }
}
