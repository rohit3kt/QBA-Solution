table 50001 "Total Selection Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Total Sales Lines';
    fields
    {
        field(1; Number; Integer)
        {
            Caption = 'Number';
            DataClassification = CustomerContent;
        }
        field(2; LinesConut; Integer)
        {
            Caption = 'Line Count';
            DataClassification = CustomerContent;
        }
        field(3; LinesAverage; Decimal)
        {
            Caption = 'Average';
            DecimalPlaces = 0 : 5;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(29; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
    }
    keys
    {
        key(PK; Number)
        {
            Clustered = true;
        }
    }
    var
        asasd: Record "Purchase Header";
}