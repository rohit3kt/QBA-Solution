tableextension 50004 PurchaseHeader extends "Purchase Header"
{
    fields
    {
        field(50000; "Ship To"; text[50])
        {
            // OptionMembers = "","Default (Company Address)",Location,"Customer Address","Custom Address";
            Caption = 'Ship To';
            DataClassification = ToBeClassified;
        }
        field(50001; "Customer Code_"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Comments_New; text[500])
        {
            DataClassification = ToBeClassified;
        }
    }
}
