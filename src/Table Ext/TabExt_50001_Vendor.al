tableextension 50001 Vendor extends Vendor
{
    fields
    {
        field(50000; "MSME No."; Code[20])
        {
            Caption = 'MSME No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "MSME Type"; Option)
        {
            Caption = 'MSME Type';
            DataClassification = ToBeClassified;
            OptionMembers = "", Small, Large, Medium;
        }
        field(50002; "MSME Vendor Type"; Option)
        {
            Caption = 'MSME Vendor Type';
            DataClassification = ToBeClassified;
            OptionMembers = "", Registered, Unregistered;
        }
    }
    var
    fhjfg:Record "Purchase Line";
}
