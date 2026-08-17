tableextension 50032 SalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "CGST Amt"; Decimal)
        {
            Caption = 'CGST Amt';
            DataClassification = ToBeClassified;
        }
        field(50001; "SGST Amt"; Decimal)
        {
            Caption = 'SGST Amt';
            DataClassification = ToBeClassified;
        }
        field(50002; "IGST Amt"; Decimal)
        {
            Caption = 'IGST Amt';
            DataClassification = ToBeClassified;
        }
        field(50003; "IGST per"; Decimal)
        {
            Caption = 'IGST Per';
            DataClassification = ToBeClassified;
        }
        field(50004; "CGST per"; Decimal)
        {
            Caption = 'CGST Per';
            DataClassification = ToBeClassified;
        }
        field(50005; "SGST per"; Decimal)
        {
            Caption = 'SGST Per';
            DataClassification = ToBeClassified;
        }
    }
}
