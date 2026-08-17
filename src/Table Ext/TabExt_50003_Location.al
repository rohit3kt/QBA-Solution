tableextension 50003 Location extends Location
{
    fields
    {
        field(50000; CIN; code[25])
        {
            Caption = 'CIN';
            DataClassification = ToBeClassified;
        }
        field(50001; "MSME No."; Code[20])
        {
            Caption = 'MSME No.';
            DataClassification = ToBeClassified;
        }
        field(50002; "MSME Type"; Option)
        {
            Caption = 'MSME Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Small,Large,Medium;
        }
    }
}
