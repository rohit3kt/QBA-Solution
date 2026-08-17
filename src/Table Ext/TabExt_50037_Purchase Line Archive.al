tableextension 50037 PurchaseLineArchive extends "Purchase Line Archive"
{
    fields
    {
        field(50000; "CGST amt"; Decimal)
        {
            Caption = 'CGST amt';
            DataClassification = ToBeClassified;
        }
        field(50001; "CGST Per"; Decimal)
        {
            Caption = 'CGST Per';
            DataClassification = ToBeClassified;
        }
        field(50002; "IGST amt"; Decimal)
        {
            Caption = 'IGST amt';
            DataClassification = ToBeClassified;
        }
        field(50003; "IGST per"; Decimal)
        {
            Caption = 'IGST per';
            DataClassification = ToBeClassified;
        }
    }
}
