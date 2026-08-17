tableextension 50005 SalesHeader extends "Sales Header"
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
        field(50002; "IEC No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'IEC No.';
        //Editable = true;
        }
    }
}
