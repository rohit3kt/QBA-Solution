tableextension 50008 "QBA Currency" extends Currency
{
    fields
    {
        field(50100; "Currency Numeric Description"; Text[50])
        {
            Caption = 'Currency Numeric Description';
            DataClassification = ToBeClassified;
        }
        field(50101; "Currency Decimal Description"; Text[50])
        {
            Caption = 'Currency Decimal Description';
            DataClassification = ToBeClassified;
        }
    }
}